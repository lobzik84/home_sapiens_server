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
import org.json.JSONObject;
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

    public enum STATUS {
        OFFLINE,
        AUTHENTICATING,
        ONLINE,
        TIMEOUT

    }

    public BoxLink(Session session) {
        this.session = session;
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
                            System.out.println("Registering user: " + json);
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
                            }

                            session.getBasicRemote().sendText(response.toString());
                        }
                    } else if (message.equals("tt")) {
                        session.getBasicRemote().sendText("ok");
                    }
                    System.out.println("Received message length: " + message.length());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }

    public void resumeNext() {
        BoxDialog dialog = queue.peek();
        if (dialog != null) {
            dialog.resume();
        }
    }

    public JSONObject ask(JSONObject request) throws Exception {
        BoxDialog dialog = new BoxDialog(request);
        queue.add(dialog);
        dialog.doDialog(this);
        return queue.poll().responseJson;
    }

    public void responseRecieved(JSONObject response) throws Exception {
        BoxDialog dialog = queue.peek();
        if (dialog != null) {
            dialog.gotResponse(response);
        }
    }

    public void destroy() {
        for (MessageHandler mh : session.getMessageHandlers()) {
            session.removeMessageHandler(mh);
        }
        try {
            session.close();
        } catch (Exception e) {
        }
    }

}
