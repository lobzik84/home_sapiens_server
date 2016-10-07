/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author lobzik
 */
public class ServerTools {
    	public static String getProxyIP(HttpServletRequest request) {
		String forwarded = request.getHeader("X-Forwarded-For");
		if (forwarded != null && forwarded.length() > 0) {
			String[] addresses = forwarded.split(",");
			return addresses[0];
		}
		return request.getRemoteAddr();
	}
}
