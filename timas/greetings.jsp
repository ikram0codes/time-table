<%-- 
    Document   : greetings
    Created on : Dec 22, 2014, 7:26:02 AM
    Author     : M M TECHNOLOGIES
    <%@page import="java.util.Calendar"%>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Greetings</title>
        </head>
        <body>
            <%
                Calendar rightnow = Calendar.getInstance();
                int hour = rightnow.get(Calendar.HOUR_OF_DAY); // Use HOUR_OF_DAY for 24-hour format
    
                if (hour < 12) {
                    out.print("Good Morning");
                } else if (hour < 18) {
                    out.print("Good Afternoon");
                } else {
                    out.print("Good Evening");
                }
            %>
        </body>
    </html>
    
