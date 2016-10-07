/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server.control;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.lobzik.home_sapiens.entity.Box;
import org.lobzik.home_sapiens.server.CommonData;
import org.lobzik.home_sapiens.server.ConnJDBCAppender;
import org.lobzik.home_sapiens.tunnel.server.BoxRequestHandler;
import org.lobzik.tools.Tools;
import org.lobzik.tools.db.postgresql.DBSelect;
import org.lobzik.tools.db.postgresql.DBTools;

/**
 *
 * @author lobzik
 */
@WebServlet(name = "ControlServlet", urlPatterns = {"/control", "/control/*"})
public class ControlServlet extends HttpServlet {

    private static final String DEVELOPMENT_NETWORK = "192.168.11";
    private static final String SERVLET_NAME = "Control servlet";
    private static final Logger log = Logger.getLogger(SERVLET_NAME);
    static {
        try {
            log.addAppender(ConnJDBCAppender.getServerAppender(DBTools.getDataSource(CommonData.dataSourceName)));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return SERVLET_NAME;
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!request.getRemoteAddr().startsWith(DEVELOPMENT_NETWORK) && !request.getRemoteAddr().equals("127.0.0.1")) {
            response.getWriter().println(request.getRemoteAddr() + " not allowed");
            return;
        }
        String path = request.getPathInfo();
        if (path != null) {
            String[] pathEl = path.split("/");
            if (pathEl.length > 0) {
                switch (pathEl[1]) {
                    case "boxes":
                        String sSQL = "select * from boxes";
                        try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
                            List<HashMap> boxes = DBSelect.getRows(sSQL, conn);
                            for (HashMap box:boxes){
                                box.put("IP", BoxRequestHandler.getRemoteIP(Tools.parseInt(box.get("id"), 0)));
                            }
                            HashMap<String, Object> jspData = new HashMap();
                            jspData.put("boxes", boxes);
                            RequestDispatcher disp = request.getSession().getServletContext().getRequestDispatcher("/boxes.jsp");
                            request.setAttribute("JspData", jspData);
                            disp.include(request, response);
                        } catch (Exception e) {
                            log.error(e.toString());
                        }

                        break;

                    case "box_logs":
                        sSQL = "select * from box_logs where 1=1 ";
                        if (pathEl.length > 2 && Tools.parseInt(pathEl[2], 0) > 0) {
                            sSQL += " and box_id=" + pathEl[2];
                        }
                        sSQL += " order by dated ";
                        try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
                            List<HashMap> logs = DBSelect.getRows(sSQL, conn);
                            HashMap<String, Object> jspData = new HashMap();
                            jspData.put("logs", logs);
                            RequestDispatcher disp = request.getSession().getServletContext().getRequestDispatcher("/box_logs.jsp");
                            request.setAttribute("JspData", jspData);
                            disp.include(request, response);
                        } catch (Exception e) {
                            log.error(e.toString());
                        }
                        break;
                        
                    case "log":
                        sSQL = "select * from server_log where 1=1 ";
                        sSQL += " order by dated ";
                        try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
                            List<HashMap> logs = DBSelect.getRows(sSQL, conn);
                            HashMap<String, Object> jspData = new HashMap();
                            jspData.put("logs", logs);
                            RequestDispatcher disp = request.getSession().getServletContext().getRequestDispatcher("/server_log.jsp");
                            request.setAttribute("JspData", jspData);
                            disp.include(request, response);
                        } catch (Exception e) {
                            log.error(e.toString());
                        }
                        break;

                    case "users":
                        sSQL = "select * from users where 1=1 ";
                        if (pathEl.length > 2 && Tools.parseInt(pathEl[2], 0) > 0) {
                            sSQL += " and box_id=" + pathEl[2];
                        }
                        try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
                            List<HashMap> users = DBSelect.getRows(sSQL, conn);
                            HashMap<String, Object> jspData = new HashMap();
                            jspData.put("users", users);
                            RequestDispatcher disp = request.getSession().getServletContext().getRequestDispatcher("/users.jsp");
                            request.setAttribute("JspData", jspData);
                            disp.include(request, response);
                        } catch (Exception e) {
                            log.error(e.toString());
                        }
                        break;

                    case "register":
                        try {
                            response.setCharacterEncoding("UTF-8");
                            response.setContentType("application/json");
                            //request.getReader();
                            ByteArrayOutputStream baos = new ByteArrayOutputStream();
                            InputStream is = request.getInputStream();
                            long readed = 0;
                            long content_length = request.getContentLength();
                            byte[] bytes = new byte[65536];
                            while (readed < content_length) {
                                int r = is.read(bytes);
                                if (r < 0) {
                                    break;
                                }
                                baos.write(bytes, 0, r);
                                readed += r;
                            }
                            baos.close();
                            String requestString = baos.toString("UTF-8");

                            System.out.println(requestString);
                            if (requestString.startsWith("{")) {
                                JSONObject json = new JSONObject(requestString);
                                if (!json.has("action")) {
                                    return;
                                }
                                JSONObject responseJson;
                                String action = json.getString("action");
                                switch (action) {

                                    case "register_request":
                                        responseJson = new JSONObject();
                                        if (!json.has("box_data") ) {
                                            return;
                                        }
                                        JSONObject boxJson = json.getJSONObject("box_data");

                                        try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
                                            Box newBox = new Box(boxJson);
                                            newBox.status = Box.Status.REGISTERED;
                                            int boxId = DBTools.insertRow("boxes", newBox.getMap(), conn);
                                            responseJson.put("register_result", "success");
                                            responseJson.put("box_id", boxId);
                                            log.info("Registered new Box: " + boxId);

                                        } catch (Exception e) {
                                            log.error("Error while registering box: " + e.getMessage());
                                            responseJson.put("register_result", "error");
                                        }
                                        response.getWriter().write(responseJson.toString());
                                        return;
                                        
                                }

                            } else {
                                response.getWriter().write("Only JSON accepted");
                            }
                        } catch (Throwable t) {
                            log.error(t.getMessage());
                        }
                        break;

                }

            } else {
                try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {

                    HashMap<String, Object> jspData = new HashMap();
                    jspData.put("online_cnt", BoxRequestHandler.getOnlineCount());
                    String sSQL =   "select * from (select 1 as a, count(*) boxes_cnt from boxes) b\n" +
                                    "inner join (select 1 as a, count(*) users_cnt from users) u on u.a = b.a";
                    List<HashMap> resList = DBSelect.getRows(sSQL, conn);
                    jspData.putAll(resList.get(0));
                    RequestDispatcher disp = request.getSession().getServletContext().getRequestDispatcher("/status.jsp");
                    request.setAttribute("JspData", jspData);
                    disp.include(request, response);
                } catch (Exception e) {
                    log.error(e.toString());
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
