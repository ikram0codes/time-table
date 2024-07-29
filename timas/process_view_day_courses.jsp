<%-- 
    Document   : process_view_day_courses
    Created on : Nov 12, 2013, 9:11:43 PM
    Author     : M M TECHNOLOGIES, C.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>TIMAS | <%= request.getParameter("day") %> Timetable</title>
    <style>
        body {
            background-color: #FDF5E6;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .Monday { background-color: yellow; }
        .Tuesday { background-color: #abcdef; }
        .Wednesday { background-color: #ea9020; }
        .Thursday { background-color: #ff69b4; } /* Changed 'loveness' to a color code */
        .Friday { background-color: #ff6347; } /* Changed 'stanford' to a color code */
    </style>
</head>
<body>
    <%
        String ac_year = request.getParameter("ac_year");
        String semester = request.getParameter("semester");
        String day = request.getParameter("day");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(
                "jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", 
                "makubogm_timas", "Jokama@78"
            );
            Statement statement = connection.createStatement();
            String timetableQuery = "SELECT ac_year, semester, course_code, lesson_type, room_no, block_no, start_time, end_time, room_name " +
                                    "FROM timetable " +
                                    "WHERE ac_year = '" + ac_year + "' " +
                                    "AND semester = " + semester + " " +
                                    "AND day = '" + day + "';";
            ResultSet rs = statement.executeQuery(timetableQuery);

            if (!rs.next()) {
                out.println("<b>Timetable for '" + day.toUpperCase() + "' is still not available/no longer existing in the system</b>");
            } else {
                out.println("<h2 align='center'>" + day.toUpperCase() + " TIMETABLE FOR SEMESTER " + semester + " OF ACADEMIC YEAR " + ac_year + "</h2>");
                out.println("<table border='1' align='center'>");
                out.println("<tr><th>COURSE CODE</th><th>LESSON TYPE</th><th>START TIME</th><th>END TIME</th><th>ROOM NAME</th><th>BLOCK NUMBER</th></tr>");

                rs.beforeFirst();
                while (rs.next()) {
                    String rowClass = day;
                    out.println("<tr class='" + rowClass + "'>");
                    out.println("<td>" + rs.getString("course_code") + "</td>");
                    out.println("<td>" + rs.getString("lesson_type") + "</td>");

                    String startTime = String.format("%04d", rs.getInt("start_time") * 100);
                    String endTime;
                    if (rs.getString("lesson_type").equalsIgnoreCase("Practical")) {
                        endTime = String.format("%04d", (rs.getInt("start_time") + 3) * 100);
                    } else {
                        endTime = String.format("%04d", (rs.getInt("start_time") + 1) * 100);
                    }

                    out.println("<td>" + startTime + "</td>");
                    out.println("<td>" + endTime + "</td>");
                    out.println("<td>" + rs.getString("room_name") + "</td>");
                    out.println("<td>" + rs.getString("block_no") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }

        } catch (SQLException e) {
            out.println("There is a problem. See more details below:<br><br>" + e.getMessage());
        } catch (ClassNotFoundException e) {
            out.println("MySQL Driver not found. Include it in your library path.<br><br>" + e.getMessage());
        }
    %>
</body>
</html>
