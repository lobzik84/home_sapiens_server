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
       Public key <input type="text" id="publicKey" name="publicKey" value="9fa9ece4a4e17f78c0020848ead4dcbb43300a84986720830632cb444a02ce9abdb8a3d52a7e8c2b6436ac7022be5639a5dad1effc5946e031ecf7ce6d81326f50f75e5451d4d77475e67b04cb9fc8074f7a5ce5b92258531819ba8469cf0163b34c4832c90f105dde248f30561bf8bb2a59766f556a2c986ea61a3392a47e69"/> <br>
       Private key <input type="text" id="privateKey" name="privateKey" value="5bebf5d1f1474e1f53d417b6fb540fbcd442bd5b776eb01e1f1c714060a7db10e5b77ec34412d55a49f8dc30372083fdee89dba22213b8256d38f3b669ff1eec648e728274f893edf649330280018402fb0c57c7dc8f799297b241418756c974e739e88cfaf96f407cc17ea0a097cf23d7a9867f47b1992b7365690ecae4750d"/> <br>
       
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
