/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.tunnel.server;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.Session;
import org.json.JSONObject;
import org.lobzik.home_sapiens.entity.Box;
import org.lobzik.home_sapiens.server.CommonData;
import org.lobzik.tools.db.postgresql.DBSelect;
import org.lobzik.tools.db.postgresql.DBTools;

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

    public static final BoxRequestHandler getInstance() throws Exception {
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

}
