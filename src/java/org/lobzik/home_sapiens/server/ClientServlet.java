/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import org.lobzik.home_sapiens.server.entity.Box;
import org.lobzik.tools.db.postgresql.DBSelect;
import org.lobzik.tools.db.postgresql.DBTools;

/**
 *
 * @author lobzik
 */
@WebServlet(name = "ClientServlet", urlPatterns = {"/hs", "/hs/*"})
public class ClientServlet extends HttpServlet {

    private static final String challengeAlphabet = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        InputStream is = request.getInputStream();
        long readed = 0;
        long content_length = request.getContentLength();
        byte[] bytes = new byte[65536];
        while (readed < content_length) {
            int r = is.read(bytes);
            if (r < 0) {
                break;
            }
            baos.write(bytes, 0, r);
            readed += r;
        }
        baos.close();
        String requestString = baos.toString("UTF-8");

        if (session.getAttribute("user") != null) {
            //authenticated
        } else if (requestString.startsWith("{")) {
            JSONObject json = new JSONObject(requestString);
            if (json.has("user_id")) { //challenge-RSA
                JSONObject responseJson = new JSONObject();
                String challenge = generateChallenge();
                responseJson.put("challenge", challenge);
                response.getWriter().write(responseJson.toString());
            } else if (json.has("login")) { //SRP-6a
                JSONObject responseJson = new JSONObject();
                String salt = "";//get salt
                responseJson.put("salt", salt);
                response.getWriter().write(responseJson.toString());
            }
            //two ways of user authentication: either user uses ID-challenge-RSA

        } else {
            Connection conn = null;
            try {
                conn = DBTools.openConnection(CommonData.dataSourceName);
                long boxCnt = DBSelect.getCount("select count(*) as box_cnt from boxes;", "box_cnt", null, conn);
                PrintWriter out = response.getWriter();
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Home Sapiens</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Hello!</h1>");
                out.println("<p>" + boxCnt +" devices registered already!</p>");
                
                out.println("</body>");
                out.println("</html>");
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                DBTools.closeConnection(conn);
            }
        }

    }

    private static String generateChallenge() {
        StringBuffer challenge = new StringBuffer();
        for (int i = 0; i < 16; i++) {
            char ch = challengeAlphabet.charAt((int) Math.round(Math.random() * challengeAlphabet.length()));
            challenge.append(ch);
        }
        return challenge.toString();
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
