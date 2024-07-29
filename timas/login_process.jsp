<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
--%>

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
        <h1 class="pagetitle" style="text-align: center"> User Authentication </h1>

        <div class="column1-unit">
             <%
  try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection=DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas","Jokama@78");connection.createStatement().executeUpdate("set time_zone='+3:00';");         
        Statement statement=connection.createStatement();
        Statement statement1=connection.createStatement();
        String id=request.getParameter("id");
        String password=request.getParameter("password");
     
        //check the user type
        if(!request.getParameter("id").contains("@")){//all student id do not contain @ sign but staff emails
        //check if the student is registered
     ResultSet rs=statement.executeQuery("select email,date_format(date_registered,'%d %b %Y %T') as date from student where reg_no='"+id+"'");
     if(!rs.next()){//Available in TIMAS?
     %>
     <div style="color:red">Sorry! It seems your reg# <b style="background-color:yellow; color: black">(<%=id%>)</b> does not exist in TIMAS. Please contact TIMAS administrator.  </div>       
            <%
     }else{//exists in TIMAS
         if(rs.getString("email").equalsIgnoreCase("nill")){//is the user authorised?
     %>
     Sorry! It seems you are <b style="background-color:  yellow; color: black"> not registered though you were authorised to register since <%=rs.getString("date")%> </b>.           
     <br/><br/><div style="text-align: center; font-size: 16px;"><a href="register.jsp">Register Now?</a>  </div>       
     <%
     
     }else {//check login details
             
             ResultSet rs0=statement.executeQuery("select password('"+password+"') as pwd");//encript the incoming password
             rs0.next();String enc_pwd=rs0.getString("pwd");rs0.close();
             ResultSet rs1=statement.executeQuery("select fname,mname,lname,password from student where reg_no='"+id+"';");
             if(rs1.next()&&rs1.getString("password").equals(enc_pwd)){
             //take login details to session
               HttpSession s=request.getSession(true);
               s.setAttribute("id", id);
               s.setAttribute("fname", rs1.getString("fname"));
               s.setAttribute("mname", rs1.getString("mname"));
               s.setAttribute("lname", rs1.getString("lname"));
               response.sendRedirect("https://www.saut-timas.co.tz/"); //redirect to home page
     
     } else{
          %>
   Sorry! Wrong Password or username!       
     <%
             }
     }
         
     
     }
        
            
        }else{//staff
 
        //check if the staff is registered
     ResultSet rs=statement.executeQuery("select password,date_format(date_registered,'%d %b %Y %T') as date from staff where email='"+id+"'");
     if(!rs.next()){//Available in TIMAS?
     %>
     <div style="color:red">Sorry! It seems  <b style="background-color:yellow; color: black">(<%=id%>)</b> you do not exist in TIMAS. Please contact TIMAS administrator.  </div>       
            <%
     }else{//exists in TIMAS
         if(rs.getString("password").equals("")){//is the user authorised?
     %>
     Sorry! It seems you are <b style="background-color:  yellow; color: black"> not registered though you were authorised to register since <%=rs.getString("date")%></b>. So please go register. Please contact TIMAS administrator.           
            <%
     
     }else {//check login details
             
             ResultSet rs0=statement.executeQuery("select password('"+password+"') as pwd");//encript the incoming password
             rs0.next();String enc_pwd=rs0.getString("pwd");rs0.close(); 
             ResultSet rs1=statement.executeQuery("select fname,mname,category,title,type,lname,password from staff s,staff_department sd where email='"+id+"' and s.staff_id=sd.staff_id;");
             if(rs1.next()&&rs1.getString("password").equals(enc_pwd)){
             //take login details to session
               HttpSession s=request.getSession(true);
               s.setAttribute("id", id);
               s.setAttribute("fname", rs1.getString("fname"));
               s.setAttribute("mname", rs1.getString("mname"));
               s.setAttribute("lname", rs1.getString("lname"));
               s.setAttribute("type", rs1.getString("type")); 
                s.setAttribute("title", rs1.getString("title"));
                 //ResultSet rs2=statement1.executeQuery("select category from staff_department where staff_id='"+id+"'");
                //if(rs2.next()){
              s.setAttribute("category", rs1.getString("category"));
               // }      
               response.sendRedirect("https://www.saut-timas.co.tz/"); //redirect to home page
     
     } else{
          %>
          <div style="color: red">Sorry! Wrong Credentials!  </div>     
     <%
             }
     }
         
     
         
     }
        
           
            
        }
       
     
        
        
        
             
  }catch(Exception e){
  
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



