/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.PublicKey;
import java.security.Signature;
import java.security.spec.RSAPublicKeySpec;
import java.sql.Connection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.lobzik.home_sapiens.entity.UsersSession;
import org.lobzik.home_sapiens.tunnel.server.BoxRequestHandler;
import org.lobzik.tools.Tools;
import org.lobzik.tools.db.postgresql.DBSelect;
import org.lobzik.tools.db.postgresql.DBTools;

/**
 *
 * @author lobzik
 */
@WebServlet(name = "ClientServlet", urlPatterns = {"/json", "/json/*"})
public class ClientServlet extends HttpServlet {

    private static final BigInteger G = new BigInteger("2");
    private static final BigInteger N = new BigInteger("115b8b692e0e045692cf280b436735c77a5a9e8a9e7ed56c965f87db5b2a2ece3", 16);
    private static final BigInteger K = new BigInteger("c46d46600d87fef149bd79b81119842f3c20241fda67d06ef412d8f6d9479c58", 16);
    private static final String SALT_ALPHABET = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String FAKE_SALT_KEY = "mri9gjn0990)M09V^&DF&*GR^%^WTioh89t;";
    private static final String SERVLET_NAME = "Client servlet";
    private static final Logger log = Logger.getLogger(SERVLET_NAME);

    static {
        try {
            log.addAppender(ConnJDBCAppender.getServerAppender(DBTools.getDataSource(CommonData.dataSourceName)));
        } catch (Exception e) {
            e.printStackTrace();
        }
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, PUT");
        //response.setHeader("Access-Control-Allow-Credentials", "true");  

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

        try {
            if (requestString.startsWith("{")) {
                JSONObject json = new JSONObject(requestString);
                request.setAttribute("json", json);
                int userId = 0;
                int boxId = 0;
                if (json.has("session_key")) {
                    String session_key = json.getString("session_key");
                    UsersSession session = CommonData.userSessions.get(session_key);
                    if (session != null) {
                        userId = Tools.parseInt(session.get("UserId"), 0);
                        boxId = Tools.parseInt(session.get("BoxId"), 0);
                    }
                }
                String action = json.getString("action");
                switch (action) {
                    case "check":
                        doRequestLogin(request, response);
                        break;

                    case "handshake_srp":
                        handshakeUserSRP(request, response);
                        break;

                    case "login_srp":
                        loginUserSRP(request, response);
                        break;

                    case "login_rsa":
                        loginUserRSA(request, response);
                        break;

                    case "kf_download":
                        if (userId > 0) {
                            downloadKeyFile(userId, boxId, request, response);
                        } else {
                            doRequestLogin(request, response);
                        }
                        break;

                    default:
                        if (userId > 0 && boxId > 0) {
                            handleToBox(userId, boxId, request, response);
                        } else {
                            doRequestLogin(request, response);
                        }
                }
            } else {
                response.getWriter().print("accepted json only");
            }
        } catch (Throwable e) {
            e.printStackTrace();
            log.error(e);
            response.getWriter().print("{\"result\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
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

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return SERVLET_NAME;
    }// </editor-fold>

    private void handleToBox(int userId, int boxId, HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject json = (JSONObject) request.getAttribute("json");
        JSONObject boxResponse = BoxRequestHandler.getInstance().handleToBox(userId, boxId, json);
        boxResponse.put("session_key", json.getString("session_key"));
        response.getWriter().print(boxResponse);

    }

    private void downloadKeyFile(int userId, int boxId, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String sSQL = "select id, keyfile from users where status = 1 and user_id = " + userId + " and box_id = " + boxId;
        try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
            List<HashMap> resList = DBSelect.getRows(sSQL, conn);
            if (resList.isEmpty()) {
                throw new Exception("User id=" + userId + " with box id = " + boxId + "not found");
            }
            HashMap userMap = resList.get(0);
            JSONObject json = new JSONObject();
            json.put("result", "success");
            json.put("kfCipher", (String) userMap.get("keyfile"));
            response.getWriter().print(json.toString());
        }
    }

    private void loginUserRSA(HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject json = (JSONObject) request.getAttribute("json");
        UsersSession session = null;
        if (json.has("session_key")) {
            String session_key = json.getString("session_key");
            session = CommonData.userSessions.get(session_key);
        }
        if (session == null) {
            return;
        }
        String challenge = (String) session.get("challenge");
        int userId = Tools.parseInt(json.get("user_id"), 0);
        int boxId = Tools.parseInt(json.get("box_id"), 0);
        String digest = json.getString("digest");
        String sSQL = "select user_id, public_key from users where status = 1 and user_id=" + userId + " and box_id = " + boxId;
        try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
            List<HashMap> resList = DBSelect.getRows(sSQL, conn);
            String publicKey = (String) resList.get(0).get("public_key");
            BigInteger modulus = new BigInteger(publicKey, 16);
            RSAPublicKeySpec spec = new RSAPublicKeySpec(modulus, CommonData.RSA_E);
            KeyFactory factory = KeyFactory.getInstance("RSA");
            PublicKey usersPublicKey = factory.generatePublic(spec);
            Signature verifier = Signature.getInstance("SHA256withRSA");
            verifier.initVerify(usersPublicKey);
            verifier.update(challenge.getBytes("UTF-8"));
            boolean valid = verifier.verify(Tools.toByteArray(digest));
            json = new JSONObject();
            if (valid) {
                session.put("UsersPublicKey", usersPublicKey);
                session.put("UserId", userId);
                session.put("BoxId", boxId);
                json.put("user_id", userId);
                json.put("box_id", userId);
                json.put("result", "success");
                log.info("RSA LOGIN OK! UserId=" + userId + ", IP " + ServerTools.getProxyIP(request));
            } else {
                log.error("RSA Login error! UserId=" + userId + ", IP " + ServerTools.getProxyIP(request));
                json.put("result", "error");
                json.put("message", "Login using RSA digest failed");
            }
            response.getWriter().print(json.toString());
        }
    }

