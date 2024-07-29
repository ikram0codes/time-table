<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="3600">
    <meta name="revisit-after" content="2 days">
    <meta name="robots" content="index,follow">
    <meta name="publisher" content="Your publisher info here">
    <meta name="copyright" content="Your copyright info here">
    <meta name="author" content="Design: 1234.info / Modified: Your Name">
    <meta name="distribution" content="global">
    <meta name="description" content="Your page description here">
    <meta name="keywords" content="Your keywords, keywords, keywords, here">
    <link rel="stylesheet" href="./css/mf42_layout2_setup.css">
    <link rel="stylesheet" href="./css/mf42_layout2_text.css">
    <link rel="icon" href="./img/favicon.ico">
    <title>TIMAS | Insert Course</title>
    <script src="js/jquery-1.js"></script>
    <script>
        function validateForm() {
            const validPwd = /[0-9]/;
            let isValid = true;

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
            const type = $("#type").val();
            $(".all").hide();
            if (type === "Staff") {
                $("#reg_no").hide();
                $("#staff_id, #fname, #mname, #lname, #staff_type, #marital, #submit").show();
            } else if (type === "Student") {
                $("#reg_no, #fname, #mname, #lname, #submit").show();
                $("#staff_id, #staff_type, #marital").hide();
            }
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
                    HttpSession s = request.getSession(false);
                    String id = (String) s.getAttribute("id");
                    String type = (String) s.getAttribute("type");

                    if (id == null || !type.equalsIgnoreCase("Administrator")) {
                        response.sendRedirect("https://www.saut-timas.co.tz/");
                    } else {
                %>
                <div class="column1-unit">
                    <jsp:include page="compute_timetable.jsp" />
                </div>
                <hr class="clear-contentunit" />
                <% } %>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </div>
</body>

</html>




