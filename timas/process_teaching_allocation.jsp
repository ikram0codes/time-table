<%-- 
    Document   : process_allocate_course
    Created on : Oct 4, 2013, 3:58:42 AM
    Author     : M M TECHNOLOGIES C. H.

The program controls duplicate course assignment.
It should be remembered that,at MUCE, a course can be taught by more than one lecturer 
and a lecture  can teach more than one course. This has been implemented during creating the table in the Database.
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>TIMAS | Teaching Allocation</title>
</head>
<body>
<%
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");

        HttpSession session = request.getSession(true);
        String registrar = (String) session.getAttribute("id");
        String query1 = "SELECT staff_id FROM staff WHERE email = ?";
        ps = connection.prepareStatement(query1);
        ps.setString(1, registrar);
        rs = ps.executeQuery();
        
        String staffId = null;
        if (rs.next()) {
            staffId = rs.getString("staff_id");
        }
        rs.close();
        ps.close();
        
        String course_code = request.getParameter("course_code");
        String ac_year = request.getParameter("ac_year");
        String semester = request.getParameter("semester");
        String n = request.getParameter("staff_id");
        String staff_id = n.substring(n.length() - 6, n.length() - 1); // five digits of staff ID assumed

        String checkQuery = "SELECT course_code FROM tmatrix WHERE course_code = ? AND staff_id = ? AND semester = ? AND ac_year = ?";
        ps = connection.prepareStatement(checkQuery);
        ps.setString(1, course_code);
        ps.setString(2, staff_id);
        ps.setString(3, semester);
        ps.setString(4, ac_year);
        rs = ps.executeQuery();

        if (rs.next()) {
%>
            <div style="color:red;font-size: 16px">
                Sorry, the staff with ID <%=staff_id %> is already assigned to this course in this particular semester of the academic year <%=ac_year %>.
            </div>
<%
        } else {
            String insertQuery = "INSERT INTO tmatrix (course_code, ac_year, semester, staff_id, assigner) VALUES (?, ?, ?, ?, ?)";
            ps = connection.prepareStatement(insertQuery);
            ps.setString(1, course_code);
            ps.setString(2, ac_year);
            ps.setString(3, semester);
            ps.setString(4, staff_id);
            ps.setString(5, staffId);
            int i = ps.executeUpdate();

            if (i == 1) {
%>
                <br>
                <div style="color:green;font-size: 16px">
                    Congratulations, the Staff with ID <%=staff_id %> was successfully assigned to the course <%=course_code %>!
                </div>
<%
            } else {
%>
                <b>Sorry, Operation failed due to some internal problems. Please try again!</b>
<%
            }
        }
    } catch (Exception e) {
        out.println("There is a problem: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
%>
</body>
</html>

