/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.tunnel.server;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.Session;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.lobzik.home_sapiens.entity.Box;
import org.lobzik.home_sapiens.entity.UsersSession;

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

    public void boxConnected(Box box, Session session, Logger log, UsersSession boxSession) throws Exception {

        boxes.put(box.id, box);
        String remoteAddr = (String) boxSession.get("remote_addr");
        BoxLink link = new BoxLink(session, log, remoteAddr);
        link.status = BoxLink.STATUS.ONLINE;
        link.session = session;

        links.put(box.id, link);

    }

    public void boxDisconnected(Session session) {

        for (int boxId : links.keySet()) {

            BoxLink link = links.get(boxId);
            if (link.session.getId().equals(session.getId())) {
                try {
                    link.destroy();
                    link = null;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public JSONObject handleToBox(int userId, int boxId, JSONObject request) throws Exception {
        BoxLink link = links.get(boxId);
        if (link != null && link.status == BoxLink.STATUS.ONLINE) {
            request.put("user_id", userId);//есть сомнения, но по идее это нужно, т.к. может в request-e и не оказаться
            
            JSONObject reply = link.ask(request);
            reply.put("connection_type", "remote");
            reply.put("box_link", "up");
            return reply;
        } else {
            JSONObject reply = new JSONObject();
            reply.put("connection_type", "remote");
            reply.put("box_link", "down");                    
            reply.put("result", "error");
            reply.put("message", "Box id=" + boxId + " not connected to server");
            return reply;
        }

    }

    public static String getRemoteIP(int boxId) {
        BoxLink link = links.get(boxId);
        if (link != null && link.status == BoxLink.STATUS.ONLINE) {
            return link.remoteAddr;
        } else {
            return "";
        }
    }

    public static int getOnlineCount() {
        int cnt = 0;
        for (BoxLink link : links.values()) {
            if (link != null && link.status == BoxLink.STATUS.ONLINE) {
                cnt++;
            }
        }
        return cnt;
    }

    public static void disconnectAll() {
        try {
            for (int boxId : links.keySet()) {
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
