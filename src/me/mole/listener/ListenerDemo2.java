package me.mole.listener;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServletResponse;

public class ListenerDemo2 implements ServletRequestListener {
    private HttpServletResponse response;

    /**
     * 如果按照正常的注册流程去注册的话，
     *   自定义的Listener需要有无参构造方法.
     *   否则tomcat启动会报错.
     */
    public ListenerDemo2() {

    }

    public ListenerDemo2(HttpServletResponse response) {
        this.response = response;
    }

    @Override
    public void requestDestroyed(ServletRequestEvent sret) {
        System.out.println("ListenerDemo requestDestroyed");
    }

    @Override
    public void requestInitialized(ServletRequestEvent sret) {
        System.out.println("ListenerDemo requestInitialized");
    }
}
