<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
    <title>TIMAS | Insert Course</title>
</head>
<body style="background-color: #c2947d">
  <div class="page-container">
    <jsp:include page="header.jsp"/>
    <div class="main">
      <jsp:include page="left_nav.jsp"/>
      <div class="main-content">
        <%
          HttpSession s = request.getSession(false);
          String id = (String)s.getAttribute("id");
          String type = (String)s.getAttribute("type");
          int start_time = Integer.parseInt(request.getParameter("start_time"));
          int end_time = Integer.parseInt(request.getParameter("end_time"));

          if(id == null || !type.equalsIgnoreCase("Administrator")) {
            response.sendRedirect("https://www.saut-timas.co.tz/");
          } else {
        %>
        <h1 class="pagetitle">List of Vacant Venues on <%=request.getParameter("day")%> From
          <%
            if(start_time < 9) {
              out.println("0" + start_time + "00");
            } else if(start_time == 9) {
              out.println("0" + start_time + "00");
            } else {
              out.println(start_time + "00");
            }
          %> HRS To
          <%
            if(end_time < 9) {
              out.println("0" + end_time + "00");
            } else if(end_time == 9) {
              out.println("0" + end_time + "00");
            } else {
              out.println(end_time + "00");
            }
          %> HRS
        </h1>
        <div class="column1-unit">
          <jsp:include page="process_find_vacant_venue.jsp"/>
        </div>
        <hr class="clear-contentunit" />
        <% } %>
      </div>
      <jsp:include page="footer.jsp"/>
    </div>
  </div>
</body>
</html>




