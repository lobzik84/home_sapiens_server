<%-- 
    Document   : boxes
    Created on : Oct 7, 2016, 1:21:30 PM
    Author     : lobzik
--%>

<%@page import="org.lobzik.tools.Tools"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="JspData"  class="java.util.HashMap" scope="request" />
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<% 
List<HashMap> boxes = (List<HashMap>)JspData.get("boxes");
List<HashMap> scripts  = (List<HashMap>)JspData.get("scripts");
String cont = request.getContextPath();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HS Server. Boxes</title>
    </head>
    <body>
        <h1>Boxes</h1>
        <a href="<%=cont%>/control/status">Status</a><br><br>
        <table border="1px">
            <thead>
            <th>box_id</th><th>version</th><th>name</th><th>status</th><th>users_phone</th><th>box_phone</th><th>ssid</th><th>wpa_psk</th><th>IP</th><th>Bytes In</th><th>Bytes Out</th><th>Log</th>
            </thead>
            <tbody>
                <%for (HashMap h:boxes){
                    int bytesIn = Tools.parseInt(h.get("bytes_in"), 0);
                    int bytesOut = Tools.parseInt(h.get("bytes_out"), 0);
                %> <tr>
                    <td><%=h.get("id")%></td>
                    <td><%=h.get("version")%></td>
                    <td><%=h.get("name")%></td>
                    <td><%=h.get("status")%></td>
                    <td><%=h.get("login")%></td>
                    <td><%=h.get("phone_num")%></td>
                    <td><%=h.get("ssid")%></td>
                    <td><%=h.get("wpa_psk")%></td>
                    <td><%=Tools.getStringValue(h.get("IP"), "")%></td>
                    <td><%=Tools.humanBytes(bytesIn)%></td>
                    <td><%=Tools.humanBytes(bytesOut)%></td>
                    <td><a href="<%=cont%>/control/box_logs/<%=h.get("id")%>"> >> </a></td>
                </tr>
                <%}%>
            </tbody>
        </table>
            <br>
            <br>
            <form method="POST" action="<%=cont%>/control/box_users_drop"> Drop! All users from box_id <input type="text" name="box_id"/>  UserId override (usually empty) <input type="text" name="user_id"/> <input type="Submit" name="Submit" value="drop"/></form> 
<% if (scripts != null && !scripts.isEmpty()) {%>           
            <br>
            <br>
            <form method="POST" action="<%=cont%>/control/box_run_script"> Run script 
                <select name="script_id">
                    <option value="">---</option>
                    <% for (Map s:scripts) { %> 
                    <option value="<%=s.get("id")%>"><%=s.get("name")%></option>
                    <%}%>
                </select>
                on box_id <input type="text" name="box_id"/>  <input type="Submit" name="Submit" value="run"/></form> 
            <br>
<% } %>            
    </body>
</html>
