/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.lobzik.home_sapiens.tunnel.server.BoxRequestHandler;

/**
 * Web application lifecycle listener.
 *
 * @author lobzik
 */
public class ServerContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        BoxRequestHandler.disconnectAll();
    }
}
