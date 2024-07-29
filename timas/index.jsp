<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">
    
    <head>
      <meta charset="UTF-8">
      <meta name="cache-control" content="no-cache">
      <meta name="expires" content="3600">
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
      <title>TIMAS | Timetable Information Management System</title>
    </head>
    
    <body style="background-color: #c2947d;">
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
            %> 
    
            <!-- Pagetitle -->
            <% if (id == null) { %>
              <h1 class="pagetitle">Welcome to TIMAS</h1>
              <div class="column1-unit">
                <p>TIMAS is an <em>Automated and Intelligent Timetabling System</em> that computes and manages University Timetables such as Teaching and Examination Arrangements, Teaching Matrix, Academic Advisors, Semesterization, etc.</p>
                <p>Other functions TIMAS can do are as follows:</p>
                <ul>
                  <li>Finding Vacant Venues at a given interval of time</li>
                  <li>Allowing lecturers to arrange their courses at convenient times if the venue is vacant</li>
                  <li>Generating a timetable for selected courses</li>
                  <li>Viewing year or day timetables</li>
                  <li>Students can view their room mates, course mates, subject mates, faculty mates, and program mates with their contacts</li>
                  <li>Setting semester dates, examination dates, and other University Events (ALMANAC)</li>
                </ul>
              </div>          
            <% } else {
              if (id.contains("@")) {
                if ("Administrator".equalsIgnoreCase(type)) { %>
                  <h1 class="pagetitle">Administrator Space</h1>
                  <div class="column1-unit">
                    <p>As an administrator, you have extensive permissions to manage the system. Please proceed with caution.</p>
                    <p>The links you see on this page are exclusive to your role. Other users do not have access to these options.</p>
                  </div>          
                <% } else { %>
                  <h1 class="pagetitle">Staff Space</h1>
                  <div class="column1-unit">
                    <p>Welcome, SAUT Staff. The options visible on this page are tailored to your role. Other links are restricted based on your staff type.</p>
                  </div>          
                <% }
              } else { %>
                <h1 class="pagetitle">Student Space</h1>
                <div class="column1-unit">
                  <p>Welcome, Student. The options visible on this page are tailored to your role. Other links are restricted based on your student status.</p>
                </div>          
              <% } 
            } %>
            
            <hr class="clear-contentunit" />
          </div>
        </div>
    
        <!-- C. FOOTER AREA -->      
        <jsp:include page="footer.jsp"/>      
      </div>
    </body>
    </html>
     