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
  <title>TIMAS | Day Timetable</title>
 
  
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
        <%
         HttpSession s=request.getSession(false);

  String id=(String)s.getAttribute("id");
      String type=(String)s.getAttribute("type");
      
        
   if(id==null||!type.equalsIgnoreCase("Administrator")){
   response.sendRedirect("https://www.saut-timas.co.tz/");
   }
   else{
        %>
        <!-- Pagetitle -->
        <h1 class="pagetitle">View Day Timetable</h1>

        <div class="column1-unit">
         
            <jsp:include page="view_day_courses.jsp"/>
 
    </div>
      
         <hr class="clear-contentunit" />
         
          </div>
          <%}%>
    <!-- C. FOOTER AREA -->      

   <jsp:include page="footer.jsp"/>      
 
  
</body>
</html>



