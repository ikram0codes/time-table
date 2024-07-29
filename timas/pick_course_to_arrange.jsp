<%-- 
    Document   : arrange_timetable
    Created on : Oct 11, 2013, 4:25:28 PM
    Author     : M M TECHNOLOGIES
    <%@ page import="java.sql.*" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Timas | Timetable Arrangement</title>
        <script type="text/javascript" language="javascript">
            function validateMyForm() {
                var isValid = true;
                var timetable = document.compute_timetable;
    
                if (timetable.course_code.value === "Select Course") {
                    alert("Please select the course");
                    isValid = false;
                } else if (timetable.course_code.value === "Sorry, no course registered in the database yet for this semester!") {
                    alert("Sorry, you cannot select the warning statement");
                    isValid = false;
                } else if (timetable.lesson_type.value === "--drop list--") {
                    alert("Please select the type of learning");
                    isValid = false;
                }
                return isValid;
            }
        </script>
    </head>
    <body bgcolor="FDF5E6">
    <%
        Connection connection = null;
        Statement statement = null;
        ResultSet rs1 = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
            statement = connection.createStatement();
            String ac_year = request.getParameter("ac_year");
            String semester = request.getParameter("semester");
    %>
    <center>
        <h2>Please fill in the required details and then click the Arrange button:</h2>
        <form name="compute_timetable" method="post" action="lesson_type.jsp?ac_year=<%= ac_year %>&semester=<%= semester %>">
            <fieldset>
                <legend align="center">
                    <em>Time Table Arrangement for <b style="background-color: yellow">academic year: <%= ac_year %>; Semester: <%= semester %></b></em>
                </legend>
                <br>
                Course Code:
                <select name="course_code">
                    <OPTION selected="selected">Select Course</OPTION>
                    <%
                        String query = "select course_code from course where semester=" + semester + ";";
                        rs1 = statement.executeQuery(query);
                        if (!rs1.next()) {
                    %>
                    <OPTION>Sorry, no course registered in the database yet for this semester!</OPTION>
                    <%
                        } else {
                            rs1.beforeFirst();
                            while (rs1.next()) {
                    %>
                    <OPTION><%= rs1.getString("course_code") %></OPTION>
                    <%
                            }
                        }
                    %>
                </select>
                <br><br>
                Lesson Type:
                <select name="lesson_type">
                    <OPTION selected="selected">--drop list--</OPTION>
                    <OPTION>Lecture</OPTION>
                    <OPTION>Practical</OPTION>
                    <OPTION>Seminar</OPTION>
                    <OPTION>Tutorial</OPTION>
                </select>
                <br><br>
            </fieldset>
            <button type="RESET" value="Clear All">Reset</button>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button name="button" type="submit" onclick="javascript:return validateMyForm();">Arrange</button>
        </form>
    </center>
    <%
        } catch (Exception e) {
            out.println("There is a problem here: <hr>" + e.getMessage());
        } finally {
            if (rs1 != null) {
                try { rs1.close(); } catch (SQLException e) { /* ignored */ }
            }
            if (statement != null) {
                try { statement.close(); } catch (SQLException e) { /* ignored */ }
            }
            if (connection != null) {
                try { connection.close(); } catch (SQLException e) { /* ignored */ }
            }
        }
    %>
    </body>
    </html>
    