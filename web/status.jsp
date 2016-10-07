<%-- 
    Document   : status
    Created on : Oct 7, 2016, 1:29:13 PM
    Author     : lobzik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="JspData"  class="java.util.HashMap" scope="request" />
<% 
String cont = request.getContextPath();
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HS Server Status</title>
    </head>
    <body>
        <h1>Server is running!</h1>
        <%=JspData.get("online_cnt")%> boxes connected<br>
        <%=JspData.get("boxes_cnt")%> boxes registered<br>
        <%=JspData.get("users_cnt")%> users registered<br>
        <br>
        <a href="<%=cont%>/control/boxes">Boxes</a><br>
        <a href="<%=cont%>/control/users">Users</a><br>
        <a href="<%=cont%>/control/log">Server Log</a><br>
        
    </body>
</html>
