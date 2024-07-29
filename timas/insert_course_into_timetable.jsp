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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="3600">
        <meta name="revisit-after" content="2 days">
        <meta name="robots" content="index,follow">
        <meta name="publisher" content="Your publisher infos here ...">
        <meta name="copyright" content="Your copyright infos here ...">
        <meta name="author" content="Design: 1234.info / Modified: Your Name">
        <meta name="distribution" content="global">
        <meta name="description" content="Your page description here ...">
        <meta name="keywords" content="Your keywords, keywords, keywords, here ...">
        <link rel="stylesheet" href="./css/mf42_layout2_setup.css">
        <link rel="stylesheet" href="./css/mf42_layout2_text.css">
        <link rel="icon" href="./img/favicon.ico">
        <title>TIMAS | Insert Course</title>
        <script src="js/jquery-1.js"></script>
        <script>
            function validateForm() {
                var isValid = true;
                var regNo = document.member_registration.reg_no.value;
                var staffId = document.member_registration.staff_id.value;
                var firstName = document.member_registration.fname.value;
                var lastName = document.member_registration.lname.value;
                var userType = document.member_registration.type.value;
    
                if (userType === "Student" && regNo === "") {
                    alert("Please write the student reg#");
                    isValid = false;
                } else if (userType === "Staff" && staffId === "") {
                    alert("Please write the staff id");
                    isValid = false;
                } else if (firstName === "") {
                    alert("Please type the First Name");
                    isValid = false;
                } else if (lastName === "") {
                    alert("Please type the Last Name");
                    isValid = false;
                } else if (!confirm('Do you really want to authorise this person? Press OK to Confirm or CANCEL to abort')) {
                    isValid = false;
                }
    
                return isValid;
            }
    
            $(document).ready(function () {
                controlLoan();
                $("#type").change(controlLoan);
            });
    
            function controlLoan() {
                var userType = $("#type").val();
    
                $(".all").hide();
                if (userType === "Student") {
                    $("#reg_no").show();
                    $("#staff_id").hide();
                } else if (userType === "Staff") {
                    $("#reg_no").hide();
                    $("#staff_id").show();
                }
    
                if (userType !== "--Select From Drop List--") {
                    $("#fname, #mname, #lname, #submit").show();
                    if (userType === "Staff") {
                        $("#staff_type, #marital").show();
                    }
                }
            }
        </script>
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
                    <div class="column1-unit">
                        <jsp:include page="insert_course.jsp"/>
                    </div>
                    <hr class="clear-contentunit" />
                    <% } %>
                </div>
            </div>
            
            <jsp:include page="footer.jsp"/>
        </div>
    </body>
    </html>
    
