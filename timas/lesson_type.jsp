<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <script type="text/javascript" src="js/jquery-1.js"></script>
    <script>
        function validateForm() { 
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
            $(".all").hide();
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
                    String id = (String) s.getAttribute("id");
                    String type = (String) s.getAttribute("type");

                    if (id == null || !type.equalsIgnoreCase("Administrator")) {
                        response.sendRedirect("https://www.saut-timas.co.tz/");
                    } else {
                %>
                <h1 class="pagetitle">Insert Course Into Timetable</h1>
                <div class="column1-unit">
                    <jsp:include page="check_lesson_type.jsp"/>
                </div>
                <hr class="clear-contentunit" />
                <% } %>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>      
    </div>
</body>
</html>
