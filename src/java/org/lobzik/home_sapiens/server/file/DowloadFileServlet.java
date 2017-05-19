/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server.file;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
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
@WebServlet(name = "DowloadFileServlet", urlPatterns = {"/download", "/download/*", "/dowloadfile", "/dowloadfile/*"})

public class DowloadFileServlet extends HttpServlet {

	//FileTools fileTools = SysCommonData.fileTools;
        String workDir = "/home/lobzik/Temp/hs_bkp_files/";
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
			handleMyDownload(request, response);
		} catch (Exception e) {
			e.printStackTrace((response.getWriter()));
		}
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Сервлет для загрузки зашифрованных файлов с сервера";
	}

	private void handleMyDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("application/octet-stream");
		if (request.getMethod().equalsIgnoreCase("get")) {
			int pos = Tools.parseInt(request.getParameter("f"), -1);
			int size = Tools.parseInt(request.getParameter("c"), -1);
			String[] a = request.getPathInfo().split("/");
			String filename = a[a.length - 1];
			if (filename == null || pos < 0) {
				return;
			}
			filename = URLDecoder.decode(filename, "UTF-8");
			File file = new File(workDir + filename);//fileTools.getFile(filename);
			if (!file.exists()) {
				response.sendError(500, "Cannot download - file not found");
				return;
			}

			if (pos > file.length()) {
				response.sendError(500, "Cannot download - file too short");
			}

			RandomAccessFile raf = new RandomAccessFile(file.getAbsolutePath(), "rw");
			//Save to file
			raf.seek(pos);
			OutputStream os = response.getOutputStream();
			long readed = 0;

			byte[] bytes = new byte[size];
			while (readed < size) {
				int r = raf.read(bytes);
				if (r < 0) {
					break;
				}
				os.write(bytes, 0, r);
				readed += r;
			}

			raf.close();
			os.flush();
			os.close();
		}

	}
}