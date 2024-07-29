<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!--  Version: Multiflex-4.2 / Layout-2 -->
<!--  Date:    January 20, 2008 -->
<!--  Design:  www.1234.info -->
<!--  License: Fully open source without restrictions. -->
<!--           Please keep footer credits with the words -->
<!--           "Design by 1234.info" Thank you! -->

<head>
  <script type="text/javascript" src="js/jquery-1.js"></script>
  <script>
    function validateForm() {
      var validPwd = /[0-9]/;
      var isValid = true;
      if (document.member_registration.reg_no.value === "" && document.member_registration.type.value === "Student") {
        alert("Please write the student reg#");
        isValid = false;
      } else if (document.member_registration.staff_id.value === "" && document.member_registration.type.value === "Staff") {
        alert("Please write the staff id");
        isValid = false;
      } else if (document.member_registration.fname.value === "") {
        alert("Please type the First Name");
        isValid = false;
      } else if (document.member_registration.lname.value === "") {
        alert("Please type the Last Name");
        isValid = false;
      } else if (confirm('Do you really want to authorise this person? Press OK to Confirm or CANCEL to abort') === false) {
        isValid = false;
      }

      return isValid;
    }

    $(document).ready(function () {
      controlLoan(); // call this first so we start out with the correct visibility depending on the selected form values
      // this will call our toggleFields function every time the selection value of our transaction type field changes
      $("#type").change(function () {
        controlLoan();
      });
    });

    // this toggles the visibility of our parent permission fields depending on the current selected value of the underAge field
    function controlLoan() {
      if ($("#type").val() === "--Select From Drop List--") {
        $(".all").hide();
      } else if ($("#type").val() === "Staff") {
        $("#reg_no").hide(120);
        $("#staff_id").show(120);
        $("#fname").show(150);
        $("#mname").show(240);
        $("#lname").show(330);
        $("#staff_type").show(100);
        $("#marital").show(300);
        $("#submit").show(500);
      } else if ($("#type").val() === "Student") {
        $("#reg_no").show(120);
        $("#staff_id").hide(120);
        $("#fname").show(150);
        $("#mname").show(240);
        $("#lname").show(330);
        $("#submit").show(500);
      } else {
        $(".all").hide();
      }
    }
  </script>

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
  <title>TIMAS | Insert a Course into Timetable</title>
</head>

<!-- Global IE fix to avoid layout crash when single word size wider than column width -->
<!--[if IE]><style type="text/css"> body {word-wrap: break-word;}</style><![endif]-->

<body style="background-color: #c2947d">
  <!-- Main Page Container -->
  <div class="page-container">

    <!--  START COPY here -->
    <!-- A. HEADER -->
    <jsp:include page="header.jsp" />
    <!--  END COPY here -->

    <!-- B. MAIN -->
    <div class="main">

      <!-- B.1 MAIN NAVIGATION -->
      <jsp:include page="left_nav.jsp" />

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
        <h1 class="pagetitle">Insert Course into Timetable</h1>

        <div class="column1-unit">
          <jsp:include page="pick_course_to_arrange.jsp" />
        </div>

        <hr class="clear-contentunit" />
      </div>
      <% } %>

      <!-- C. FOOTER AREA -->
      <jsp:include page="footer.jsp" />
</body>

</html>
