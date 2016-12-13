/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.lobzik.home_sapiens.server.control.DBStatWriter;
import org.lobzik.home_sapiens.tunnel.server.BoxRequestHandler;

/**
 * Web application lifecycle listener.
 *
 * @author lobzik
 */
public class ServerContextListener implements ServletContextListener {

    private static Logger log = Logger.getRootLogger();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        PatternLayout layout = new PatternLayout("%d{yyyy.MM.dd HH:mm:ss} %-5p: %m box_id=%c{1}");
        ConsoleAppender consoleAppender = new ConsoleAppender(layout);
        BasicConfigurator.configure(consoleAppender);
        log.info("Root Log init ok!");
        log.info("Starting HS server.");
        DBStatWriter.getInstance().start();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            log.info("Context Destroyed called. Stopping server, disconnecting modules");
            BoxRequestHandler.disconnectAll();
            BasicConfigurator.resetConfiguration();

        } catch (Throwable ex) {
            ex.printStackTrace();
        }
    }
}
