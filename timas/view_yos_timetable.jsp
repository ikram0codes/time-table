<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!--  Version: Multiflex-4.2 / Layout-2                     -->
<!--  Date:    January 20, 2008                             -->
<!--  Design:  www.1234.info                                -->
<!--  License: Fully open source without restrictions.      -->
<!--           Please keep footer credits with the words    -->
<!--           "Design by 1234.info" Thank you!             -->

<head>
    <script type="text/javascript" src="js/jquery-1.js"></script>

    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="3600" />
    <meta name="revisit-after" content="2 days" />
    <meta name="robots" content="index,follow" />
    <meta name="publisher" content="Your publisher infos here ..." />
    <meta name="copyright" content="Your copyright infos here ..." />
    <meta name="author" content="Design: 1234.info / Modified: Your Name" />
    <meta name="distribution" content="global" />
    <meta name="description" content="Your page description here ..." />
    <meta name="keywords" content="Your keywords, keywords, keywords, here ..." />
    <link rel="stylesheet" type="text/css" media="screen,projection,print" href="./css/mf42_layout2_setup.css" />
    <link rel="stylesheet" type="text/css" media="screen,projection,print" href="./css/mf42_layout2_text.css" />
    <link rel="icon" type="image/x-icon" href="./img/favicon.ico" />
    <title>TIMAS | Year Of Study Timetable</title>
</head>

<!-- Global IE fix to avoid layout crash when single word size wider than column width -->
<!--[if IE]><style type="text/css"> body {word-wrap: break-word;}</style><![endif]-->

<body style="background-color: #c2947d">
    <!-- Main Page Container -->
    <div class="page-container">

        <!-- A. HEADER -->
        <div class="header">
            <div class="header-left">
                <h1>Your Site Name</h1>
                <p>Your site slogan</p>
            </div>
            <div class="header-right">
                <!-- Add any header content or navigation here -->
            </div>
        </div>

        <!-- B. MAIN -->
        <div class="main">

            <!-- B.1 MAIN NAVIGATION -->
            <div class="left-nav">
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="timetable.jsp">Timetable</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                    <!-- Add more navigation links here -->
                </ul>
            </div>

            <!-- B.1 MAIN CONTENT -->
            <div class="main-content">
                <%
                    HttpSession s = request.getSession(false);

                    String id = (String) s.getAttribute("id");
                    String type = (String) s.getAttribute("type");

                    if (id == null || !type.equalsIgnoreCase("Administrator")) {
                        response.sendRedirect("https://www.saut-timas.co.tz/");
                    } else {
                %>
                <!-- Pagetitle -->
                <h1 class="pagetitle">View Year Of Study Timetable</h1>

                <div class="column1-unit">
                    <!-- Timetable Content -->
                    <h2>Year of Study Timetable</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Day</th>
                                <th>Time</th>
                                <th>Course</th>
                                <th>Room</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Monday</td>
                                <td>08:00 - 10:00</td>
                                <td>Mathematics</td>
                                <td>Room 101</td>
                            </tr>
                            <tr>
                                <td>Monday</td>
                                <td>10:00 - 12:00</td>
                                <td>Physics</td>
                                <td>Room 102</td>
                            </tr>
                            <!-- Add more timetable rows as needed -->
                        </tbody>
                    </table>
                </div>

                <hr class="clear-contentunit" />
                <% } %>
            </div>
        </div>

        <!-- C. FOOTER AREA -->
        <div class="footer">
            <p>Design by 1234.info</p>
            <p>&copy; 2024 M M TECHNOLOGIES. All rights reserved.</p>
        </div>
    </div>
</body>

</html>
