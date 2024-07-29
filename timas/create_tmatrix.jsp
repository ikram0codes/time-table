<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="utf-8" />
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
    <title>TIMAS | Create Teaching Matrix</title>
    <link rel="stylesheet" href="./css/mf42_layout2_setup.css" />
    <link rel="stylesheet" href="./css/mf42_layout2_text.css" />
    <link rel="icon" href="./img/favicon.ico" />
    <script src="js/jquery-1.js"></script>
  </head>
  
  <body style="background-color: #c2947d">
    <div class="page-container">
      <!-- A. HEADER -->      
      <jsp:include page="header.jsp" />
  
      <!-- B. MAIN -->
      <div class="main">
        <!-- B.1 MAIN NAVIGATION -->
        <jsp:include page="left_nav.jsp" />
  
        <!-- B.2 MAIN CONTENT -->
        <div class="main-content">
          <% 
             HttpSession s = request.getSession(false);
             String id = (String)s.getAttribute("id");
             String type = (String)s.getAttribute("type");
  
             if (id == null || !type.equalsIgnoreCase("Administrator")) {
               response.sendRedirect("https://www.saut-timas.co.tz/");
             } else {
          %>
          <!-- Pagetitle -->
          <h1 class="pagetitle">Create Teaching Matrix</h1>
          <div class="column1-unit">
            <jsp:include page="teaching_allocation.jsp" />
          </div>
          <hr class="clear-contentunit" />
        </div>
        <% } %>
      </div>
  
      <!-- C. FOOTER AREA -->      
      <jsp:include page="footer.jsp" />
    </div>
  </body>
  </html>
  