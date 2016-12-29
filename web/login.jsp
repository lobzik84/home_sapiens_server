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
    String cont = request.getContextPath();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HS Server. Login</title>
    </head>
    <body>
        <h1>Boxes</h1>
        <form method="POST" action=""> 
            <table>
                <tr>
                    <td>Login</td><td><input type="text" name="login"/></td>
                </tr>
                <tr>
                    <td>Password</td><td><input type="password" name="password"/> </td>
                </tr>
                <tr>
                    <td></td><td><input type="Submit" name="Submit" value="Login"/></td>
                </tr>
            </table>
        </form> 
    </body>
</html>
