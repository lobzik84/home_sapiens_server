/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server;

import java.util.HashMap;
import java.util.LinkedList;
import org.lobzik.home_sapiens.server.entity.AuthToken;

/**
 *
 * @author lobzik
 */
public class CommonData {
    public static AuthTokenStorage boxAuthTokenStorage = new AuthTokenStorage();
    public static AuthTokenStorage userAuthTokenStorage = new AuthTokenStorage();
    
    public static HashMap <Integer, String> challengeStorage = new HashMap();

}
