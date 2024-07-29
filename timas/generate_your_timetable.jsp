<%-- 
    Document   : generate_your_timetable
    Created on : Nov 10, 2013, 11:46:21 AM
    Author     : M M TECHNOLOGIES C.
    <%@ page import="java.sql.*" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>
    <head>
        <title>TIMAS | My Timetable</title>
        <script type="text/javascript">
            function validateMyForm() {
                var isValid = true;
                var timetable = document.generate_timetable;
    
                if (timetable.ac_year.value === "Select Academic Year") {
                    alert("Please select the academic year from the drop list.");
                    isValid = false;
                } else if (timetable.ac_year.value === "Sorry, no academic year is found in the timetable system yet!") {
                    alert("Sorry, you cannot select the warning statement.");
                    isValid = false;
                } else if (timetable.semester.value === "Select Semester") {
                    alert("Please select the Semester.");
                    isValid = false;
                } else if (timetable.semester.value === "Sorry, no semester is found in the timetable system yet!") {
                    alert("Sorry, you cannot select the warning statement.");
                    isValid = false;
                } else {
                    var courseSelected = false;
                    for (var i = 1; i <= 10; i++) {
                        if (timetable["course_code" + i].value !== "Select course" + i) {
                            courseSelected = true;
                            break;
                        }
                    }
                    if (!courseSelected) {
                        alert("You must select at least one course and at most 10 courses.");
                        isValid = false;
                    }
                }
                return isValid;
            }
        </script>
    </head>
    <body bgcolor="FDF5E6">
        <%
        Connection connection = null;
        Statement statement = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
            statement = connection.createStatement();
        %>
        <center>
            <h3 align="center"><i>You can generate your own timetable with a maximum of 10 courses.</i></h3><br>
            <form name="generate_timetable" action="my_timetable_process.jsp" method="POST">
                <fieldset>
                    <legend align="left"><em><b>Generating Personal Timetable</b></em></legend>
                    Academic Year:
                    <select name="ac_year">
                        <option selected="selected">Select Academic Year</option>
                        <%
                        String query = "SELECT DISTINCT ac_year FROM timetable;";
                        ResultSet rs1 = statement.executeQuery(query);
                        if (!rs1.next()) {
                        %>
                        <option>Sorry, no academic year is found in the timetable system yet!</option>
                        <%
                        } else {
                            rs1.beforeFirst();
                            while (rs1.next()) {
                        %>
                        <option><%= rs1.getString("ac_year") %></option>
                        <%
                            }
                        }
                        %>
                    </select><br><br>
                    Semester:
                    <select id="semester" name="semester">
                        <option selected="selected">Select Semester</option>
                        <%
                        String query2 = "SELECT DISTINCT semester FROM timetable;";
                        ResultSet rs2 = statement.executeQuery(query2);
                        if (!rs2.next()) {
                        %>
                        <option>Sorry, no semester is found in the timetable system yet!</option>
                        <%
                        } else {
                            rs2.beforeFirst();
                            while (rs2.next()) {
                        %>
                        <option><%= rs2.getString("semester") %></option>
                        <%
                            }
                        }
                        %>
                    </select><br><br>
                    <% for (int i = 1; i <= 10; i++) { %>
                    Course<%= i %>:
                    <select id="course_code<%= i %>" name="course_code<%= i %>">
                        <option selected="selected">Select course<%= i %></option>
                        <%
                        rs1.beforeFirst();
                        while (rs1.next()) {
                        %>
                        <option><%= rs1.getString("course_code") %></option>
                        <%
                        }
                        %>
                    </select><br><br>
                    <% } %>
                </fieldset>
                <input type="reset" value="Clear All">
                <input name="button" type="submit" value="Generate" onclick="return validateMyForm();">
            </form>
        </center>
        <%
        } catch (Exception e) {
            out.println("There is a problem here: <br>" + e.getMessage());
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        %>
    </body>
    </html>
    