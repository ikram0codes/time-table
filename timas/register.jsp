<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
    <%@page import="java.sql.ResultSet"%>
    <%@page import="java.sql.Statement"%>
    <%@page import="java.sql.DriverManager"%>
    <%@page import="java.sql.Connection"%>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
    
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TIMAS | User Registration</title>
        <link rel="stylesheet" href="css/mf42_layout2_setup.css" />
        <link rel="stylesheet" href="css/mf42_layout2_text.css" />
        <link rel="stylesheet" href="css/htmlDatePicker.css" />
        <link rel="icon" href="img/favicon.ico" />
        <script src="js/jquery-1.js"></script>
        <script src="js/htmlDatePicker.js"></script>
        <style>
            .all { display: none; }
        </style>
        <script>
            $(document).ready(function () {
                controlLoan();
                $("#type").change(function () {
                    controlLoan();
                });
            });
    
            function controlLoan() {
                $(".all").hide();
                if ($("#type").val() === "Staff") {
                    $("#title, #staff_id, #designation, #dept, #fname, #mname, #lname, #gender, #email, #mobile, #pwd, #password, #staff_type, #dob, #marital, #address, #submit").show();
                    $("#reg_no, #prog_code").hide();
                } else if ($("#type").val() === "Student") {
                    $("#reg_no, #fname, #mname, #lname, #gender, #email, #mobile, #pwd, #password, #prog_code, #dob, #marital, #address, #submit").show();
                    $("#title, #staff_id, #designation, #dept, #staff_type").hide();
                }
            }
    
            function validateForm() {
                var isValid = true;
                var email = document.member_registration.email.value;
                var atpos = email.indexOf("@");
                var dotpos = email.lastIndexOf(".");
                var birthDate = new Date(document.member_registration.dob.value);
                var today = new Date();
    
                if (document.member_registration.type.value === "") {
                    alert("Please select the user type");
                    isValid = false;
                } else if (document.member_registration.type.value === "Staff" && document.member_registration.staff_type.value === "") {
                    alert("Please Specify Category of Staff");
                    isValid = false;
                } else if (document.member_registration.type.value === "Staff" && document.member_registration.dept.value === "") {
                    alert("Please select your department");
                    isValid = false;
                } else if (document.member_registration.type.value === "Staff" && document.member_registration.title.value === "") {
                    alert("Please Select Your Title");
                    isValid = false;
                } else if (document.member_registration.type.value === "Staff" && document.member_registration.designation.value === "") {
                    alert("Please write your designation");
                    isValid = false;
                } else if (document.member_registration.type.value === "Staff" && document.member_registration.staff_id.value === "") {
                    alert("Please write your Staff ID");
                    isValid = false;
                } else if (document.member_registration.type.value === "Student" && document.member_registration.reg_no.value === "") {
                    alert("Please write your reg#");
                    isValid = false;
                } else if (document.member_registration.type.value === "Student" && document.member_registration.prog_code.value === "") {
                    alert("Please select Your Programme of Study");
                    isValid = false;
                } else if (document.member_registration.fname.value === "") {
                    alert("Please type your First Name");
                    isValid = false;
                } else if (document.member_registration.lname.value === "") {
                    alert("Please type your Last Name");
                    isValid = false;
                } else if (document.member_registration.gender.value === "") {
                    alert("Please select your gender");
                    isValid = false;
                } else if (document.member_registration.home_address.value === "") {
                    alert("Please type your Home Address");
                    isValid = false;
                } else if (document.member_registration.email.value === "") {
                    alert("Please type your (Valid) Email Address");
                    isValid = false;
                } else if (birthDate > today) {
                    alert("Huh!!! You cannot be born after today");
                    isValid = false;
                } else if ((today - birthDate) < (18 * 365.25 * 24 * 60 * 60 * 1000)) {
                    alert("Sorry, MUCE does not accept people younger than 18 years old!!");
                    isValid = false;
                } else if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
                    alert("Not a valid e-mail address");
                    isValid = false;
                } else if (document.member_registration.mobile.value === "") {
                    alert("Please type your Mobile Phone Number");
                    isValid = false;
                } else if (document.member_registration.marital.value === "") {
                    alert("Please select your marital status");
                    isValid = false;
                } else if (document.member_registration.dob.value === "") {
                    alert("Please select your date of birth");
                    isValid = false;
                } else if (document.member_registration.password.value === "") {
                    alert("Please Type Your Password");
                    isValid = false;
                } else if (document.member_registration.password.value.length < 6) {
                    alert("Error: Password must contain at least six characters including at least one Number!");
                    isValid = false;
                } else if (!/[0-9]/.test(document.member_registration.password.value)) {
                    alert("Error: password must contain at least one number between (0-9)!");
                    isValid = false;
                } else if (document.member_registration.pwd.value === "") {
                    alert("Please Confirm your Password");
                    isValid = false;
                } else if (document.member_registration.password.value !== document.member_registration.pwd.value) {
                    alert("Sorry, Your passwords do not match!");
                    isValid = false;
                } else if (!confirm('Do you really want to register? Press OK to Confirm or CANCEL to abort')) {
                    isValid = false;
                }
    
                return isValid;
            }
        </script>
    </head>
    
    <body style="background-color: #c2947d">
    
        <div class="page-container">
            <jsp:include page="header.jsp"/>
            <div class="main">
                <jsp:include page="left_nav.jsp"/>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
                        connection.createStatement().executeUpdate("set time_zone='+3:00';");
                        Statement statement = connection.createStatement();
                %>
                <div class="main-content">
                    <h1 class="pagetitle" style="text-align: center">User Registration Form</h1>
                    <div class="column1-unit">
                        <div style="text-align: center;">
                            <div style="box-sizing: border-box; display: inline-block; width:650px; background-color: #FFFFFF; border: 2px solid #0361A8; border-radius: 5px; box-shadow: 0px 0px 8px #0361A8; margin:0px auto auto;">
                                <div style="background: #8b9699; border-radius: 5px 5px 0px 0px; padding: 15px;">
                                    <span style="font-family: verdana,arial; color:white; font-size: 14px; font-weight:bold;">Please fill out the form below and then click Register button</span>
                                </div>
                                <div style="padding: 15px; background: #E6E7E9;">
                                    <form name="member_registration" action="register_process.jsp" method="post" onsubmit="return validateForm();">
                                        <table style="border:0px;" align="center">
                                            <tr>
                                                <td style="width: 180px">User Type</td>
                                                <td>
                                                    <select name="type" id="type">
                                                        <option selected>--Select From Drop List--</option>
                                                        <option>Student</option>
                                                        <option>Staff</option>
                                                    </select>
                                                    <span class="input-validation"></span>
                                                </td>
                                            </tr>
                                            <tr id="staff_type" class="all">
                                                <td style="width: 180px">Staff Category</td>
                                                <td>
                                                    <select name="staff_type">
                                                        <option selected></option>
                                                        <option>Academic</option>
                                                        <option>Administration</option>
                                                    </select>
                                                    <span class="input-validation"></span>
                                                </td>
                                            </tr>
                                            <tr id="dept" class="all">
                                                <td style="width: 180px">Department</td>
                                                <td>
                                                    <select name="dept">
                                                        <option selected></option>
                                                        <% 
                                                            ResultSet rs1 = statement.executeQuery("select dept_no from department order by dept_no");
                                                            if (!rs1.next()) {
                                                                out.println("No Available Department");
                                                            } else {
                                                                rs1.beforeFirst();
                                                                while (rs1.next()) {
                                                        %>
                                                        <option><%= rs1.getString("dept_no") %></option>
                                                        <% 
                                                                }
                                                            }
                                                            rs1.close();
                                                        %>
                                                    </select>
                                                    <span class="input-validation"></span>
                                                </td>
                                            </tr>
                                            <tr id="title" class="all">
                                                <td style="width: 180px">Title</td>
                                                <td>
                                                    <select name="title">
                                                        <option selected></option>
                                                        <option>Mr.</option>
                                                        <option>Ms.</option>
                                                        <option>Dr.</option>
                                                        <option>Prof.</option>
                                                    </select>
                                                    <span class="input-validation"></span>
                                                </td>
                                            </tr>
                                            <tr id="designation" class="all">
                                                <td style="width: 100px">Designation</td>
                                                <td><input type="text" name="designation" maxlength="40" size="30" placeholder="e.g. Lecturer" pattern="^\D{0,100}$" /></td>
                                            </tr>
                                            <tr id="reg_no" class="all">
                                                <td style="width: 100px">Registration No.</td>
                                                <td><input type="text" name="reg_no" maxlength="13" size="30" placeholder="2000-04-00000" pattern="[2-9]{1}[0-9]{3}[-]{1}[0]{1}[4-9]{1}[-]{1}[0-9]{5}" /></td>
                                            </tr>
                                            <tr id="prog_code" class="all">
                                                <td style="width: 180px">Programme of Study</td>
                                                <td>
                                                    <select name="prog_code">
                                                        <option selected></option>
                                                        <% 
                                                            ResultSet rs = statement.executeQuery("select prog_code from programme order by prog_code");
                                                            if (!rs.next()) {
                                                                out.println("Sorry, there is no programme of study registered yet");
                                                            } else {
                                                                rs.beforeFirst();
                                                                while (rs.next()) {
                                                        %>
                                                        <option><%= rs.getString("prog_code") %></option>
                                                        <% 
                                                                }
                                                            }
                                                            rs.close();
                                                        %>
                                                    </select>
                                                    <span class="input-validation"></span>
                                                </td>
                                            </tr>
                                            <tr id="staff_id" class="all">
                                                <td style="width: 100px">Staff ID</td>
                                                <td><input type="text" name="staff_id" maxlength="20" size="30" placeholder="PF/Sc/58/1" /></td>
                                            </tr>
                                            <tr id="fname" class="all">
                                                <td style="width: 100px">First Name</td>
                                                <td><input type="text" name="fname" maxlength="20" required size="30" placeholder="e.g. Madama" pattern="^\D{0,100}$" /></td>
                                            </tr>
                                            <tr id="mname" class="all">
                                                <td style="width: 100px">Middle Name</td>
                                                <td><input type="text" name="mname" maxlength="20" size="30" placeholder="e.g. Gatugije" pattern="^\D{0,100}$" /></td>
                                            </tr>
                                            <tr id="lname" class="all">
                                                <td style="width: 100px">Last Name</td>
                                                <td><input type="text" name="lname" maxlength="20" required size="30" placeholder="e.g. Mulubuga" pattern="^\D{0,100}$" /></td>
                                            </tr>
                                            <tr id="gender" class="all">
                                                <td style="width: 100px">Gender</td>
                                                <td>
                                                    <select required name="gender">
                                                        <option selected></option>
                                                        <option>Male</option>
                                                        <option>Female</option>
                                                    </select>
                                                    <span class="input-validation"></span>
                                                </td>
                                            </tr>
                                            <tr id="address" class="all">
                                                <td style="width: 100px">Home Address</td>
                                                <td><input type="text" name="home_address" required size="30" maxlength="100" placeholder="e.g. P. O Box 2513, Iringa" /></td>
                                            </tr>
                                            <tr id="email" class="all">
                                                <td style="width: 100px">Email Address</td>
                                                <td><input type="text" required name="email" id="email" size="30" placeholder="e.g timas@mapamotz.com" /></td>
                                            </tr>
                                            <tr id="mobile" class="all">
                                                <td style="width: 100px">Mobile No.</td>
                                                <td><input type="text" required maxlength="14" name="mobile" id="mobile" size="30" placeholder="e.g.0754123456" /></td>
                                            </tr>
                                            <tr id="marital" class="all">
                                                <td style="width: 100px">Marital Status</td>
                                                <td>
                                                    <select required name="marital">
                                                        <option selected></option>
                                                        <option>Single</option>
                                                        <option>Married</option>
                                                        <option>Divorced</option>
                                                        <option>Widow</option>
                                                        <option>Widower</option>
                                                    </select>
                                                    <span class="input-validation"></span>
                                                </td>
                                            </tr>
                                            <tr id="dob" class="all">
                                                <td style="width: 100px">Date of Birth</td>
                                                <td><input type="text" size="30" placeholder="click here to select" name="dob" id="dte" onClick="GetDate(this);" required title="Click here to select the date" /></td>
                                            </tr>
                                            <tr id="password" class="all">
                                                <td style="width: 100px">Password</td>
                                                <td><input type="password" title="At Least One number and a Capital Leter (not less than 6 characters)" required maxlength="20" size="30" name="password" placeholder="eg Timas2015" /></td>
                                            </tr>
                                            <tr id="pwd" class="all">
                                                <td style="width: 100px">Confirm Password</td>
                                                <td><input required type="password" size="30" name="pwd" placeholder="eg Timas2015" /></td>
                                            </tr>
                                            <tr id="submit" class="all">
                                                <td style="text-align:center"><button type="RESET" onClick="$('.all').hide(200);">Clear All</button></td>
                                                <td style="text-align:center"><button type="submit" value="register">Register</button></td>
                                            </tr>
                                        </table>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    } catch (Exception e) {
                        out.println("Sorry! There is a technical error <hr>" + e);
                    }
                %>
                <jsp:include page="footer.jsp"/>
            </div>
        </div>
    </body>
    
    </html>
    