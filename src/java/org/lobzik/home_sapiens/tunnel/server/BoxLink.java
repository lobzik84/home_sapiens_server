/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.tunnel.server;

import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.atomic.AtomicBoolean;
import javax.websocket.MessageHandler;
import javax.websocket.Session;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.lobzik.home_sapiens.server.CommonData;
import org.lobzik.home_sapiens.server.control.DBWorker;

/**
 *
 * @author lobzik
 */
public class BoxLink {

    public String JSessionId;

    private Queue<BoxDialog> queue = new ConcurrentLinkedQueue();

    public static final long QUEUE_TIMEOUT = 30 * 1000l;

    public static final long RESPONSE_TIMEOUT = 30 * 1000l;

    public AtomicBoolean busy = new AtomicBoolean(false);

    public STATUS status = STATUS.OFFLINE;

    public long lastDataRevieved;

    public Session session;

    private Logger log;

    public String remoteAddr;

    public enum STATUS {
        OFFLINE,
        AUTHENTICATING,
        ONLINE,
        TIMEOUT

    }

    public BoxLink(Session session, Logger log, String remoteAddr) {
        this.session = session;
        this.log = log;
        this.remoteAddr = remoteAddr;
        log.info("Box connected from " + remoteAddr);
        for (MessageHandler mh : session.getMessageHandlers()) {
            session.removeMessageHandler(mh);
        }

        session.addMessageHandler(new MessageHandler.Whole<String>() {
            @Override
            public void onMessage(String message) {
                lastDataRevieved = System.currentTimeMillis();

                try {
                    if (message.startsWith("{")) {
                        JSONObject json = new JSONObject(message);
                        if (json.has("result")) {
                            responseRecieved(json);
                        } else if (json.has("action") && json.getString("action").equals("user_data_upload")) {
                            log.info("Registering user: " + json.get("id"));
                            JSONObject response = new JSONObject();
                            try {
                                DBWorker.updateUser(json);
                                response.put("box_session_key", json.get("box_session_key"));
                                response.put("box_id", json.get("box_id"));
                                response.put("user_id", json.get("id"));
                                response.put("result", "user_update_success");

                            } catch (Exception e) {
                                response.put("result", "error");
                                response.put("message", e.getMessage());
                                log.error(e.getMessage());
                            }

                            session.getBasicRemote().sendText(response.toString());
                        } else if (json.has("action") && json.getString("action").equals("send_email")) {
                            if (json.has("mail_to") && json.has("mail_text") && json.has("mail_subject")) {
                                JSONObject response = new JSONObject();
                                try {
                                    String mailTo = json.getString("mail_to");
                                    String mailText = json.getString("mail_text");
                                    String mailSubject = json.getString("mail_subject");
                                    CommonData.mailer.send(mailSubject, mailText, mailTo, true, true);
                                    response.put("result", "mail_sent_success");
                                } catch (Exception e) {
                                    response.put("result", "error");
                                    response.put("message", e.getMessage());
                                    log.error(e.getMessage());
                                }
                                session.getBasicRemote().sendText(response.toString());
                            }
                        }
                    } else if (message.equals("tt")) {
                        session.getBasicRemote().sendText("ok");
                    }
                    //log.debug("Received message length: " + message.length());
                } catch (Exception e) {
                    e.printStackTrace();
                    log.error(e.getMessage());
                }
            }
        });
        status = STATUS.ONLINE;
    }

    public void resumeNext() {
        BoxDialog dialog = queue.peek();
        if (dialog != null) {
            // System.out.println("resuming id=" + dialog.id + " size=" + queue.size());
            dialog.resume();
        }
    }

    public JSONObject ask(JSONObject request) throws Exception {
        BoxDialog dialog = new BoxDialog(request);
        queue.add(dialog);
        dialog.doDialog(this);
        dialog = queue.poll();
        resumeNext();
        return dialog.responseJson;
    }

    public void responseRecieved(JSONObject response) throws Exception {
        BoxDialog dialog = queue.peek();
        if (dialog != null) {
            dialog.gotResponse(response);
        }
    }

    public void destroy() {
        log.info("Disconnecting box");
        for (MessageHandler mh : session.getMessageHandlers()) {
            try {
                session.removeMessageHandler(mh);
            } catch (Exception e) {
            }
        }
        try {
            session.close();
        } catch (Exception e) {
        }
        status = STATUS.OFFLINE;
    }

}
