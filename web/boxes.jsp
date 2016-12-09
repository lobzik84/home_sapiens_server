<%-- 
    Document   : boxes
    Created on : Oct 7, 2016, 1:21:30 PM
    Author     : lobzik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="JspData"  class="java.util.HashMap" scope="request" />
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<% 
List<HashMap> boxes = (List<HashMap>)JspData.get("boxes");
String cont = request.getContextPath();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HS Server. Boxes</title>
    </head>
    <body>
        <h1>Boxes</h1>
        <a href="<%=cont%>/control/">Status</a><br><br>
        <table border="1px">
            <thead>
            <th>box_id</th><th>version</th><th>name</th><th>status</th><th>users_phone</th><th>box_phone</th><th>ssid</th><th>wpa_psk</th><th>IP</th><th>Log</th>
            </thead>
            <tbody>
                <%for (HashMap h:boxes){%> <tr>
                    <td><%=h.get("id")%></td>
                    <td><%=h.get("version")%></td>
                    <td><%=h.get("name")%></td>
                    <td><%=h.get("status")%></td>
                    <td><%=h.get("login")%></td>
                    <td><%=h.get("phone_num")%></td>
                    <td><%=h.get("ssid")%></td>
                    <td><%=h.get("wpa_psk")%></td>
                    <td><%=h.get("IP")%></td>
                    <td><a href="<%=cont%>/control/box_logs/<%=h.get("id")%>"> >> </a></td>
                </tr>
                <%}%>
            </tbody>
        </table>
            <br>
            <br>
            <form method="POST" action="<%=cont%>/control/box_users_drop"> Drop! All users from box_id <input type="text" name="box_id"/>  UserId override (usually empty) <input type="text" name="user_id"/> <input type="Submit" name="Submit" value="drop"/></form> 
            
    </body>
</html>
