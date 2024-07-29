<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
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
    <title>TIMAS | Authorise User Registration</title>

    <script src="js/jquery-1.js"></script>
    <script>
        function validateForm() {
            var isValid = true;
            var form = document.member_registration;
            var userType = form.type.value;

            if (userType === "Student" && form.reg_no.value === "") {
                alert("Please write the student reg#");
                isValid = false;
            } else if (userType === "Staff" && form.staff_id.value === "") {
                alert("Please write the staff id");
                isValid = false;
            } else if (form.fname.value === "") {
                alert("Please type the First Name");
                isValid = false;
            } else if (form.lname.value === "") {
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

            if (userType === "Staff") {
                $("#staff_id, #fname, #mname, #lname, #staff_type, #marital, #submit").show();
            } else if (userType === "Student") {
                $("#reg_no, #fname, #mname, #lname, #submit").show();
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
                        response.sendRedirect("https://www.saut-timas.co.tz");
                    } else {
                %>
                <h1 class="pagetitle">Authorising TIMAS User</h1>
                <div class="column1-unit">
                    <div style="text-align: center;">
                        <div style="box-sizing: border-box; display: inline-block; width: 650px; background-color: #FFFFFF; border: 2px solid #0361A8; border-radius: 5px; box-shadow: 0px 0px 8px #0361A8; margin: auto;">
                            <div style="background: #8b9699; border-radius: 5px 5px 0px 0px; padding: 15px;">
                                <span style="font-family: verdana,arial; color: white; font-size: 14px; font-weight: bold;">Please fill out the form below and then click Authorise button</span>
                            </div>
                            <div style="padding: 15px; background: #E6E7E9;">
                                <form name="member_registration" action="authorise_process.jsp" method="post">
                                    <table style="border: 0px;" align="center">
                                        <tr>
                                            <td style="width: 180px;">User Type</td>
                                            <td>
                                                <select name="type" id="type">
                                                    <option selected>--Select From Drop List--</option>
                                                    <option>Student</option>
                                                    <option>Staff</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="staff_id" class="all">
                                            <td>Staff ID</td>
                                            <td><input type="text" name="staff_id" maxlength="20" size="30" placeholder="PF/Sc/58/1" /></td>
                                        </tr>
                                        <tr id="reg_no" class="all">
                                            <td>Registration No.</td>
                                            <td><input type="text" name="reg_no" maxlength="13" size="30" placeholder="2000-04-00000" pattern="[2-9]{1}[0-9]{3}[-]{1}[0]{1}[4-9]{1}[-]{1}[0-9]{5}" /></td>
                                        </tr>
                                        <tr id="fname" class="all">
                                            <td>First Name</td>
                                            <td><input type="text" name="fname" maxlength="20" size="30" placeholder="e.g. Madama" pattern="^\D{0,100}$" required /></td>
                                        </tr>
                                        <tr id="mname" class="all">
                                            <td>Middle Name</td>
                                            <td><input type="text" name="mname" maxlength="20" size="30" placeholder="e.g. Gatugije" pattern="^\D{0,100}$" /></td>
                                        </tr>
                                        <tr id="lname" class="all">
                                            <td>Last Name</td>
                                            <td><input type="text" name="lname" maxlength="20" size="30" placeholder="e.g. Mulubuga" pattern="^\D{0,100}$" required /></td>
                                        </tr>
                                        <tr id="submit" class="all">
                                            <td style="text-align:center"><button type="reset" onClick="$('.all').hide(200);">Clear All</button></td>
                                            <td style="text-align:center"><button type="submit" onclick="return validateForm();">Authorise</button></td>
                                        </tr>
                                    </table>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <hr class="clear-contentunit" />
                <% } %>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
