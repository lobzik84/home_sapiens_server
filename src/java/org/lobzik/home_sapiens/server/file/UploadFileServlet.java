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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.lobzik.tools.Tools;

/**
 *
 * @author lobzik
 */
@WebServlet(name = "UploadFileServlet", urlPatterns = {"/upload", "/upload/*", "/uploadfile", "/uploadfile/*"})
public class UploadFileServlet extends HttpServlet {

	//FileTools fileTools = SysCommonData.fileTools;
 String workDir = "/opt/oracle/storage/hs/";
	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/xml");
		try {
			handleMyUpload(request, response);
		} catch (Exception e) {
			e.printStackTrace((response.getWriter()));
		}
	}

	private void handleMyUpload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (request.getMethod().equalsIgnoreCase("post")) {
			String[] a = request.getPathInfo().split("/");
			String filename = a[a.length - 1];
			int pos = Tools.parseInt(request.getParameter("f"), -1);
			boolean done = "true".equals(request.getParameter("done"));
			String fileSession = (String) request.getSession().getAttribute("fileUploadSession");
			if (filename != null && pos >= 0) {
				filename = URLDecoder.decode(filename, "UTF-8");
				if (pos == 0) {
					File old = new File(workDir + filename);//File old = fileTools.getFile(filename);
					File tmp = new File(workDir + filename + ".tmp");//File tmp = fileTools.getFile(filename + "." + fileTools.getTempExtension());
					if (old.exists() || tmp.exists()) {
						response.sendError(500, "Cannot start upload - file exists");
						return;
					} else {
						request.getSession().setAttribute("fileUploadSession", filename);
					}
				} else {
					if (!filename.equals(fileSession)) {
						response.sendError(500, "Cannot upload - invalid upload session");
						return;
					}

				}
				File tmp = new File(workDir + filename + ".tmp");//fileTools.getFile(filename + "." + fileTools.getTempExtension());
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
			} else if (filename != null && done) {
				filename = URLDecoder.decode(filename, "UTF-8");
				request.getSession().removeAttribute("fileUploadSession");
                                File tmp = new File(workDir + filename + ".tmp");
                                tmp.renameTo(new File(workDir + filename));
				//fileTools.removeTempExt(filename);
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
