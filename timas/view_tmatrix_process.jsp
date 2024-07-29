<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <meta http-equiv="cache-control" content="no-cache">
      <meta http-equiv="expires" content="3600">
      <meta name="revisit-after" content="2 days">
      <meta name="robots" content="index, follow">
      <meta name="publisher" content="Your publisher infos here ...">
      <meta name="copyright" content="Your copyright infos here ...">
      <meta name="author" content="Design: 1234.info / Modified: Your Name">
      <meta name="distribution" content="global">
      <meta name="description" content="Your page description here ...">
      <meta name="keywords" content="Your keywords, keywords, keywords, here ...">
      <title>TIMAS | Insert Course</title>
      <link rel="stylesheet" href="./css/mf42_layout2_setup.css" media="screen, projection, print">
      <link rel="stylesheet" href="./css/mf42_layout2_text.css" media="screen, projection, print">
      <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
      <script src="js/jquery-1.js" defer></script>
      <style>
          body {
              background-color: #c2947d;
              word-wrap: break-word; /* IE fix to avoid layout crash when single word size wider than column width */
          }
      </style>
  </head>
  <body>
      <!-- Main Page Container -->
      <div class="page-container">
  
          <!-- A. HEADER -->
          <jsp:include page="header.jsp"/>
  
          <!-- B. MAIN -->
          <div class="main">
  
              <!-- B.1 MAIN NAVIGATION -->
              <jsp:include page="left_nav.jsp"/>
  
              <!-- B.2 MAIN CONTENT -->
              <div class="main-content">
                  <%
                      HttpSession session = request.getSession(false);
                      String id = (String) session.getAttribute("id");
                      String type = (String) session.getAttribute("type");
  
                      if (id == null || !"Administrator".equalsIgnoreCase(type)) {
                          response.sendRedirect("https://www.saut-timas.co.tz/");
                      } else {
                  %>
                  <!-- Pagetitle -->
                  <h1 class="pagetitle">Faculty Teaching Matrix</h1>
  
                  <div class="column1-unit">
                      <jsp:include page="process_faculty_tmatrix.jsp"/>
                  </div>
                  <hr class="clear-contentunit" />
                  <% } %>
              </div>
  
          </div>
  
          <!-- C. FOOTER AREA -->
          <jsp:include page="footer.jsp"/>
  
      </div>
  </body>
  </html>
  