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
        for (MessageHandler mh:session.getMessageHandlers()) {
            session.removeMessageHandler(mh);
        }
        
        session.addMessageHandler(new MessageHandler.Whole<String>() {
            @Override
            public void onMessage(String message) {
                try {
                    JSONObject json = new JSONObject(message);

                    responseRecieved(json);
                    System.out.println("Received message: " + message);
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

}
