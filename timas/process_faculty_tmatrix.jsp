<%-- 
    Document   : process_faculty_tmatrix
    Created on : Jun 8, 2014, 6:37:17 AM
    Author     : M M TECHNOLOGIES
    <%@ page import="java.sql.*" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>
    <head>
        <link rel="stylesheet" type="text/css" href="https://saut-timas.co.tz/css/dataTables.css">
        <link rel="stylesheet" type="text/css" href="https://saut-timas.co.tz/css/themeroller.css">
        <script type="text/javascript" src="https://saut-timas.co.tz/js/min.js"></script>
        <script type="text/javascript" src="https://saut-timas.co.tz/js/dataTables_min.js"></script>
        <script>
            function printPage(id) {
                var html = "<html>" + document.getElementById(id).innerHTML + "</html>";
                var printWin = window.open('', '', 'left=0,top=0,width=1000,height=900,toolbar=0,scrollbars=0,status=0');
                printWin.document.write(html);
                printWin.document.close();
                printWin.focus();
                printWin.print();
                printWin.close();
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FACULTY TEACHING MATRIX</title>
        <link rel="stylesheet" type="text/css" href="mystylesheet.css" media="screen">
    </head>
    <body>
        <script>
            $(document).ready(function() {
                $('#example').dataTable({"sPaginationType": "full_numbers"});
            });
        </script>
        <% 
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
                Statement statement = connection.createStatement();
                Statement statement1 = connection.createStatement();
                
                String query = "SELECT course.course_code AS course_code, course.course_name AS course_name, course.units AS units, course.yos AS year_of_study, CONCAT(e.fname, ' ', e.lname) AS lecturer " +
                               "FROM course, tmatrix ta, staff e " +
                               "WHERE e.staff_id = ta.staff_id " +
                               "AND course.course_code = ta.course_code " +
                               "AND ta.course_code IN (SELECT course_code FROM course WHERE dept_no IN (SELECT dept_no FROM department WHERE fac_code = '" + request.getParameter("fac_code") + "')) " +
                               "AND ta.ac_year = '" + request.getParameter("ac_year") + "' " +
                               "AND ta.semester = '" + request.getParameter("semester") + "';";
                
                ResultSet rs = statement.executeQuery(query);
    
                if (!rs.next()) {
        %>
                    <br>
                    <div style="color:red">Sorry, The Teaching Matrix for Semester <%= request.getParameter("semester") %> of Academic Year <%= request.getParameter("ac_year") %> is not yet available. Please try again later.</div>
        <% 
                } else {
                    String query1 = "SELECT fac_name FROM faculty WHERE fac_code = '" + request.getParameter("fac_code") + "'";
                    ResultSet rs1 = statement1.executeQuery(query1);
                    rs1.next();
        %>
                    <div align="right">
                        <br><input type="button" value="PRINT THIS DOCUMENT" onclick="printPage('printable');">
                    </div>
                    <div id="printable">
                        <h3>
                            <b style="background-color: yellow"><%= rs1.getString("fac_name").toUpperCase() %></b> TEACHING MATRIX FOR ACADEMIC YEAR <%= request.getParameter("ac_year") %> SEMESTER <%= request.getParameter("semester") %>
                        </h3>
                        <table border="1" cellpadding="0" cellspacing="0" class="dataTable" id="example">
                            <thead>
                                <tr bgcolor="silver">
                                    <th>COURSE CODE</th>
                                    <th>COURSE NAME</th>
                                    <th>CREDITS</th>
                                    <th>YOS</th>
                                    <th>LECTURER</th>
                                </tr>
                            </thead>
                            <tbody>
        <% 
                    rs.beforeFirst();
                    while (rs.next()) {
        %>
                                <tr>
                                    <td align="left"><%= rs.getString("course_code") %></td>
                                    <td align="left"><%= rs.getString("course_name") %></td>
                                    <td><%= rs.getInt("units") * 4 %></td>
                                    <td><%= rs.getString("year_of_study") %></td>
                                    <td align="left"><%= rs.getString("lecturer") %></td>
                                </tr>
        <% 
                    }
        %>
                            </tbody>
                        </table>
                    </div>
        <% 
                }
            } catch (SQLException e) {
                out.println("Sorry, there is a problem. See more details below:<br><br>" + e.getMessage());
            }
        %>
    </body>
    </html>
    

