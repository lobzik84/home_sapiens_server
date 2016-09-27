/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.tunnel.server;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.Session;
import org.json.JSONObject;
import org.lobzik.home_sapiens.entity.Box;

/**
 *
 * @author lobzik
 */
public class BoxRequestHandler {

    private BoxRequestHandler() {
    }
    private static BoxRequestHandler INSTANCE = null;

    private static final Map<Integer, Box> boxes = new ConcurrentHashMap();
    private static final Map<Integer, BoxLink> links = new ConcurrentHashMap();

    private static final long RECONNECT_TIMEOUT = 2 * 60 * 1000l;

    public static final BoxRequestHandler getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new BoxRequestHandler();
        }

        return INSTANCE;
    }

    public void boxConnected(Box box, Session session) throws Exception {
        boxes.put(box.id, box);
        BoxLink link = new BoxLink(session);
        link.status = BoxLink.STATUS.ONLINE;
        link.session = session;

        links.put(box.id, link);

    }

    public JSONObject handleToBox(int userId, int boxId, JSONObject request) throws Exception {
        BoxLink link = links.get(boxId);
        if (link != null && link.status == BoxLink.STATUS.ONLINE) {
            JSONObject reply = link.ask(request);
            return reply;
        } else {
            JSONObject reply = new JSONObject();
            reply.put("result", "error");
            reply.put("message", "Box id=" + boxId + " not connected to server");
            return reply;
        }

    }

    public static void disconnectAll() {
        try {
            for (int boxId: links.keySet()) {
                System.out.println("Disconnecting box id=" +boxId);
                BoxLink link = links.get(boxId);
                try {
                    link.destroy();
                    link = null;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception ee) {
            ee.printStackTrace();
        }
    }

}
