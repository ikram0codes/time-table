<%-- 
    Document   : allocate_course
    Created on : Sep 30, 2013, 9:25:02 AM
    Author     : M M TECHNOLOGIES
    <%@ page import="java.sql.*" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>
    <head>
        <title>TIMAS | Create Teaching Matrix</title>
        <script type="text/javascript">
            function validateMyForm() {
                var isValid = true;
                var form = document.allocate_course;
    
                if (form.course_code.value === "--drop list--") {
                    alert("Please select the course from the given drop list (if available)");
                    isValid = false;
                } else if (form.course_code.value === "Sorry, no course registered in the database yet!") {
                    alert("Oh My dear!!! Are you selecting the warning statement!!!");
                    isValid = false;
                } else if (form.ac_year.value === "--drop list--") {
                    alert("Please select the academic year from the given drop list (if available)");
                    isValid = false;
                } else if (form.ac_year.value === "Sorry, no academic year registered in the database yet!") {
                    alert("Oh My dear!!! Are you selecting the warning statement!!!");
                    isValid = false;
                } else if (form.semester.value === "--drop list--") {
                    alert("Please select the semester from the given drop list (if available)");
                    isValid = false;
                } else if (form.semester.value === "Sorry, no semester registered in the database yet!") {
                    alert("Oh My dear!!! Are you selecting the warning statement!!!");
                    isValid = false;
                } else if (form.staff_id.value === "--drop list--") {
                    alert("Please select the Staff ID from the given drop list (if available)");
                    isValid = false;
                } else if (form.staff_id.value === "Sorry, no academic staff registered in the database yet!") {
                    alert("Oh My dear!!! Are you selecting the warning statement!!!");
                    isValid = false;
                }
    
                return isValid;
            }
        </script>
        <link rel="stylesheet" type="text/css" href="mystylesheet.css">
    </head>
    <body bgcolor="FDF5E6">
    <%
        String dbUrl = System.getenv("DB_URL");
        String dbUser = System.getenv("DB_USER");
        String dbPassword = System.getenv("DB_PASSWORD");
    
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    
            PreparedStatement psCourse = connection.prepareStatement("SELECT course_code FROM course");
            PreparedStatement psYear = connection.prepareStatement("SELECT DISTINCT ac_year FROM semesterisation ORDER BY ac_year DESC LIMIT 1");
            PreparedStatement psSemester = connection.prepareStatement("SELECT semester FROM semesterisation WHERE ac_year = ?");
            PreparedStatement psStaff = connection.prepareStatement("SELECT s.staff_id, fname, mname, lname FROM staff_department sd JOIN staff s ON s.staff_id = sd.staff_id WHERE category LIKE '%acad%'");
    
            ResultSet rsCourse = psCourse.executeQuery();
            ResultSet rsYear = psYear.executeQuery();
            ResultSet rsStaff = psStaff.executeQuery();
    %>
    <center>
        <h2>Select Options and Click 'Assign Course'</h2>
        <form name="allocate_course" action="create_tmatrix_process.jsp" method="POST">
            <fieldset>
                <legend align="left"><em><b>Teaching Matrix Arrangement</b></em></legend>
    
                <label for="course_code">Course Code:</label>
                <select id="course_code" name="course_code">
                    <option selected="selected">--drop list--</option>
                    <% if (!rsCourse.next()) { %>
                        <option>Sorry, no course registered in the database yet!</option>
                    <% } else {
                        rsCourse.beforeFirst();
                        while (rsCourse.next()) { %>
                            <option><%= rsCourse.getString("course_code") %></option>
                        <% }
                    } %>
                </select><br><br>
    
                <label for="ac_year">Academic Year:</label>
                <select id="ac_year" name="ac_year">
                    <option selected="selected">--drop list--</option>
                    <% if (!rsYear.next()) { %>
                        <option>Sorry, no academic year registered in the database yet!</option>
                    <% } else {
                        rsYear.beforeFirst();
                        while (rsYear.next()) { %>
                            <option><%= rsYear.getString("ac_year") %></option>
                        <% }
                    } %>
                </select><br><br>
    
                <label for="semester">Semester:</label>
                <select id="semester" name="semester">
                    <option selected="selected">--drop list--</option>
                    <% if (rsYear.first()) {
                        psSemester.setString(1, rsYear.getString("ac_year"));
                        ResultSet rsSemester = psSemester.executeQuery();
                        if (!rsSemester.next()) { %>
                            <option>Sorry, no semester registered in the database yet!</option>
                        <% } else {
                            rsSemester.beforeFirst();
                            while (rsSemester.next()) { %>
                                <option><%= rsSemester.getString("semester") %></option>
                            <% }
                        }
                    } else { %>
                        <option>No semester without academic year!</option>
                    <% } %>
                </select><br><br>
    
                <label for="staff_id">Lecturer:</label>
                <select id="staff_id" name="staff_id">
                    <option selected="selected">--drop list--</option>
                    <% if (!rsStaff.next()) { %>
                        <option>Sorry, no academic staff registered in the database yet!</option>
                    <% } else {
                        rsStaff.beforeFirst();
                        while (rsStaff.next()) {
                            String fname = rsStaff.getString("fname").toLowerCase();
                            String mname = rsStaff.getString("mname").toLowerCase();
                            String lname = rsStaff.getString("lname").toLowerCase(); %>
                            <option><%= fname %> <%= mname %> <%= lname %> [<%= rsStaff.getString("staff_id") %>]</option>
                        <% }
                    } %>
                </select><br><br>
            </fieldset>
            <input type="reset" value="Clear">
            <input type="submit" value="Assign Course" onclick="return validateMyForm();">
        </form>
    </center>
    <%
        } catch (Exception e) {
    %>
        <div>There is an exception: <%= e %></div>
    <%
        }
    %>
    </body>
    </html>
    