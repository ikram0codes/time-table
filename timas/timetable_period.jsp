<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
    
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">
    
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="3600">
        <meta name="revisit-after" content="2 days">
        <meta name="robots" content="index,follow">
        <meta name="publisher" content="Your publisher info here">
        <meta name="copyright" content="Your copyright info here">
        <meta name="author" content="Design: 1234.info / Modified: Your Name">
        <meta name="distribution" content="global">
        <meta name="description" content="Your page description here">
        <meta name="keywords" content="Your keywords here">
        <link rel="stylesheet" href="./css/mf42_layout2_setup.css">
        <link rel="stylesheet" href="./css/mf42_layout2_text.css">
        <link rel="icon" type="image/x-icon" href="./img/favicon.ico">
        <title>TIMAS | Specify Course Period</title>
        <script src="js/jquery-1.js"></script>
        <script>
            function validateForm() {
                var isValid = true;
                var form = document.forms["member_registration"];
                var type = form["type"].value;
    
                if (type === "Student" && form["reg_no"].value === "") {
                    alert("Please enter the student registration number");
                    isValid = false;
                } else if (type === "Staff" && form["staff_id"].value === "") {
                    alert("Please enter the staff ID");
                    isValid = false;
                } else if (form["fname"].value === "") {
                    alert("Please enter the first name");
                    isValid = false;
                } else if (form["lname"].value === "") {
                    alert("Please enter the last name");
                    isValid = false;
                } else if (!confirm('Do you really want to authorize this person? Press OK to Confirm or CANCEL to abort')) {
                    isValid = false;
                }
    
                return isValid;
            }
    
            $(document).ready(function () {
                controlLoan();
                $("#type").change(function () {
                    controlLoan();
                });
            });
    
            function controlLoan() {
                var type = $("#type").val();
                if (type === "--Select From Drop List--") {
                    $(".all").hide();
                } else if (type === "Staff") {
                    $("#reg_no").hide();
                    $("#staff_id").show();
                } else if (type === "Student") {
                    $("#reg_no").show();
                    $("#staff_id").hide();
                }
                $("#fname, #mname, #lname, #staff_type, #marital, #submit").show();
            }
        </script>
    </head>
    
    <body style="background-color: #c2947d">
        <div class="page-container">
            <jsp:include page="header.jsp" />
    
            <div class="main">
                <jsp:include page="left_nav.jsp" />
    
                <div class="main-content">
                    <%
                        HttpSession session = request.getSession(false);
                        String id = (String) session.getAttribute("id");
                        String type = (String) session.getAttribute("type");
    
                        if (id == null || !"Administrator".equalsIgnoreCase(type)) {
                            response.sendRedirect("https://www.saut-timas.co.tz/");
                        } else {
                    %>
                    <h1 class="pagetitle">Insert Course into Timetable</h1>
    
                    <div class="column1-unit">
                        <jsp:include page="specify_timetable_period.jsp" />
                    </div>
    
                    <hr class="clear-contentunit" />
                    <% } %>
                </div>
            </div>
    
            <jsp:include page="footer.jsp" />
        </div>
    </body>
    
    </html>
    