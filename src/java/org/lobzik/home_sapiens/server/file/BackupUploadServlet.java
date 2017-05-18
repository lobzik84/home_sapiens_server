/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server.file;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.util.Date;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.lobzik.home_sapiens.entity.UsersSession;
import org.lobzik.home_sapiens.server.CommonData;
import org.lobzik.home_sapiens.tunnel.server.BoxLink;
import org.lobzik.home_sapiens.tunnel.server.BoxRequestHandler;
import org.lobzik.tools.Tools;
import org.lobzik.tools.db.postgresql.DBTools;

/**
 *
 * @author lobzik
 */
@WebServlet(name = "BackupUploadServlet", urlPatterns = {"/bkp/*"})
public class BackupUploadServlet extends HttpServlet {

    public static final String UPLOAD_DIR = "/home/lobzik/Temp/hs_bkp_files/";
    public static final String TEMP_EXT = ".tmp";

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/xml");
        try {
            handleMyUpload(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void handleMyUpload(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getMethod().equalsIgnoreCase("post")) {
            String[] a = request.getPathInfo().split("/");
            String filename = a[a.length - 1];
            int pos = Tools.parseInt(request.getParameter("f"), -1);
            boolean done = "true".equals(request.getParameter("done"));
            int bp = filename.indexOf("_boxId_") + 7;
            int boxId = Tools.parseInt(filename.substring(bp, filename.indexOf("_", bp)), 0);
            if (boxId == 0) {
                response.sendError(500, "Cannot upload - invalid box id");
                return;
            }
            String boxSessionS = request.getParameter("s");
            UsersSession boxSession = CommonData.boxSessions.get(boxSessionS);
            if (boxSession == null) {
                response.sendError(500, "Cannot upload - invalid box session");
                return;
            }
            BoxLink boxLink = BoxRequestHandler.getBoxLink(boxId);
            Logger boxLog = boxLink.getLog();
            if (pos ==0) {
                
                String keyCipher = request.getParameter("kc");
                HashMap dbMap = new HashMap();
                dbMap.put("box_id", boxId);
                dbMap.put("filename", filename);
                dbMap.put("keycipher", keyCipher);
                dbMap.put("date", new Date());
                try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
                    int  bkpFileId = DBTools.insertRow("backup_files", dbMap, conn);
                    boxLog.info("Begin backup downloading from box, saving to file id=" + bkpFileId);
                }
                
            }
            if (filename != null && pos >= 0) {
                filename = URLDecoder.decode(filename, "UTF-8");
                if (pos == 0) {
                    File old = new File(UPLOAD_DIR + filename);
                    File tmp = new File(UPLOAD_DIR + filename + TEMP_EXT);
                    if (old.exists() || tmp.exists()) {
                        response.sendError(500, "Cannot start upload - file exists");
                        return;
                    } else {
                        request.getSession().setAttribute("fileUploadSession", filename);
                    }
                }

                File tmp = new File(UPLOAD_DIR + filename + TEMP_EXT);
                RandomAccessFile raf = new RandomAccessFile(tmp.getAbsolutePath(), "rw");
                //Save to file
                raf.seek(pos);
                InputStream is = request.getInputStream();
                long readed = 0;
                long content_length = request.getContentLength();
                byte[] bytes = new byte[65536];
                while (readed < content_length) {
                    int r = is.read(bytes);
                    if (r < 0) {
                        break;
                    }
                    raf.write(bytes, 0, r);
                    readed += r;
                }

                raf.close();
            } 
            if (done) {
                boxLog.info("Done backup!");
                filename = URLDecoder.decode(filename, "UTF-8");
                request.getSession().removeAttribute("fileUploadSession");
                Path src = Paths.get(UPLOAD_DIR + filename + TEMP_EXT);
                Path dst = Paths.get(UPLOAD_DIR + filename);

                Files.move(src, dst, StandardCopyOption.ATOMIC_MOVE, StandardCopyOption.REPLACE_EXISTING);

            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
