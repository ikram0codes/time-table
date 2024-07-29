<%-- 
    Document   : test
    Created on : May 7, 2017, 4:17:28 PM
    Author     : user
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>JSP Page</title>
        </head>
        <body>
            <h1>Hello World!</h1>
            <%
                String n = "Mujuni Jonas Makubo [00207]";
                int j = n.length();
                String g = n.substring(j - 6, j - 1);
            %>
            <%= g %>
        </body>
    </html>
    