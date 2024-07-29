<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
    <%@page import="java.text.ParseException"%>
    <%@page import="java.text.SimpleDateFormat"%>
    <%@page import="java.sql.ResultSet"%>
    <%@page import="java.sql.Statement"%>
    <%@page import="java.sql.DriverManager"%>
    <%@page import="java.sql.Connection"%>
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
      <title>TIMAS | User Registration</title>
    </head>
    
    <!-- Global IE fix to avoid layout crash when single word size wider than column width -->
    <!--[if IE]><style type="text/css"> body {word-wrap: break-word;}</style><![endif]-->
    
    <body style="background-color: #c2947d">
      <!-- Main Page Container -->
      <div class="page-container">
    
       <!--  START COPY here -->
    
        <!-- A. HEADER -->      
        <jsp:include page="header.jsp"/>
       <!--  END COPY here -->
    
        <!-- B. MAIN -->
        <div class="main">
     
          <!-- B.1 MAIN NAVIGATION -->
          <jsp:include page="left_nav.jsp"/>
     
          <!-- B.1 MAIN CONTENT -->
          <div class="main-content">
            
            <!-- Pagetitle -->
            <h1 class="pagetitle" style="text-align: center"> TIMAS Registration </h1>
    
            <div class="column1-unit">
                 <%
      try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
            connection.createStatement().executeUpdate("set time_zone='+3:00';");
            Statement statement = connection.createStatement();
            Statement statement1 = connection.createStatement();
            
            //get the parameters
            String reg_no = request.getParameter("reg_no");
            String staff_id = request.getParameter("staff_id");
            
            String designation = request.getParameter("designation");
            String category = request.getParameter("staff_type");
            String dept_no = request.getParameter("dept");
            String prog_code = request.getParameter("prog_code");
            String title = request.getParameter("title");
            String fname1 = request.getParameter("fname");
            String fname = fname1.replaceAll("'", "''");
            String mname1 = request.getParameter("mname");
            String mname = mname1.replaceAll("'", "''");
            String lname1 = request.getParameter("lname");
            String lname = lname1.replaceAll("'", "''");
            String gender = request.getParameter("gender");
            String email1 = request.getParameter("email");
            String email = email1.replaceAll("'", "''");
            String address1 = request.getParameter("home_address");
            String address = address1.replaceAll("'", "''");
            String phone = request.getParameter("mobile");
            String marital = request.getParameter("marital");
            String password1 = request.getParameter("password");
            String password2 = password1.replaceAll("'", "''");
            ResultSet rs0 = statement.executeQuery("select password('" + password2 + "') as pwd");
            rs0.next();
            String password = rs0.getString("pwd");
            rs0.close();
            
            String todate = request.getParameter("dob");                                   
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            java.util.Date tod = null;
        
            try {
                tod = dateFormat.parse(todate);
            } catch (ParseException pe) {
                out.println("invalid Date Format. Please use the format: MM/DD/YYY <br> : ");
            }
    
            dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            todate = dateFormat.format(tod);
            java.sql.Date dob = java.sql.Date.valueOf(todate);        
            
            // Check user type
            if (request.getParameter("type").equalsIgnoreCase("Student")) { // Student registration
                // Check if the student is authorized
                ResultSet rs1 = statement1.executeQuery("select reg_no, email, date_format(date_registered, '%d %b %Y %T') as date from student where reg_no='" + reg_no + "' and fname='" + fname + "' and mname='" + mname + "' and lname='" + lname + "';");
                ResultSet rs = statement.executeQuery("select fname, mname, lname, phone from student where phone='" + phone + "';");
                
                if (!rs1.next()) { // Not authorized
                    %>
                    <div style="color: red; font-size: 14px"> Sorry <%=fname%>, It seems you are not authorised to register in TIMAS. <br/><br/><span style="color: green">Please confirm that the details that were entered by the TIMAS administrator (reg#, first name, middle name and last name) are correct and exactly match with the ones you are entering.</span> <br/><br/> <span style="color: indianred">If the problem persists, please contact TIMAS administrator to authorise you and then try to register again</span>
                    </div>
                    <br/><br/><div style="text-align: center; font-size: 16px;"><a href="register.jsp">Try Again Anyway?</a></div>
                    <%
                } else if (!rs1.getString("email").equalsIgnoreCase("nill")) { // Already registered
                    %>
                    <div style="color: red"> Sorry <%=fname%>, it seems you are already registered since <b style="background-color: yellow; color: black"><%=rs1.getString("date")%></b> </div>
                    <hr/>  <br/><br/><div style="text-align: center; font-size: 16px;"><a href="login.jsp">Login Now?</a></div>
                    <%
                } else if (rs.next()) { // Phone number not unique
                    %>
                    <div style="color: red"> Sorry <%=fname%>, the Phone Number <b style="background-color: yellow"><%=phone%></b> seems to belong to <b><%=rs.getString("fname")%> <%=rs.getString("mname")%> <%=rs.getString("lname")%></b>. Please use your own phone number
                    </div>
                    <hr/>  <br/><br/><div style="text-align: center; font-size: 16px;"><a href="register.jsp">Try Again?</a></div>
                    <%
                } else { // Allowed to register
                    int i = statement.executeUpdate("replace into student(reg_no, fname, mname, lname, phone, email, home_address, marital, gender, dob, password) values('" + reg_no + "','" + fname + "','" + mname + "','" + lname + "','" + phone + "','" + email + "','" + address + "','" + marital + "','" + gender + "','" + dob + "','" + password + "')");
                    if (i == 2) {
                        int j = statement.executeUpdate("insert into student_programme(reg_no, prog_code) values('" + reg_no + "','" + prog_code + "')");
                        if (j == 0) {
                            %>
                            <div style="font-size: 14px; color: #da2c6d">Sorry! Registration Failed (student programme)! Please <a href="register.jsp">Try Again</a> or Contact TIMAS Administrator</div>   
                            <% statement.executeUpdate("delete from student where reg_no='" + reg_no + "'"); // Undo
                        } else {
                            %>
                            <div style="font-size: 16px; text-align: left"><b style="color: darkgreen">Congratulations! <%=fname%>.</b> <br/><br/> You have successfully registered into TIMAS. Please go to login and continue enjoying TIMAS (Anywhere & Anytime provided you are connected to Internet)</div>
                            <br/><br/><div style="text-align: center; font-size: 16px;"><a href="login.jsp">Login Now?</a></div>
                            <%
                        }
                    } else { // Authorization failed
                        %>
                        <div style="font-size: 14px; color: #da2c6d">Sorry! Registration Failed! Please <a href="register.jsp">Try Again</a> or Contact TIMAS Administrator</div>   
                        <%
                    }
                }
            } else if (request.getParameter("type").equalsIgnoreCase("Staff")) { // Staff registration
                // Check if the staff is authorized
                ResultSet rs1 = statement1.executeQuery("select staff_id, email, date_format(date_registered, '%d %b %Y %T') as date from staff where staff_id='" + staff_id + "' and fname='" + fname + "' and mname='" + mname + "' and lname='" + lname + "';");
                ResultSet rs = statement.executeQuery("select fname, mname, lname, phone from staff where phone='" + phone + "';");
                
                if (!rs1.next()) { // Not authorized
                    %>
                    <div style="color: red; font-size: 14px"> Sorry <%=title%> <%=fname%>, It seems you are not authorised to register in TIMAS. <br/><br/><span style="color: green">Please confirm that the details that were entered by the TIMAS administrator (Staff ID, first name, middle name and last name) are correct and exactly match with the ones you are entering.</span> <br/><br/> <span style="color: indianred">If the problem persists, please contact TIMAS administrator to authorise you and then try to register again</span>
                    </div>
                    <br/><br/><div style="text-align: center; font-size: 16px;"><a href="register.jsp">Try Again Anyway?</a></div>
                    <%
                } else if (!rs1.getString("email").equalsIgnoreCase("nill")) { // Already registered
                    %>
                    <div style="color: red"> Sorry <%=title%> <%=fname%>, it seems you are already registered since <b style="background-color: yellow; color: black"><%=rs1.getString("date")%></b> </div>
                    <hr/>  <br/><br/><div style="text-align: center; font-size: 16px;"><a href="login.jsp">Login Now?</a></div>
                    <%
                } else if (rs.next()) { // Phone number not unique
                    %>
                    <div style="color: red"> Sorry <%=title%> <%=fname%>, the Phone Number <b style="background-color: yellow"><%=phone%></b> seems to belong to <b><%=rs.getString("fname")%> <%=rs.getString("mname")%> <%=rs.getString("lname")%></b>. Please use your own phone number
                    </div>
                    <hr/>  <br/><br/><div style="text-align: center; font-size: 16px;"><a href="register.jsp">Try Again?</a></div>
                    <%
                } else { // Allowed to register
                    int i = statement.executeUpdate("replace into staff(staff_id, fname, mname, lname, phone, email, home_address, designation, marital, gender, dob, password, title) values('" + staff_id + "','" + fname + "','" + mname + "','" + lname + "','" + phone + "','" + email + "','" + address + "','" + designation + "','" + marital + "','" + gender + "','" + dob + "','" + password + "','" + title + "')");
                    if (i == 2) {
                        int j = statement.executeUpdate("insert into staff_department(staff_id, dept_no, category) values('" + staff_id + "','" + dept_no + "','" + category + "')");
                        if (j == 0) {
                            %>
                            <div style="font-size: 14px; color: #da2c6d">Sorry! Registration Failed (staff_department)! Please <a href="register.jsp">Try Again</a> or Contact TIMAS Administrator</div>   
                            <% statement.executeUpdate("delete from staff where staff_id='" + staff_id + "'"); // Undo
                        } else {
                            %>
                            <div style="font-size: 16px; text-align: left"><b style="color: darkgreen">Congratulations! <%=fname%>.</b> <br/><br/> You have successfully registered into TIMAS. Please go to login and continue enjoying TIMAS (Anywhere & Anytime provided you are connected to Internet)</div>
                            <br/><br/><div style="text-align: center; font-size: 16px;"><a href="login.jsp">Login Now?</a></div>
                            <%
                        }
                    } else { // Authorization failed
                        %>
                        <div style="font-size: 14px; color: #da2c6d">Sorry! Registration Failed! Please <a href="register.jsp">Try Again</a> or Contact TIMAS Administrator</div>   
                        <%
                    }
                }
            } else { // Anonymous
                %>
                <div style="color:red">Sorry! It seems the information you filled is invalid. Please follow the instructions carefully and</div> <a href="authorise.jsp"> Try Again</a>
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
      
        
        </div>
          
        <!-- C. FOOTER AREA -->      
    
        <jsp:include page="footer.jsp"/>      
      </div> 
      
    </body>
    </html>
    



