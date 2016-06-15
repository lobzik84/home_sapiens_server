/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server;

import java.util.LinkedList;
import org.lobzik.home_sapiens.server.entity.AuthToken;

/**
 *
 * @author lobzik
 */
public class AuthTokenStorage extends LinkedList<AuthToken> {

    public boolean hasValidToken(AuthToken token) {
        return hasValidToken(token.getKey());
    }

    public boolean hasValidToken(String token) {
        for (AuthToken stored : this) {
            if (stored.getKey().equals(token) && !stored.isExpired()) {
                
                return true;
            }
        }
        return false;
    }

    public AuthToken getToken(String token) {
        for (AuthToken stored : this) {
            if (stored.getKey().equals(token) && !stored.isExpired()) {
                return stored;
            }
        }
        return null;

    }
    
    public void removeExpired() {
        for (AuthToken stored : this) {
            if (stored.isExpired()) {
                super.remove(stored);
            }
        }
    }
}
