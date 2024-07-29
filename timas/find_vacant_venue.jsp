<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<html>
<head>
    <title>TIMAS | Find Vacant Venue</title>
    <script type="text/javascript" language="javascript">
        function validateMyForm() {
            var timetable = document.find_vacant_venue;
            var isValid = true;

            if (timetable.ac_year.value === "Select Academic Year") {
                alert("Please select the academic year from the drop list");
                timetable.ac_year.focus();
                isValid = false;
            } else if (timetable.ac_year.value === "Sorry, no academic year is found in the timetable system yet!") {
                alert("Sorry, you cannot select the warning statement");
                timetable.ac_year.focus();
                isValid = false;
            } else if (timetable.semester.value === "Select Semester") {
                alert("Please select the Semester");
                timetable.semester.focus();
                isValid = false;
            } else if (timetable.semester.value === "Sorry, no semester is found in the timetable system yet!") {
                alert("Sorry, you cannot select the warning statement");
                timetable.semester.focus();
                isValid = false;
            } else if (timetable.day.value === "choose day") {
                alert("Please select the day");
                timetable.day.focus();
                isValid = false;
            } else if (timetable.start_time.value === "start time") {
                alert("Please select the start time");
                timetable.start_time.focus();
                isValid = false;
            } else if (timetable.end_time.value === "end time") {
                alert("Please select the end time");
                timetable.end_time.focus();
                isValid = false;
            } else if (timetable.start_time.value === timetable.end_time.value) {
                alert("End time cannot be equal to start time");
                timetable.start_time.focus();
                isValid = false;
            } else if (parseInt(timetable.start_time.value) > parseInt(timetable.end_time.value)) {
                alert("Start time cannot be greater than the end time");
                timetable.start_time.focus();
                isValid = false;
            }
            return isValid;
        }
    </script>
</head>
<body bgcolor="FDF5E6">
    <%
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
    %>
    <center>
        <br>
        <h3>To search for free venue(s) in a particular day, please fill in the details below and then click 'Search Free venue'</h3>
        <form name="find_vacant_venue" action="find_vacant_venue_master.jsp" method="POST">
            <fieldset>
                <legend align="left"><em><b>Searching free venues in a given interval of time in a day</b></em></legend>
                Academic Year:
                <select name="ac_year">
                    <option selected="selected">Select Academic Year</option>
                    <%
                        pstmt = connection.prepareStatement("SELECT DISTINCT ac_year FROM timetable");
                        rs = pstmt.executeQuery();
                        if (!rs.next()) {
                    %>
                    <option>Sorry, no academic year is found in TIMAS yet!</option>
                    <%
                        } else {
                            rs.beforeFirst();
                            while (rs.next()) {
                    %>
                    <option><%= rs.getString("ac_year") %></option>
                    <%
                            }
                        }
                    %>
                </select>
                <br><br>
                Semester:
                <select id="semester" name="semester">
                    <option selected="selected">Select Semester</option>
                    <%
                        pstmt = connection.prepareStatement("SELECT DISTINCT semester FROM timetable");
                        rs = pstmt.executeQuery();
                        if (!rs.next()) {
                    %>
                    <option>Sorry, no semester is found in the timetable system yet!</option>
                    <%
                        } else {
                            rs.beforeFirst();
                            while (rs.next()) {
                    %>
                    <option><%= rs.getString("semester") %></option>
                    <%
                            }
                        }
                    %>
                </select>
                <br><br>
                Day:
                <select name="day" id="day">
                    <option selected="selected">choose day</option>
                    <option>Monday</option>
                    <option>Tuesday</option>
                    <option>Wednesday</option>
                    <option>Thursday</option>
                    <option>Friday</option>
                    <option>Saturday</option>
                    <option>Sunday</option>

                </select>
                <br><br>
                From:
                <select name="start_time" id="stime">
                    <option selected="selected">start time</option>
                    <% for (int i = 7; i < 19; i++) { %>
                    <option><%= i %></option>
                    <% } %>
                </select>
                To:
                <select name="end_time" id="etime">
                    <option selected="selected">end time</option>
                    <% for (int i = 7; i < 20; i++) { %>
                    <option><%= i %></option>
                    <% } %>
                </select> (24hrs format)
                <br><br>
            </fieldset>
            <input type="reset" value="Reset">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input name="button" type="submit" value="Search Free Venue" onclick="javascript:return validateMyForm();">
        </form>
    </center>
    <%
        } catch (Exception e) {
            out.println("There is a problem here: <br>" + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
