<%-- 
    Document   : Check_Lesson_type
    Created on : Nov 21, 2015, 12:24:05 PM
    Author     : M M TECHNOLOGIES
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.IllegalArgumentException"  %>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<head>
    <title>Timas | Computing Timetable</title>
</head>
<body>
<%
    String course_code = request.getParameter("course_code");
    String ac_year = request.getParameter("ac_year");
    String semester = request.getParameter("semester");
    String lesson_type = request.getParameter("lesson_type");
    
    Connection connection = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
        
        String totalLessons = "SELECT COUNT(timetable.course_code) AS times, course.units " +
                              "FROM timetable, course " +
                              "WHERE timetable.course_code = ? " +
                              "AND timetable.lesson_type = ? " +
                              "AND timetable.ac_year = ? " +
                              "AND timetable.semester = ? " +
                              "AND course.course_code = timetable.course_code " +
                              "GROUP BY course.units";
        
        pstmt = connection.prepareStatement(totalLessons);
        pstmt.setString(1, course_code);
        pstmt.setString(2, lesson_type);
        pstmt.setString(3, ac_year);
        pstmt.setString(4, semester);
        
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            int times = rs.getInt("times");
            int units = rs.getInt("units");
            
            if ((lesson_type.equalsIgnoreCase("Lecture") && ((units == 4 && times == 3) || (units == 3 && times == 2) || (units == 2 && times == 1))) ||
                ((lesson_type.equalsIgnoreCase("Practical") || lesson_type.equalsIgnoreCase("Seminar") || lesson_type.equalsIgnoreCase("Tutorial")) && times == 1)) {
                
                out.println("Sorry, the course has already reached the allowed number of " + lesson_type + " hours for its units.");
            } else {
                HttpSession session = request.getSession(true);
                session.setAttribute("course_code", course_code);
                session.setAttribute("ac_year", ac_year);
                session.setAttribute("lesson_type", lesson_type);
                session.setAttribute("semester", semester);
                response.sendRedirect("compute.jsp");
            }
        } else {
            HttpSession session = request.getSession(true);
            session.setAttribute("course_code", course_code);
            session.setAttribute("ac_year", ac_year);
            session.setAttribute("lesson_type", lesson_type);
            session.setAttribute("semester", semester);
            response.sendRedirect("compute.jsp");
        }
    } catch (SQLException sqle) {
        out.println("<br>There is an SQL exception: <br> " + sqle.getMessage());
    } catch (ClassNotFoundException classe) {
        out.println("<br>Class not found! : <br> " + classe.getMessage());
    } catch (NumberFormatException nf) {
        out.println("<br>Invalid format: " + nf.getMessage());
    } catch (NullPointerException npe) {
        out.println("There is a Null Pointer Exception: " + npe.getMessage());
    } catch (Exception e) {
        out.println("<br>There is an exception: Read technical details below <hr> <br> " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignored */ }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { /* ignored */ }
        if (connection != null) try { connection.close(); } catch (SQLException e) { /* ignored */ }
    }
%>
</body>
</html>
