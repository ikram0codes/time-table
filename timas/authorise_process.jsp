<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
  <title>TIMAS | Authorise TIMAS Registration</title>
</head>

<!-- Global IE fix to avoid layout crash when single word size wider than column width -->
<!--[if IE]><style type="text/css"> body {word-wrap: break-word;}</style><![endif]-->

<body style="background-color: #c2947d">
  <!-- Main Page Container -->
  <div class="page-container">

    <!-- A. HEADER -->      
    <jsp:include page="header.jsp"/>

    <!-- B. MAIN -->
    <div class="main">
 
      <!-- B.1 MAIN NAVIGATION -->
      <jsp:include page="left_nav.jsp"/>
 
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
        <h1 class="pagetitle">Authorising TIMAS Registration</h1>

        <div class="column1-unit">
          <%
            try {
              Class.forName("com.mysql.jdbc.Driver");
              Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
              connection.createStatement().executeUpdate("set time_zone='+3:00';");         
              Statement statement = connection.createStatement();

              // Check the user type
              if (request.getParameter("type").equalsIgnoreCase("Student")) {
                // Check if the student is registered
                ResultSet rs1 = statement.executeQuery("select reg_no,email,date_format(date_registered,'%d %b %Y %T') as date from student where reg_no='" + request.getParameter("reg_no") + "';");
                if (rs1.next() && !rs1.getString("email").equals("nill")) {
                  // The student is already registered
          %>
                  <div style="color: red"> Sorry, The student with Reg# <b style="background-color: yellow;color: black"><%= request.getParameter("reg_no") %></b> was registered since <b style="background-color: yellow;color:black"><%= rs1.getString("date") %></b>.
                    <br/><br/><b style="color: black; font-size: 14.5px">Please tell him/her to go to login</b>
                  </div>
                  <hr/><br/><br/><div style="text-align: center; font-size: 16px;"><a href="authorise.jsp">Authorise Another User?</a></div>
          <%
                } else {
                  // The student is not registered
                  // Check if the student is authorised
                  ResultSet rs = statement.executeQuery("select reg_no,email,date_format(date_registered,'%d %b %Y %T') as date from student where reg_no='" + request.getParameter("reg_no") + "';");
                  if (rs.next()) {
                    // The student is already authorised
          %>
                    <div style="color: red"> Sorry, The student with Reg# <b style="background-color: yellow;color: black"><%= request.getParameter("reg_no") %></b> was authorised since <b style="background-color: yellow;color:black"><%= rs.getString("date") %></b></div>
                    <hr/><br/><br/><div style="text-align: center; font-size: 16px;"><a href="authorise.jsp">Authorise Another User?</a></div>
          <%
                  } else {
                    // The student is not authorised
                    // Insert into student table (Authorise Now)
                    int i = statement.executeUpdate("insert into student(reg_no,fname,mname,lname) values('" + request.getParameter("reg_no") + "','" + request.getParameter("fname") + "','" + request.getParameter("mname") + "','" + request.getParameter("lname") + "')");
                    if (i == 1) {
                      // Successfully authorised
          %>
                      <div style="font-size: 16px; text-align: left"><b style="color: darkgreen">Congratulations!</b> <br/><br/> You have authorised the student named <b style="background-color: yellow"><%= request.getParameter("fname") %> <%= request.getParameter("mname") %> <%= request.getParameter("lname") %></b> whose Reg# is <b style="background-color: yellow"><%= request.getParameter("reg_no") %></b></div>
                      <hr/><br/><br/><div style="text-align: center; font-size: 16px;"><a href="authorise.jsp">Authorise Another User?</a></div>
          <%
                    } else {
                      // Authorisation failed
          %>
                      <div style="font-size: 14px; color: #da2c6d">Sorry! Authorisation Failed! Please <a href="authorise.jsp">Try Again</a> or Contact System Administrator</div>
          <%
                    }
                  }
                }
              } else if (request.getParameter("type").equalsIgnoreCase("Staff")) {
                // Staff registration and authorisation logic
                // Check if the staff is registered
                ResultSet rs1 = statement.executeQuery("select staff_id,email,date_format(date_registered,'%d %b %Y %T') as date from staff where staff_id='" + request.getParameter("staff_id") + "';");
                if (rs1.next() && !rs1.getString("email").equals("nill")) {
                  // The staff is already registered
          %>
                  <div style="color: red"> Sorry, The staff with ID <b style="background-color: yellow;color: black"><%= request.getParameter("staff_id") %></b> was registered since <b style="background-color: yellow;color:black"><%= rs1.getString("date") %></b>.
                    <br/><br/><b style="color: black; font-size: 14.5px">Please tell him/her to go to login</b>
                  </div>
                  <hr/><br/><br/><div style="text-align: center; font-size: 16px;"><a href="authorise.jsp">Authorise Another User?</a></div>
          <%
                } else {
                  // The staff is not registered
                  // Check if the staff is authorised
                  ResultSet rs = statement.executeQuery("select staff_id,email,date_format(date_registered,'%d %b %Y %T') as date from staff where staff_id='" + request.getParameter("staff_id") + "';");
                  if (rs.next()) {
                    // The staff is already authorised
          %>
                    <div style="color: red"> Sorry, The staff with staff ID <b style="background-color: yellow;color: black"><%= request.getParameter("staff_id") %></b> was authorised since <b style="background-color: yellow;color:black"><%= rs.getString("date") %></b></div>
                    <hr/><br/><br/><div style="text-align: center; font-size: 16px;"><a href="authorise.jsp">Authorise Another User?</a></div>
          <%
                  } else {
                    // The staff is not authorised
                    // Insert into staff table (Authorise Now)
                    int i = statement.executeUpdate("insert into staff(staff_id,fname,mname,lname) values('" + request.getParameter("staff_id") + "','" + request.getParameter("fname") + "','" + request.getParameter("mname") + "','" + request.getParameter("lname") + "')");
                    if (i == 1) {
                      // Successfully authorised
          %>
                      <div style="font-size: 16px; text-align: left"><b style="color: darkgreen">Congratulations!</b> <br/><br/> You have authorised the staff named <b style="background-color: yellow"><%= request.getParameter("fname") %> <%= request.getParameter("mname") %> <%= request.getParameter("lname") %></b> whose staff ID is <b style="background-color: yellow"><%= request.getParameter("staff_id") %></b></div>
                      <hr/><br/><br/><div style="text-align: center; font-size: 16px;"><a href="authorise.jsp">Authorise Another User?</a></div>
          <%
                    } else {
                      // Authorisation failed
          %>
                      <div style="font-size: 14px; color: #da2c6d">Sorry! Authorisation Failed! Please <a href="authorise.jsp">Try Again</a> or Contact System Administrator</div>
          <%
                    }
                  }
                }
              } else {
                // Invalid data
          %>
                <div style="color:red">Sorry! You entered invalid data. Check the instructions carefully and</div> <a href="authorise.jsp"> Try again</a>
          <%
              }
            } catch (Exception e) {
          %>
            There is a technical problem. <hr/><%= e %>
          <%
            }
          %>
        </div>
        <%
          }
        %>
      </div>
      <!-- C. FOOTER AREA -->
      <jsp:include page="footer.jsp"/>
    </div>
  </div>
</body>
</html>
