/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server;

import java.io.File;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.lobzik.home_sapiens.server.control.DBStatWriter;
import org.lobzik.home_sapiens.tunnel.server.BoxRequestHandler;
import org.inet.filetools.FileTools;

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

        try {
            File configFile = new File(sce.getServletContext().getRealPath("/") + "WEB-INF/filetools.properties");
            CommonData.fileTools = new FileTools(configFile, CommonData.STORAGE_FOLDER);
            log.info("Filetools init ok");
        } catch (Exception e) {
            log.error("Failed to init filetools: " + e.getMessage());
        }
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
