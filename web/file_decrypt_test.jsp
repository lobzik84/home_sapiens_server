<%-- 
    Document   : oee_dec_test
    Created on : Mar 14, 2017, 12:28:20 PM
    Author     : lobzik
--%>

<%@page import="org.lobzik.tools.db.postgresql.DBSelect"%>
<%@page import="java.util.List"%>
<%@page import="org.lobzik.home_sapiens.server.CommonData"%>
<%@page import="org.lobzik.tools.db.postgresql.DBTools"%>
<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="windows-1251"%>

<%
   // final String DEVELOPMENT_NETWORK = "192.168.11";

    //String remoteAddr = CommonTools.getProxyIP(request);

    /*if (!remoteAddr.startsWith(DEVELOPMENT_NETWORK) && !remoteAddr.equals("127.0.0.1")) {
        response.getWriter().println(remoteAddr + " not allowed");
        return;
    }*/

%>
<!DOCTYPE html>
<html>
    <script src="<%=request.getContextPath()%>/js/cryptoHelpers.js"></script>
    <script src="<%=request.getContextPath()%>/js/jsHash.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery-3.2.0.min.js"></script>
    
    <script src="<%=request.getContextPath()%>/js/rsa/core.js"></script>
    <script src="<%=request.getContextPath()%>/js/rsa/crypto-1.1.js"></script>
    <script src="<%=request.getContextPath()%>/js/rsa/jsbn.js"></script>
    <script src="<%=request.getContextPath()%>/js/rsa/jsbn2.js"></script>
    <script src="<%=request.getContextPath()%>/js/rsa/prng4.js"></script>
    <script src="<%=request.getContextPath()%>/js/rsa/rng.js"></script>
    <script src="<%=request.getContextPath()%>/js/rsa/rsa.js"></script>
    <script src="<%=request.getContextPath()%>/js/rsa/rsa2.js"></script>
    <script src="<%=request.getContextPath()%>/js/rsa/rsasign-1.2.js"></script>
    <script src="<%=request.getContextPath()%>/js/rsa/sha256.js"></script>
    
    <script src="<%=request.getContextPath()%>/js/aes/asmcrypto.js"></script>
    <script src="<%=request.getContextPath()%>/js/fileDownload.js"></script>


    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
        <title>Files Decrypt & Download JS Test</title>
    </head>
    <body>
        <h1>Files Decrypt & Download JS Test</h1>
        RSA User Keys for decryption
        <br>
       Public key <input type="text" id="publicKey" name="publicKey" value=""/> <br>
       Private key <input type="text" id="privateKey" name="privateKey" value=""/> <br>
       <h2> Backups </h2>
        <%
        //String aesKey = request.getParameter("aesKey");

            Connection conn = null;
            try {
                conn = DBTools.openConnection(CommonData.dataSourceName);
                List<HashMap> dbFiles = DBSelect.getRows("select * from backup_files", null, conn);
                for (HashMap dbFile:dbFiles) {
        %> <a href="#" onclick="downloadBkpFile(<%=dbFile.get("box_id")%>, '<%=dbFile.get("filename")%>', '<%=dbFile.get("keycipher")%>')"><%=dbFile.get("filename")%></a> <br><%
                }
                
                %>  <%
            }
            catch (Exception e) {
                if (conn != null) conn.close();
            } 
        
    
 %> 
 
 <h2> Videos </h2>
        <%
        //String aesKey = request.getParameter("aesKey");

            conn = null;
            try {
                conn = DBTools.openConnection(CommonData.dataSourceName);
                List<HashMap> dbFiles = DBSelect.getRows("select * from video_files", null, conn);
                for (HashMap dbFile:dbFiles) {
        %> <a href="#" onclick="downloadBkpFile(<%=dbFile.get("box_id")%>, '<%=dbFile.get("filename")%>', '<%=dbFile.get("keycipher")%>')"><%=dbFile.get("filename")%></a> <br><%
                }
                
                %>  <%
            }
            catch (Exception e) {
                if (conn != null) conn.close();
            } 
        
    
 %> 
 
    <script>

    var chunkSize = 1048576;
    var fileDownloadBaseUrl = "<%=request.getContextPath()%>/download/";
      
    function downloadBkpFile(boxId, filename, keycipher) {
        const e = '10001';
        const public = $('#publicKey').val();
        const private = $('#privateKey').val();
        console.log("public: " + public);
        console.log("private: " +private);
        
        let rsa = new RSAKey();
        
        rsa.setPrivate(public, e, private);
        
        const aesKey = rsa.decrypt(keycipher);
        console.log("decrypted AES key: " + aesKey );
        
        downloadFile(filename, filename, aesKey, 0);
        
    }
    </script>
    </body>
</html>
