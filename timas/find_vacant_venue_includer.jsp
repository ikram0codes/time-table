<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="en">
    
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="3600">
        <meta name="revisit-after" content="2 days">
        <meta name="robots" content="index,follow">
        <meta name="publisher" content="Your publisher info here">
        <meta name="copyright" content="Your copyright info here">
        <meta name="author" content="Design: 1234.info / Modified: Your Name">
        <meta name="distribution" content="global">
        <meta name="description" content="Your page description here">
        <meta name="keywords" content="Your keywords, keywords, keywords, here">
        <link rel="stylesheet" href="./css/mf42_layout2_setup.css" media="screen,projection,print">
        <link rel="stylesheet" href="./css/mf42_layout2_text.css" media="screen,projection,print">
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
        <title>TIMAS | Find Vacant Venue</title>
        <style>
            body {
                background-color: #c2947d;
                word-wrap: break-word; /* IE fix to avoid layout crash */
            }
        </style>
    </head>
    
    <body>
        <div class="page-container">
    
            <!-- Header -->
            <jsp:include page="header.jsp" />
    
            <!-- Main Content -->
            <div class="main">
    
                <!-- Main Navigation -->
                <jsp:include page="left_nav.jsp" />
    
                <!-- Main Content Area -->
                <div class="main-content">
                    <%
                        HttpSession session = request.getSession(false);
                        String id = (String) session.getAttribute("id");
                        String type = (String) session.getAttribute("type");
    
                        if (id == null || !type.equalsIgnoreCase("Administrator")) {
                            response.sendRedirect("https://www.saut-timas.co.tz/");
                        } else {
                    %>
                    <!-- Page Title -->
                    <h1 class="pagetitle">Search For Vacant Venue</h1>
    
                    <!-- Content Unit -->
                    <div class="column1-unit">
                        <jsp:include page="find_vacant_venue.jsp" />
                    </div>
                    
                    <hr class="clear-contentunit" />
                    <% } %>
                </div>
    
            </div>
    
            <!-- Footer -->
            <jsp:include page="footer.jsp" />
    
        </div>
    </body>
    
    </html>
    