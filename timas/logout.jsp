<%-- 
    Document   : logout
    Created on : Dec 24, 2014, 10:49:32 AM
    Author     : M M TECHNOLOGIES
    <%-- 
    Document   : logout
    Created on : Dec 24, 2014, 10:49:32 AM
    Author     : M M TECHNOLOGIES
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log Out</title>
    </head>
    <body>
        <%
            // Retrieve the current session, if it exists
            HttpSession mysession = request.getSession(false);

            // Check if the session attribute "id" is null
            if (mysession.getAttribute("id") == null) {
                // If "id" is null, redirect to the login page
                response.sendRedirect("https://www.saut-timas.co.tz/");
            } else {
                // If "id" is not null, remove the attribute and invalidate the session
                mysession.removeAttribute("id");
                mysession.invalidate();
                // Redirect to the login page after invalidating the session
                response.sendRedirect("https://www.saut-timas.co.tz/");
            }
        %>
        <div style="background-color: lightsteelblue; padding-bottom: 387px; color: red; text-align: center; font-size: 30px;">
            Logging out, please wait...
        </div>
    </body>
</html>
