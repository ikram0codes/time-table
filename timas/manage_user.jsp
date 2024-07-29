<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
    <!DOCTYPE html>
    <html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>TIMAS | User Management</title>
        <link rel="stylesheet" type="text/css" href="./css/mf42_layout2_setup.css" />
        <link rel="stylesheet" type="text/css" href="./css/mf42_layout2_text.css" />
        <link rel="icon" type="image/x-icon" href="./img/favicon.ico" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            .input-validation {
                color: red;
                font-size: 12px;
                display: none;
            }
            .form-group {
                margin-bottom: 1em;
            }
        </style>
        <script>
            $(document).ready(function() {
                controlLoan();
                $("#type").change(controlLoan);
    
                $("form").on("submit", function(event) {
                    if (!validateForm()) {
                        event.preventDefault();
                    }
                });
            });
    
            function controlLoan() {
                var type = $("#type").val();
                $(".all").hide();
                if (type === "Student") {
                    $("#reg_no").show(120);
                } else if (type === "Staff") {
                    $("#staff_id").show(120);
                }
                if (type !== "--Select From Drop List--") {
                    $("#manage, #submit").show(150);
                }
            }
    
            function validateForm() {
                var isValid = true;
                $(".input-validation").hide();
    
                if ($("#type").val() === "Student" && $("#reg_no input").val() === "") {
                    $("#reg_no .input-validation").show().text("Please write the student reg#");
                    isValid = false;
                }
    
                if ($("#type").val() === "Staff" && $("#staff_id input").val() === "") {
                    $("#staff_id .input-validation").show().text("Please write the staff id");
                    isValid = false;
                }
    
                if ($("#manage select").val() === "Choose From Drop List") {
                    $("#manage .input-validation").show().text("Please specify whether blocking or unblocking this person");
                    isValid = false;
                }
    
                if (!confirm('Are you sure you want to proceed? Press OK to Confirm or CANCEL to abort')) {
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
                <div class="main-content">
                    <% HttpSession s = request.getSession(false);
                       String id = (String) s.getAttribute("id");
                       String type = (String) s.getAttribute("type");
                       if (id == null || !type.equalsIgnoreCase("Administrator")) {
                           response.sendRedirect("https://www.saut-timas.co.tz/");
                       } else {
                    %>
                    <h1 class="pagetitle" style="text-align: center">Managing User</h1>
                    <div class="column1-unit">
                        <table align="center" border="0" cellpadding="2" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <div style="text-align: center;">
                                        <div style="box-sizing: border-box; display: inline-block; width:650px; background-color: #FFFFFF; border: 2px solid #0361A8; border-radius: 5px; box-shadow: 0px 0px 8px #0361A8;">
                                            <div style="background: #8b9699; border-radius: 5px 5px 0px 0px; padding: 15px;">
                                                <span style="font-family: verdana,arial; color:white; font-size: 14px; font-weight:bold;">
                                                    Please fill out the form below and then click Submit button
                                                </span>
                                            </div>
                                            <div style="padding: 15px; background: #E6E7E9;">
                                                <form name="member_registration" action="manage_user_process.jsp" method="post">
                                                    <div class="form-group">
                                                        <label>User Type</label>
                                                        <select name="type" id="type">
                                                            <option selected>--Select From Drop List--</option>
                                                            <option>Student</option>
                                                            <option>Staff</option>
                                                        </select>
                                                        <span class="input-validation"></span>
                                                    </div>
                                                    <div class="form-group all" id="staff_id">
                                                        <label>Staff ID</label>
                                                        <input type="text" name="staff_id" maxlength="20" size="30" placeholder="PF/Sc/58/1" />
                                                        <span class="input-validation"></span>
                                                    </div>
                                                    <div class="form-group all" id="reg_no">
                                                        <label>Registration No.</label>
                                                        <input type="text" name="reg_no" maxlength="13" size="30" placeholder="2000-04-00000" pattern="[2-9]{1}[0-9]{3}[-]{1}[0]{1}[4-9]{1}[-]{1}[0-9]{5}" />
                                                        <span class="input-validation"></span>
                                                    </div>
                                                    <div class="form-group all" id="manage">
                                                        <label>Management Type</label>
                                                        <select name="manage">
                                                            <option selected>Choose From Drop List</option>
                                                            <option>Block</option>
                                                            <option>Unblock</option>
                                                        </select>
                                                        <span class="input-validation"></span>
                                                    </div>
                                                    <div class="form-group all" id="submit">
                                                        <button type="reset" onClick="$('.all').hide(200);">Clear All</button>
                                                        <button type="submit">Submit</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <% } %>
                </div>
                <jsp:include page="footer.jsp"/>
            </div>
        </div>
    </body>
    </html>
    



