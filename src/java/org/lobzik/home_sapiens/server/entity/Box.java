/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server.entity;

import java.util.HashMap;
import org.json.JSONObject;
import org.lobzik.tools.Tools;

/**
 *
 * @author lobzik
 */
public class Box {

    public Box(JSONObject json) {
        this.id = Tools.parseInt(json.get("id"), 0);
        this.ssid = json.getString("ssid");
        this.publicKey = json.getString("public_key");
        this.version = json.getString("version");
        this.status = json.getInt("status");
        this.phoneNum = json.getString("phone_num");

    }

    public Box(HashMap map) {
        this.id = Tools.parseInt(map.get("id"), 0);
        this.ssid = (String) map.get("ssid");
        this.publicKey = (String) map.get("public_key");
        this.version = (String) map.get("version");
        this.status = Tools.parseInt(map.get("status"), 0);
        this.phoneNum = (String) map.get("phone_num");
    }

    public HashMap<String, Object> getMap() {
        HashMap<String, Object> map = new HashMap();
        map.put("id", id);
        map.put("ssid", ssid);
        map.put("public_key", publicKey);
        map.put("version", version);
        map.put("status", status);
        map.put("phone_num", phoneNum);

        return map;
    }

    public JSONObject getJson() {
        JSONObject json = new JSONObject();
        HashMap<String, Object> map = getMap();
        for (String key : map.keySet()) {
            json.put(key, map.get(key));
        }
        return json;
    }

    public int id = 0;
    public String ssid = null;
    public String publicKey = null;
    public String version = null;
    public int status = 0;
    public String phoneNum = null;

}
