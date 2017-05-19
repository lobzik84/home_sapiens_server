<%-- 
    Document   : oee_dec_test
    Created on : Mar 14, 2017, 12:28:20 PM
    Author     : lobzik
--%>

<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.inet.base.dbtools.DBTools"%>
<%@page import="org.inet.base.servlet.SysCommonData"%>
<%@page import="org.inet.base.CommonTools"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="windows-1251"%>

<%
    final String DEVELOPMENT_NETWORK = "192.168.11";

    String remoteAddr = CommonTools.getProxyIP(request);

    if (!remoteAddr.startsWith(DEVELOPMENT_NETWORK) && !remoteAddr.equals("127.0.0.1")) {
        response.getWriter().println(remoteAddr + " not allowed");
        return;
    }

%>
<!DOCTYPE html>
<html>
     
    <script src="<%=request.getContextPath()%>/www/js/crypto/asmcrypto.js"></script>
    <script src="<%=request.getContextPath()%>/www/js/crypto/file2.js"></script>
    <script src="<%=request.getContextPath()%>/www/js/crypto/cryptoHelpers.js"></script>
    <script>

        var chunkSize = <%=SysCommonData.storageTools.getAESChunkSize()%>;
        var fileDownloadBaseUrl = "<%=request.getContextPath()%>/dcoee/";

 <%
    if (request.getMethod().equalsIgnoreCase("post")) {
        int fileId = CommonTools.parseInt(request.getParameter("fileId"), 0);
        //String aesKey = request.getParameter("aesKey");
        if (fileId > 0) {
            Connection conn = null;
            try {
                conn = DBTools.openSQLConnectionByName(SysCommonData.DataDSName);
                HashMap fileMap = new HashMap();
                SysCommonData.storageTools.getFile(fileId, fileMap, conn);
                String folderUid = (String) fileMap.get("FOLDER_UID");
                String fileUid = (String) fileMap.get("STORAGE_UUID");
                String fileName = (String) fileMap.get("FILE_NAME");
                String aesKey = (String) fileMap.get("KEYSTRING");
                String uid = folderUid + File.separator + fileUid;
                long size = CommonTools.parseLong(fileMap.get("CONTENT_SIZE"), 0);
                conn.close();
                %> downloadFile('<%=uid%>', '<%=fileName%>', '<%=aesKey%>', <%=size%>) <%
            }
            catch (Exception e) {
                if (conn != null) conn.close();
            } 
        }
    }
 %>
    
     </script>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
        <title>OEE Decrypt & Download JS Test</title>
    </head>
    <body>
        <h1>OEE Decrypt & Download JS Test</h1>

        <form action="" method="POST">
            OBJ_STORAGE id= <input type="text" name="fileId" /> <input type="Submit" name="Submit" value="Decrypt and Save" /> <br>
        </form>
        <br>


    </body>
</html>
