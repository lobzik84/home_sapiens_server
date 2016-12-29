<%-- 
    Document   : logs
    Created on : Oct 7, 2016, 1:21:53 PM
    Author     : lobzik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="JspData"  class="java.util.HashMap" scope="request" />
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<% 
List<HashMap> logs = (List<HashMap>)JspData.get("logs");
String cont = request.getContextPath();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HS Server. Logs</title>
    </head>
    <body>
        <h1>Server log</h1>
        <a href="<%=cont%>/control/status">Status</a><br><br>
        <table border="1px">
            <thead>
            <th>#</th><th>module</th><th>date</th><th>level</th><th>message</th>
            </thead>
            <tbody>
                <%for (HashMap h:logs){%> <tr>
                    <td><%=h.get("rec_id")%></td><td><%=h.get("module")%></td><td><%=h.get("dated")%></td><td><%=h.get("level")%></td><td><%=h.get("message")%></td>
                </tr>
                <%}%>
            </tbody>
        </table>
    </body>
</html>
