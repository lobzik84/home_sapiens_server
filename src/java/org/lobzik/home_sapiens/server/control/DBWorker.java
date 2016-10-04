/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server.control;

import java.sql.Connection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.json.JSONObject;
import org.lobzik.home_sapiens.server.CommonData;
import org.lobzik.tools.db.postgresql.DBSelect;
import org.lobzik.tools.db.postgresql.DBTools;

/**
 *
 * @author lobzik
 */
public class DBWorker {

    public static int updateUser(JSONObject json) throws Exception {
        try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
            List<HashMap> resList = DBSelect.getRows("select id from users where user_id=" + json.getInt("id") + " and box_id=" + json.getInt("box_id"), conn);
            if (resList.isEmpty()) {//create
                HashMap user = new HashMap();
                user.put("user_id", json.getInt("id"));
                user.put("box_id", json.getInt("box_id"));
                user.put("login", json.getString("login"));
                if (json.has("email")) {
                    user.put("email", json.getString("email"));
                }
                user.put("salt", json.getString("salt"));
                user.put("verifier", json.getString("verifier"));
                user.put("status", json.getInt("status"));
                user.put("public_key", json.getString("public_key"));
                user.put("keyfile", json.getString("keyfile"));
                user.put("sync_time", new Date());

                int userId = DBTools.insertRow("users", user, conn);
                return userId;
            } else {//update
                int userId = (int) resList.get(0).get("id");
                HashMap user = new HashMap();

                if (json.has("login")) {
                    user.put("login", json.getString("login"));
                }
                if (json.has("email")) {
                    user.put("email", json.getString("email"));
                }
                if (json.has("salt")) {
                    user.put("salt", json.getString("salt"));
                }
                if (json.has("verifier")) {
                    user.put("verifier", json.getString("verifier"));
                }
                if (json.has("status")) {
                    user.put("status", json.getInt("status"));
                }
                if (json.has("public_key")) {
                    user.put("public_key", json.getString("public_key"));
                }
                if (json.has("keyfile")) {
                    user.put("keyfile", json.getString("keyfile"));
                }
                user.put("sync_time", new Date());
                user.put("id", userId);
                DBTools.updateRow("users", user, conn);
                return userId;
            }
        }
    }
}
