/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.tunnel.server;

import java.io.IOException;
import java.math.BigInteger;
import java.security.PublicKey;
import java.security.Signature;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import org.json.JSONObject;
import org.lobzik.home_sapiens.entity.Box;
import org.lobzik.home_sapiens.entity.UsersSession;
import org.lobzik.home_sapiens.server.CommonData;
import org.lobzik.tools.RSATools;
import org.lobzik.tools.Tools;
import org.lobzik.tools.db.postgresql.DBSelect;
import org.lobzik.tools.db.postgresql.DBTools;

/**
 *
 * @author lobzik
 */
@ServerEndpoint("/wss/")
public class TunnelWSEndpoint {

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) throws IOException {

        requestLogin(session);
    }

    @OnMessage
    public String onMessage(String message) {
        try {
            if (message != null && message.startsWith("{")) {
                JSONObject json = new JSONObject(message);
                if (json.has("box_session_key") && json.has("box_id") && json.has("digest")) {
                    int boxId = json.getInt("box_id");
                    String session_key = json.getString("box_session_key");
                    UsersSession boxSession = CommonData.boxSessions.get(session_key);
                    String challenge = (String) boxSession.get("challenge");
                    String digest = json.getString("digest");
                    Session wsSession = (Session) boxSession.get("ws_session");
                    try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
                        String sSQL = "select * from boxes where id=" + boxId;
                        List<HashMap> boxList = DBSelect.getRows(sSQL, conn);
                        if (boxList.isEmpty()) {
                            throw new Exception("Box not found! id=" + boxId);
                        }
                        Box box = new Box(boxList.get(0));
                        PublicKey publicKey = RSATools.getPublicKey(box.publicKey);
                        Signature verifier = Signature.getInstance("SHA256withRSA");
                        verifier.initVerify(publicKey);
                        verifier.update(challenge.getBytes("UTF-8"));
                        json = new JSONObject();
                        json.put("box_session_key", session_key);
                        boolean valid = verifier.verify(Tools.toByteArray(digest));
                        if (valid) {
                            BoxRequestHandler.getInstance().boxConnected(box, wsSession); //messageHandler should be switched now - this one is not called anymore,

                            // now BoxRequestHandler has personal MessageHandler for this box
                            json.put("result", "success_login");
                            ServletRequest servletrequest = (ServletRequest)boxSession.get(ServletRequest.class.getName());
                            System.out.println("Box " + box.id + " connected from " ); //TODO figure out client IP somehow
                            if (servletrequest != null) System.out.println(servletrequest.getRemoteAddr());
                        } else {

                            String errMessage = "digest verification error";
                            json.put("result", "login_error");
                            json.put("message", errMessage);
                            System.err.println("Box " + box.id + " " + errMessage);
                        }
                        wsSession.getBasicRemote().sendText(json.toString());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void requestLogin(Session session) throws IOException {
        JSONObject json = new JSONObject();
        String session_key = CommonData.boxSessions.createSession();
        UsersSession boxSession = CommonData.boxSessions.get(session_key);
        String challenge = new BigInteger(32, new Random()).toString(16);
        boxSession.put("challenge", challenge);
        boxSession.put("ws_session", session);
        json.put("result", "do_login");
        json.put("challenge", challenge);
        json.put("box_session_key", session_key);
        json.put("message", "please login");
        session.getBasicRemote().sendText(json.toString());

    }
}
