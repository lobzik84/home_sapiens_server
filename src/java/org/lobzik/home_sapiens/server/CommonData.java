/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server;

import java.math.BigInteger;
import java.util.HashMap;
import org.inet.mail.Mailer;

/**
 *
 * @author lobzik
 */
public class CommonData {

    public static final UsersSessionsStorage userSessions = new UsersSessionsStorage();// need storage class with time limits
    public static final UsersSessionsStorage boxSessions = new UsersSessionsStorage();// maybe different storage for boxes?
    public static final Mailer mailer = new Mailer("mail2.molnet.ru", "UTF-8", "moidom@molnet.ru");
    public static HashMap<Integer, String> challengeStorage = new HashMap();
    public static final BigInteger RSA_E = new BigInteger("65537");
    public static final String dataSourceName = "jdbc/home_sapiens_dataPooledDS";

}
