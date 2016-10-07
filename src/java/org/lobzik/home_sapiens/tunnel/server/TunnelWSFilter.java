/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.tunnel.server;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import org.lobzik.home_sapiens.server.ServerTools;

/**
 *
 * @author lobzik
 */
@WebFilter(filterName = "TunnelWSFilter", urlPatterns = {"/wss/"})
public class TunnelWSFilter implements Filter {
    
    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;
    
    public TunnelWSFilter() {
    }    
    

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        
        
        System.out.println("Connection from " +request.getRemoteAddr());
        HttpServletRequest req = (HttpServletRequest)request;
        String remoteAddr = ServerTools.getProxyIP(req);
        req.getSession().setAttribute("RemoteAddr", remoteAddr);

        
        Throwable problem = null;
        try {
            chain.doFilter(request, response);
        } catch (Throwable t) {
            // If an exception is thrown somewhere down the filter chain,
            // we still want to execute our after processing, and then
            // rethrow the problem after that.
            problem = t;
            t.printStackTrace();
        }


    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {        
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {        
        this.filterConfig = filterConfig;
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("TunnelWSFilter()");
        }
        StringBuffer sb = new StringBuffer("TunnelWSFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }
    
    
}
