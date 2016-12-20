/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.server.control;

import java.sql.Connection;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import org.apache.log4j.Logger;
import org.lobzik.home_sapiens.server.CommonData;
import org.lobzik.home_sapiens.server.ConnJDBCAppender;
import org.lobzik.home_sapiens.tunnel.server.BoxLink;
import org.lobzik.home_sapiens.tunnel.server.BoxRequestHandler;
import org.lobzik.tools.Tools;
import org.lobzik.tools.db.postgresql.DBSelect;
import org.lobzik.tools.db.postgresql.DBTools;

/**
 *
 * @author lobzik
 */
public class DBStatWriter {

    private static final HashMap<Integer, Long> lastInBytesValues = new HashMap();
    private static final HashMap<Integer, Long> lastOutBytesValues = new HashMap();
    private static DBStatWriter instance = new DBStatWriter();
    private static final Logger log = Logger.getLogger("DBStatWriter");
    private static final int DAYS_TO_STORE_LOGS_AND_STATS = 7;
    
    static {
        try {
            log.addAppender(ConnJDBCAppender.getServerAppender(DBTools.getDataSource(CommonData.dataSourceName)));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private DBStatWriter() {

    }

    public static DBStatWriter getInstance() {
        return instance;
    }

    public void start() {
        log.info("Starting statwriter");
        //start timer 
        Timer timer = new Timer("DBStatWriter-Timer", true);
        DBStatTask task = new DBStatTask();
        Calendar c = new GregorianCalendar();
        c.add(Calendar.MINUTE, 2);
        c.set(Calendar.SECOND, 0);
        c.set(Calendar.MILLISECOND, 0);
        
        timer.scheduleAtFixedRate(task, c.getTime(), 30 * 60 * 1000); //30 min
    
        Timer cleanTimer = new Timer("DBStatCleaner-Timer", true);
        DBCleanTask cleanTask = new DBCleanTask();
        Calendar cc = new GregorianCalendar();
        cc.add(Calendar.DAY_OF_YEAR, 1);
        cc.set(Calendar.HOUR, 5);
        cc.set(Calendar.MINUTE, 0);
        cc.set(Calendar.SECOND, 0);
        cc.set(Calendar.MILLISECOND, 0);
        
        cleanTimer.scheduleAtFixedRate(cleanTask, cc.getTime(), 24 * 60 * 60 * 1000); //1 day

    
    }
    

    class DBStatTask extends TimerTask {
        
        public DBStatTask() {
            super();
        }

        @Override
        public void run() {
            try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
                //log.info("writing traffic stat");
                String sql = "select * from boxes where status=1";
                List<HashMap> resList = DBSelect.getRows(sql, conn);
                for (Map box : resList) {
                    try {
                        int boxId = Tools.parseInt(box.get("id"), 0);
                        long lastInBytesValue = Tools.parseLong(lastInBytesValues.get(boxId), 0L);
                        long lastOutBytesValue = Tools.parseLong(lastOutBytesValues.get(boxId), 0L);

                        BoxLink link = BoxRequestHandler.getBoxLink(boxId);
                        if (link != null) {
                            long in = link.getBytesIn();
                            long out = link.getBytesOut();
                            long trafIn = in - lastInBytesValue;
                            long trafOut = out - lastOutBytesValue;

                            if (trafIn < 0) {
                                trafIn = in;
                            }
                            if (trafOut < 0) {
                                trafOut = out;
                            }
                            HashMap stat = new HashMap();
                            stat.put("box_id", boxId);
                            stat.put("dated", new Date());
                            stat.put("bytes_in", trafIn);
                            stat.put("bytes_out", trafOut);
                            DBTools.insertRow("traffic_stat", stat, conn);
                            
                            lastInBytesValue = in;
                            lastOutBytesValue = out;
                        }
                        lastInBytesValues.put(boxId, lastInBytesValue);
                        lastOutBytesValues.put(boxId, lastOutBytesValue);
                    } catch (Exception e) {
                        log.error(e);
                    }
                }
               // log.info("Done.");
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }

    }

    class DBCleanTask extends TimerTask {
        
        public DBCleanTask() {
            super();
        }

        @Override
        public void run() {
            try (Connection conn = DBTools.openConnection(CommonData.dataSourceName)) {
                log.info("clearing traffic stat");
                long age = System.currentTimeMillis() / 1000;
                age = age - DAYS_TO_STORE_LOGS_AND_STATS * 24 * 60 * 60; // 5 days old
                String sql = "delete from traffic_stat where extract(epoch from dated) < " + age;
                DBSelect.executeStatement(sql, null, conn);
                sql = "delete from box_logs where extract(epoch from dated) < " + age;
                DBSelect.executeStatement(sql, null, conn);
                sql = "delete from server_log where extract(epoch from dated) < " + age;
                DBSelect.executeStatement(sql, null, conn);
                              

                log.info("Done.");
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }

    }
}
