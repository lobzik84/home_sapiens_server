/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.tunnel.server;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import org.lobzik.home_sapiens.server.AuthTokenStorage;
import org.lobzik.home_sapiens.server.CommonData;
import org.lobzik.home_sapiens.server.entity.AuthToken;

/**
 *
 * @author lobzik
 */
@WebServlet(name = "TunnelServlet", urlPatterns = {"/tun"})
public class TunnelServlet extends HttpServlet {

    private static final String challengeAlphabet = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "tunnel servlet";
    }

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
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json");
            //request.getReader();
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

            System.out.println(requestString);
            if (requestString.startsWith("{")) {
                JSONObject json = new JSONObject(requestString);

                if (json.has("device_auth_token")) {
                    if (CommonData.authTokenStorage.hasValidToken(json.getString("device_auth_token"))) {
                        //authenticated 
                        CommonData.authTokenStorage.getToken(json.getString("device_auth_token")).refresh();

                    }
                    else  if (json.has("challenge_response")) { 
                        //authentication response
                        String challengeResponse = json.getString("challenge_response");
                        if (challengeResponse.length() == 64) { //TODO check
                            AuthToken token = new AuthToken();
                            CommonData.authTokenStorage.add(token);
                        }
                    }
                }
            } else {
                JSONObject responseJson = new JSONObject();
                String challenge = generateChallenge();
                responseJson.put("challenge", challenge);
                response.getWriter().write(responseJson.toString());
                //request auth
                //generate challenge, get uid, store it with ttl
                //check challenge, generate token with ttl, send token
                //store phone_num
            }
        } catch (Throwable t) {
            t.printStackTrace();
        }
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

    private static String generateChallenge() {
        StringBuffer challenge = new StringBuffer();
        for (int i = 0; i < 16; i++) {
            char ch = challengeAlphabet.charAt((int) Math.round(Math.random() * challengeAlphabet.length()));
            challenge.append(ch);
        }
        return challenge.toString();
    }
}
