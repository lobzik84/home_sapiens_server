/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server;

import java.awt.Color;
import java.awt.Font;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.lobzik.tools.Tools;
import org.lobzik.tools.db.postgresql.DBSelect;
import org.lobzik.tools.db.postgresql.DBTools;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.AxisLocation;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.DateAxis;
import org.jfree.chart.axis.DateTickUnit;
import org.jfree.chart.axis.DateTickUnitType;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.StandardBarPainter;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.chart.renderer.xy.XYSplineRenderer;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.time.FixedMillisecond;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;

/**
 *
 * @author lobzik
 */
@WebServlet(name = "ChartServlet", urlPatterns = {"/traf.png"})
public class ChartServlet extends HttpServlet {

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
        response.setContentType("image/png");
        OutputStream os = response.getOutputStream();
        int boxId = Tools.parseInt(request.getParameter("boxId"), 0);
        long from = Tools.parseLong(request.getParameter("from"), 0);
        long to = Tools.parseLong(request.getParameter("to"), System.currentTimeMillis());

        try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
            String sql = "select * from traffic_stat \n"
                    + " where box_id = " + boxId
                    + " and extract(epoch from dated) > " + from
                    + " and extract(epoch from dated) < " + to
                    + " order by dated";
            List<HashMap> result = DBSelect.getRows(sql, conn);
            DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
            for (HashMap h : result) {

                String time = sdf.format((Date) h.get("dated"));
                int bytesIn = Tools.parseInt(h.get("bytes_in"), 0);
                dataset.addValue(bytesIn, "in", time);
                int bytesOut = Tools.parseInt(h.get("bytes_out"), 0);
                dataset.addValue(bytesOut, "out", time);
            }

            JFreeChart chart = ChartFactory.createBarChart(
                    "Traffic for Box id=" + boxId, // title
                    "Time", // x-axis label
                    "Bytes", // y-axis label
                    dataset, // data
                    PlotOrientation.VERTICAL,
                    true, // create legend?
                    true, // generate tooltips?
                    false // generate URLs?
            );

            chart.setBackgroundPaint(Color.white);

            CategoryPlot plot = (CategoryPlot) chart.getPlot();
            plot.setBackgroundPaint(Color.white);
            plot.setDomainGridlinePaint(Color.gray);
            plot.setRangeGridlinePaint(Color.gray);
            plot.setDomainAxisLocation(AxisLocation.BOTTOM_OR_RIGHT);

            BarRenderer renderer = (BarRenderer) plot.getRenderer();
            renderer.setBarPainter(new StandardBarPainter());

            final CategoryAxis domainAxis = plot.getDomainAxis();
            domainAxis.setCategoryLabelPositions(CategoryLabelPositions.UP_90);

            Font font = new Font("Dialog", Font.PLAIN, 12);
            domainAxis.setTickLabelFont(font);

            domainAxis.setLowerMargin(0.01);
            domainAxis.setUpperMargin(0.01);

            ChartUtilities.writeChartAsPNG(os, chart, 1280, 480);
            response.flushBuffer();
            os.flush();
            os.close();

        } catch (Exception e) {
            e.printStackTrace();
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

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
