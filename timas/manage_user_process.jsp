<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
    
    <%@page import="java.sql.*"%>
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
  <title>TIMAS | Manage TIMAS User</title>
</head>

<body style="background-color: #c2947d">
  <div class="page-container">
    <jsp:include page="header.jsp"/>
    <div class="main">
      <jsp:include page="left_nav.jsp"/>
      <div class="main-content">
        <%
          HttpSession s = request.getSession(false);
          String id = (String) s.getAttribute("id");
          String type = (String) s.getAttribute("type");

          if (id == null || !type.equalsIgnoreCase("Administrator")) {
            response.sendRedirect("https://www.saut-timas.co.tz/");
          } else {
        %> 
        <h1 class="pagetitle"><%=request.getParameter("manage")%>ing TIMAS User</h1>
        <div class="column1-unit">
          <%
            try {
              Class.forName("com.mysql.jdbc.Driver");
              Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
              connection.createStatement().executeUpdate("set time_zone='+3:00';");
              Statement statement = connection.createStatement();
              
              String userType = request.getParameter("type");
              String userRegNo = request.getParameter("reg_no");
              String manageAction = request.getParameter("manage") + "ed";

              if (userType.equalsIgnoreCase("Student")) {
                ResultSet rs1 = statement.executeQuery("select fname, mname, lname, status from student where reg_no='" + userRegNo + "';");
                if (!rs1.next()) {
          %>
          <div style="color: red"> Sorry, The student with Reg# <b style="background-color: yellow; color: black"><%=userRegNo%></b> does not exist in TIMAS</div>
          <hr/>
          <br/>
          <br/>
          <div style="text-align: center; font-size: 16px;"><a href="manage_user.jsp"> Try Again or Manage Another User?</a></div>
          <%
                } else {
                  String fname = rs1.getString("fname");
                  String mname = rs1.getString("mname");
                  String lname = rs1.getString("lname");

                  ResultSet rs = statement.executeQuery("select status from student where reg_no='" + userRegNo + "' and status='" + manageAction + "';");
                  if (rs.next()) {
          %>
          <div style="color: red"> Sorry, The student with Reg# <b style="background-color: yellow; color: black"><%=userRegNo%></b> is already <b style="background-color: yellow; color: black"><%=manageAction%></b></div>
          <hr/>
          <br/>
          <br/>
          <div style="text-align: center; font-size: 16px;"><a href="manage_user.jsp">Manage Another User?</a></div>
          <%
                  } else {
                    int i = statement.executeUpdate("update student set status='" + manageAction + "' where reg_no='" + userRegNo + "';");
                    if (i == 1) {
          %>
          <div style="font-size: 16px; text-align: left"><b style="color: darkgreen">Congratulations!</b> <br/><br/> You have <%=manageAction%> the student named <b style="background-color: yellow"><%=fname%> <%=mname%> <%=lname%></b> whose Reg# is <b style="background-color: yellow"><%=userRegNo%></b> from using TIMAS</div>
          <hr/>
          <br/>
          <br/>
          <div style="text-align: center; font-size: 16px;"><a href="manage_user.jsp">Manage Another User?</a></div>
          <%
                    } else {
          %>
          <div style="font-size: 14px; color: #da2c6d">Sorry! Operation Failed! Please <a href="manage_user.jsp">Try Again</a> or Contact System Administrator</div>
          <%
                    }
                  }
                }
              } else if (userType.equalsIgnoreCase("Staff")) {
                String staffId = request.getParameter("staff_id");
                ResultSet rs1 = statement.executeQuery("select fname, mname, lname, status from staff where staff_id='" + staffId + "';");
                if (!rs1.next()) {
          %>
          <div style="color: red"> Sorry, The staff with Staff ID <b style="background-color: yellow; color: black"><%=staffId%></b> does not exist in TIMAS</div>
          <hr/>
          <br/>
          <br/>
          <div style="text-align: center; font-size: 16px;"><a href="manage_user.jsp"> Try Again or Manage Another User?</a></div>
          <%
                } else {
                  String fname = rs1.getString("fname");
                  String mname = rs1.getString("mname");
                  String lname = rs1.getString("lname");

                  ResultSet rs = statement.executeQuery("select status from staff where staff_id='" + staffId + "' and status='" + manageAction + "';");
                  if (rs.next()) {
          %>
          <div style="color: red"> Sorry, The staff with Staff ID <b style="background-color: yellow; color: black"><%=staffId%></b> is already <b style="background-color: yellow; color: black"><%=manageAction%></b></div>
          <hr/>
          <br/>
          <br/>
          <div style="text-align: center; font-size: 16px;"><a href="manage_user.jsp">Manage Another User?</a></div>
          <%
                  } else {
                    int i = statement.executeUpdate("update staff set status='" + manageAction + "' where staff_id='" + staffId + "';");
                    if (i == 1) {
          %>
          <div style="font-size: 16px; text-align: left"><b style="color: darkgreen">Congratulations!</b> <br/><br/> You have <%=manageAction%> the staff named <b style="background-color: yellow"><%=fname%> <%=mname%> <%=lname%></b> whose Staff ID is <b style="background-color: yellow"><%=staffId%></b> from using TIMAS</div>
          <hr/>
          <br/>
          <br/>
          <div style="text-align: center; font-size: 16px;"><a href="manage_user.jsp">Manage Another User?</a></div>
          <%
                    } else {
          %>
          <div style="font-size: 14px; color: #da2c6d">Sorry! Operation Failed! Please <a href="manage_user.jsp">Try Again</a> or Contact System Administrator</div>
          <%
                    }
                  }
                }
              } else {
          %>
          <div style="color:red">Sorry! It seems the information you filled is invalid. Please follow the instructions carefully and</div> <a href="manage_user.jsp"> Try Again</a>
          <%
              }
            } catch (Exception e) {
          %>
          There is a technical problem. <hr/><%=e%>
          <%
            }
          %>
        </div>
        <hr class="clear-contentunit" />
        <%
          }
        %>
      </div>
    </div>
    <jsp:include page="footer.jsp"/>
  </div>
</body>
</html>
