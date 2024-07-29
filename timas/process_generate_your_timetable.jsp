<%-- 
    Document   : process_generate_your timetable
    Created on : Nov 12, 2013, 3:19:33 PM
    Author     : M M TECHNOLOGIES
    <%@page import="java.sql.*"%>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
        <head>
            <title>TIMAS | Generating My Timetable</title>
            <style>
                body { background-color: #FDF5E6; }
                table { width: 80%; margin: auto; border-collapse: collapse; }
                th, td { border: 1px solid black; padding: 8px; text-align: center; }
                th { background-color: #f2f2f2; }
                .Monday { background-color: yellow; }
                .Tuesday { background-color: #abcdef; }
                .Wednesday { background-color: #ea9020; }
                .Thursday { background-color: #d3d3d3; } /* changed color to valid hex */
                .Friday { background-color: #ff6347; } /* changed color to valid hex */
                .Saturday { background-color: #d3d3d3; } /* changed color to valid hex */
                .Sunday { background-color: #ff6347; } /* changed color to valid hex */
            </style>
        </head>
        <body>
            <%
                String ac_year = request.getParameter("ac_year");
                String semester = request.getParameter("semester");
                String[] course_codes = {
                    request.getParameter("course_code1"),
                    request.getParameter("course_code2"),
                    request.getParameter("course_code3"),
                    request.getParameter("course_code4"),
                    request.getParameter("course_code5"),
                    request.getParameter("course_code6"),
                    request.getParameter("course_code7"),
                    request.getParameter("course_code8"),
                    request.getParameter("course_code9"),
                    request.getParameter("course_code10")
                };
    
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    try (Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78")) {
                        Statement statement = connection.createStatement();
                        
                        StringBuilder query = new StringBuilder("SELECT ac_year, semester, course_code, day, lesson_type, room_no, block_no, start_time, end_time, room_name FROM timetable WHERE ac_year = ? AND semester = ? AND (");
                        for (int i = 0; i < course_codes.length; i++) {
                            if (i > 0) query.append(" OR ");
                            query.append("course_code = ?");
                        }
                        query.append(") ORDER BY day;");
    
                        try (PreparedStatement pstmt = connection.prepareStatement(query.toString())) {
                            pstmt.setString(1, ac_year);
                            pstmt.setString(2, semester);
                            for (int i = 0; i < course_codes.length; i++) {
                                pstmt.setString(3 + i, course_codes[i]);
                            }
                            
                            ResultSet rs = pstmt.executeQuery();
                            if (!rs.next()) {
                                out.println("<b>No timetable found for these courses</b>");
                            } else {
                                out.println("<h2 align='center'>MY ACADEMIC TIMETABLE FOR SEMESTER " + semester + " OF ACADEMIC YEAR " + ac_year + "</h2>");
                                out.println("<table>");
                                out.println("<tr><th>COURSE CODE</th><th>LESSON TYPE</th><th>DAY</th><th>START TIME</th><th>END TIME</th><th>ROOM NAME</th><th>BLOCK NUMBER</th></tr>");
    
                                rs.beforeFirst();
                                while (rs.next()) {
                                    String day = rs.getString("day");
                                    out.println("<tr class='" + day + "'>");
                                    out.println("<td>" + rs.getString("course_code") + "</td>");
                                    out.println("<td>" + rs.getString("lesson_type") + "</td>");
                                    out.println("<td>" + day + "</td>");
    
                                    int startTime = rs.getInt("start_time");
                                    int endTime = rs.getString("lesson_type").equalsIgnoreCase("Practical") ? startTime + 3 : startTime + 1;
    
                                    out.println("<td>" + String.format("%04d", startTime * 100) + "</td>");
                                    out.println("<td>" + String.format("%04d", endTime * 100) + "</td>");
                                    out.println("<td>" + rs.getString("room_name") + "</td>");
                                    out.println("<td>" + rs.getString("block_no") + "</td>");
                                    out.println("</tr>");
                                }
                                out.println("</table>");
                            }
                        }
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    out.println("There is a problem. See more details below: <br><br>" + e.getMessage());
                }
            %>
        </body>
    </html>
    

