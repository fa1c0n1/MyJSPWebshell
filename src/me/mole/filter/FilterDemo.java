package me.mole.filter;

import javax.servlet.*;
import java.io.IOException;

//自定义Filter示例
public class FilterDemo implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("me.mole.filter.Demo5 Filter init...");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        System.out.println("me.mole.filter.Demo5 Filter doFilter...");
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
        System.out.println("me.mole.filter.Demo5 Filter destroy...");
    }
}
