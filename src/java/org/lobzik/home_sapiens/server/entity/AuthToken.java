/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server.entity;

/**
 *
 * @author lobzik
 */
public class AuthToken {

    private long accessTime = System.currentTimeMillis();
    private String key = null;
    private static final long TTL = 15 * 60 * 1000L;
    private static final String keyAlphabet = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

    public AuthToken() {
       accessTime = System.currentTimeMillis();
       key = generateKey();
    }
    
    public boolean isExpired() {
        return (accessTime + TTL > System.currentTimeMillis());
    }
    
    public String getKey() {
        return key;
    }
    
    public void refresh() {
        accessTime = System.currentTimeMillis();
    }

    private static String generateKey() {
        StringBuffer challenge = new StringBuffer();
        for (int i = 0; i < 16; i++) {
            char ch = keyAlphabet.charAt((int) Math.round(Math.random() * keyAlphabet.length()));
            challenge.append(ch);
        }
        return challenge.toString();
    }

}
