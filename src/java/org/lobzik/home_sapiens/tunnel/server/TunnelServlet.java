/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.tunnel.server;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.lobzik.home_sapiens.server.CommonData;
import org.lobzik.home_sapiens.entity.AuthToken;
import org.lobzik.home_sapiens.entity.Box;
import org.lobzik.tools.db.postgresql.DBSelect;
import org.lobzik.tools.db.postgresql.DBTools;

/**
 *
 * @author lobzik
 */
@WebServlet(name = "TunnelServlet", urlPatterns = {"/tun"})
public class TunnelServlet extends HttpServlet {

    private static final String DEVELOPMENT_NETWORK = "192.168.12";

    private static final String challengeAlphabet = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

    private final Logger log = Logger.getLogger(this.getClass());

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
                if (!json.has("action")) {
                    return;
                }
                JSONObject responseJson = new JSONObject();
                String action = json.getString("action");
                switch (action) {

                    case "register_request":
                        if (!json.has("box_data") || !request.getRemoteAddr().startsWith(DEVELOPMENT_NETWORK)) {
                            return;
                        }
                        JSONObject boxJson = json.getJSONObject("box_data");
                        Connection conn = DBTools.openConnection(CommonData.dataSourceName);

                        try {
                            Box newBox = new Box(boxJson);
                            int boxId = DBTools.insertRow("boxes", newBox.getMap(), conn);
                            responseJson.put("register_result", "success");
                            responseJson.put("box_id", boxId);
                            log.info("Registered new Box: ");

                        } catch (Exception e) {
                            log.error("Error while registering box: " + e.getMessage());
                            responseJson.put("register_result", "error");
                        } finally {
                            DBTools.closeConnection(conn);
                        }
                        response.getWriter().write(responseJson.toString());
                        break;

                    case "auth_request":
                        if (!json.has("box_data")) {
                            return;
                        }
                        boxJson = json.getJSONObject("box_data");
                        conn = DBTools.openConnection(CommonData.dataSourceName);
                        try {
                            String sSQL = "select id, public_key from boxes where id=" + boxJson.getInt("id");
                            List<HashMap> resList = DBSelect.getRows(sSQL, conn);
                            if (resList.size() != 1) {
                                return;
                            }
                        } catch (Exception e) {

                        } finally {
                            DBTools.closeConnection(conn);
                        }

                        String challenge = generateChallenge();
                        CommonData.challengeStorage.put(boxJson.getInt("id"), challenge);
                        responseJson.put("challenge", challenge);
                        response.getWriter().write(responseJson.toString());
                        break;

                    case "auth_challenge":
                        if (json.has("box_data") && json.has("device_auth_token") && json.has("challenge_response")) {
                            boxJson = json.getJSONObject("box_data");
                            challenge = CommonData.challengeStorage.get(boxJson.getInt("id"));
                            conn = DBTools.openConnection(CommonData.dataSourceName);
                            try {
                                String challengeResponse = json.getString("challenge_response");
                                String sSQL = "select id, public_key from boxes where id=" + boxJson.getInt("id");
                                List<HashMap> resList = DBSelect.getRows(sSQL, conn);
                                if (resList.size() != 1) {
                                    return;
                                }
                                String publicKey = (String) resList.get(0).get("public_key");
                                String calculatedChallengeResponse = challengeResponse; //TODO calculate RSA

                                if (challengeResponse.length() == 64 && calculatedChallengeResponse.equals(challengeResponse)) {
                                    AuthToken token = new AuthToken();
                                    CommonData.boxAuthTokenStorage.add(token);
                                }
                                CommonData.boxAuthTokenStorage.getToken(json.getString("device_auth_token")).refresh();

                            } catch (Exception e) {

                            } finally {
                                DBTools.closeConnection(conn);
                            }

                        } else {
                            return;
                        }
                        break;
                    case "user_register":
                        if (json.has("user_data") && json.has("device_auth_token") && CommonData.boxAuthTokenStorage.hasValidToken(json.getString("device_auth_token"))) {
                            CommonData.boxAuthTokenStorage.getToken(json.getString("device_auth_token")).refresh();
                            //TODO

                        } else {
                            return;
                        }
                        break;

                    case "sensors_update":
                        if (json.has("sensors_data") && json.has("device_auth_token") && CommonData.boxAuthTokenStorage.hasValidToken(json.getString("device_auth_token"))) {
                            CommonData.boxAuthTokenStorage.getToken(json.getString("device_auth_token")).refresh();
                            //TODO

                        } else {
                            return;
                        }
                        break;

                    default:
                        break;
                }

            } else {
                response.getWriter().write("Only JSON accepted");
            }
        } catch (Throwable t) {
            log.error(t.getMessage());
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
