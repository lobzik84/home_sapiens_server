<%-- 
    Document   : users
    Created on : Oct 7, 2016, 1:21:43 PM
    Author     : lobzik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="JspData"  class="java.util.HashMap" scope="request" />
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<% 
List<HashMap> users = (List<HashMap>)JspData.get("users");
String cont = request.getContextPath();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HS Server. Users</title>
    </head>
    <body>
        <h1>Users</h1>
        <a href="<%=cont%>/control/">Status</a><br><br>
        <table border="1px">
            <thead>
            <th>user_id</th><th>box_id</th><th>login</th><th>email</th><th>status</th><th>sync_time</th>
            </thead>
            <tbody>
                <%for (HashMap h:users){%> <tr>
                    <td><%=h.get("user_id")%></td><td><%=h.get("box_id")%></td><td><%=h.get("login")%></td><td><%=h.get("email")%></td><td><%=h.get("status")%></td><td><%=h.get("sync_time")%></td>
                </tr>
                <%}%>
            </tbody>
        </table>
    </body>
</html>