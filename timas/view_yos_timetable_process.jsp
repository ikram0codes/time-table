<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <%@page contentType="text/html" pageEncoding="UTF-8"%>
  <!DOCTYPE html>
  <html>
  
  <head>
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
    <script type="text/javascript" src="js/jquery-1.js"></script>
  </head>
  
  <body style="background-color: #c2947d">
    <!-- Main Page Container -->
    <div class="page-container">
  
      <!-- A. HEADER -->
      <div class="header">
        <h1>Welcome to TIMAS</h1>
        <p>Your academic timetable management system</p>
      </div>
  
      <!-- B. MAIN -->
      <div class="main">
  
        <!-- B.1 MAIN NAVIGATION -->
        <div class="left-nav">
          <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="timetable.jsp">Timetable</a></li>
            <li><a href="settings.jsp">Settings</a></li>
            <li><a href="logout.jsp">Logout</a></li>
          </ul>
        </div>
  
        <!-- B.2 MAIN CONTENT -->
        <div class="main-content">
          <%
            HttpSession session = request.getSession(false);
            String id = (session != null) ? (String) session.getAttribute("id") : null;
            String type = (session != null) ? (String) session.getAttribute("type") : null;
  
            if (id == null || !type.equalsIgnoreCase("Administrator")) {
              response.sendRedirect("https://www.saut-timas.co.tz/");
            } else {
          %>
          <!-- Page Title -->
          <h1 class="pagetitle">Year <%= request.getParameter("yos") %> Timetable</h1>
  
          <div class="column1-unit">
            <%
              // Database connection settings
              String dbURL = "jdbc:mysql://localhost:3306/timetable";
              String dbUser = "root";
              String dbPass = "password";
  
              Connection conn = null;
              Statement stmt = null;
              ResultSet rs = null;
  
              try {
                // Load JDBC driver
                Class.forName("com.mysql.jdbc.Driver");
                // Establish connection
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                // Create statement
                stmt = conn.createStatement();
  
                // Execute query to get timetable
                String yearOfStudy = request.getParameter("yos");
                String query = "SELECT * FROM timetable WHERE year_of_study='" + yearOfStudy + "'";
                rs = stmt.executeQuery(query);
  
                // Display timetable
                while (rs.next()) {
                  out.println("<div class='timetable-entry'>");
                  out.println("<h2>" + rs.getString("course_name") + "</h2>");
                  out.println("<p>" + rs.getString("day") + " - " + rs.getString("time") + "</p>");
                  out.println("</div>");
                }
              } catch (Exception e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
              } finally {
                try {
                  if (rs != null) rs.close();
                  if (stmt != null) stmt.close();
                  if (conn != null) conn.close();
                } catch (SQLException e) {
                  e.printStackTrace();
                }
              }
            %>
          </div>
  
          <hr class="clear-contentunit" />
  
          <% } %>
        </div>
      </div>
  
      <!-- C. FOOTER AREA -->
      <div class="footer">
        <p>&copy; 2024 Your Institution. Design by 1234.info</p>
      </div>
    </div>
  </body>
  
  </html>
  