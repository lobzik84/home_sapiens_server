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
public class User {
        
    public int id = 0;
    public String login = null;
    public String salt = null;
    public String verifier = null;
    public String email = null;
    public String publicKey = null;
    public int status = 0;
    public String keyfile = null;
    
}