    private void handshakeUserSRP(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String sSQL = "select salt, verifier from users where status = 1 and login=?;";
        JSONObject json = (JSONObject) request.getAttribute("json");
        if (!json.has("login") || !json.has("srp_A")) {
            return;
        }
        try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
            String login = json.getString("login");
            List params = new LinkedList();
            params.add(login);
            List<HashMap> resList = DBSelect.getRows(sSQL, params, conn);
            String salt;
            BigInteger v;
            if (resList.size() > 0) {
                salt = (String) resList.get(0).get("salt"); //TODO if two or more boxes selected - choose one
                v = new BigInteger((String) resList.get(0).get("verifier"), 16);
            } else {
                salt = ""; //если нету такого юзера в БД, нельзя это показать пытающемуся зайти. Так что на основе введённого логина генерируем "поддельную" соль и отдаём.
                BigInteger fakeSaltNum = sha256(login + FAKE_SALT_KEY);
                v = sha256(FAKE_SALT_KEY + login + FAKE_SALT_KEY);//new BigInteger(64, new Random());
                for (int i = 0; i < 16; i++) {
                    salt += SALT_ALPHABET.charAt(fakeSaltNum.mod(new BigInteger("" + SALT_ALPHABET.length())).intValue());
                    fakeSaltNum = fakeSaltNum.divide(new BigInteger("" + SALT_ALPHABET.length()));
                }
            }
            BigInteger A = new BigInteger(json.getString("srp_A"), 16);
            BigInteger b = null;
            BigInteger B = BigInteger.ZERO;
            BigInteger u = null;
            while (true) {
                b = new BigInteger(32, new Random());
                B = (K.multiply(v)).add(G.modPow(b, N));
                u = sha256(A.toString(16) + B.toString(16));

                if ((B.remainder(N).intValue() != 0) && (u.remainder(N).intValue() != 0)) {
                    break;
                }
            }
            BigInteger S = ((v.modPow(u, N)).multiply(A)).modPow(b, N);
            BigInteger M = sha256(A.toString(16) + B.toString(16) + S.toString(16));
            json = new JSONObject();
            if (A.remainder(N).intValue() == 0) {
                json.put("result", "error");
                json.put("message", "Invalid ephemeral key");
            } else {
                String session_key = CommonData.userSessions.createSession();
                UsersSession session = CommonData.userSessions.get(session_key);
                session.put("srp_S", S.toString(16));
                session.put("srp_M", M.toString(16));
                session.put("srp_A", A.toString(16));
                session.put("srp_login", login);
                json.put("result", "success");
                json.put("srp_B", B.toString(16));
                json.put("salt", salt);
                json.put("session_key", session_key);

            }

            response.getWriter().print(json.toString());

        }
    }

    private void loginUserSRP(HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject json = (JSONObject) request.getAttribute("json");
        UsersSession session = null;
        if (json.has("session_key")) {
            String session_key = json.getString("session_key");
            session = CommonData.userSessions.get(session_key);
        }
        if (session == null) {
            return;
        }
        String Astr = (String) session.remove("srp_A");
        String Mstr = (String) session.remove("srp_M");
        String Sstr = (String) session.remove("srp_S");
        String username = (String) session.remove("srp_login");

        BigInteger A = new BigInteger(Astr, 16);
        BigInteger M = new BigInteger(Mstr, 16);
        BigInteger S = new BigInteger(Sstr, 16);

        String M_client = json.getString("srp_M");
        json = new JSONObject();
        if (M_client.equals(Mstr)) {

            String sSQL = "select user_id, box_id, salt, verifier, public_key from users where status = 1 and login=?;";
            List params = new LinkedList();
            params.add(username);
            try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
                List<HashMap> resList = DBSelect.getRows(sSQL, params, conn);
                if (resList.size() > 0) {
                    M = sha256(A.toString(16) + M.toString(16) + S.toString(16));
                    int userId = Tools.parseInt(resList.get(0).get("user_id"), 0);
                    int boxId = Tools.parseInt(resList.get(0).get("box_id"), 0);
                    String publicKey = (String) resList.get(0).get("public_key");
                    BigInteger modulus = new BigInteger(publicKey, 16);
                    RSAPublicKeySpec spec = new RSAPublicKeySpec(modulus, CommonData.RSA_E);
                    KeyFactory factory = KeyFactory.getInstance("RSA");
                    PublicKey usersPublicKey = factory.generatePublic(spec);
                    session.put("UsersPublicKey", usersPublicKey);
                    session.put("UserId", userId);
                    session.put("BoxId", boxId);

                    json.put("user_id", userId);
                    json.put("box_id", boxId);
                    json.put("result", "success");
                    json.put("srp_M", M.toString(16));
                    log.info("SRP LOGIN OK! UserId=" + userId + ", IP " + ServerTools.getProxyIP(request));
                }
            }
        } else {
            log.error("SRP Login error for user " + username + ", IP " + ServerTools.getProxyIP(request));
            json.put("result", "error");
            json.put("message", "Invalid login or password");
        }
        response.getWriter().print(json.toString());
    }

    private void doRequestLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {

        JSONObject json = new JSONObject();
        String session_key = CommonData.userSessions.createSession();
        UsersSession session = CommonData.userSessions.get(session_key);
        String challenge = new BigInteger(32, new Random()).toString(16);
        session.put("challenge", challenge);
        json.put("result", "do_login");
        json.put("challenge", challenge);
        json.put("session_key", session_key);
        json.put("message", "please login");

        response.getWriter().print(json.toString());

    }

    private BigInteger sha256(String s) throws Exception {
        MessageDigest sha = MessageDigest.getInstance("SHA-256");
        byte[] bytes = s.getBytes();
        sha.update(bytes, 0, bytes.length);
        return new BigInteger(1, sha.digest());
    }

}
