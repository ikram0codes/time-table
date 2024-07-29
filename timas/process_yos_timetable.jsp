<%-- 
    Document   : process_year_timetable
    Created on : Nov 14, 2013, 8:48:14 AM
    Author     : M M TECHNOLOGIES
    <%@page import="java.sql.SQLException"%>
    <%@page import="java.sql.ResultSet"%>
    <%@page import="java.sql.DriverManager"%>
    <%@page import="java.sql.Statement"%>
    <%@page import="java.sql.Connection"%>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
      <%@page import="java.sql.SQLException"%>
      <%@page import="java.sql.ResultSet"%>
      <%@page import="java.sql.DriverManager"%>
      <%@page import="java.sql.Statement"%>
      <%@page import="java.sql.Connection"%>
      <%@page contentType="text/html" pageEncoding="UTF-8"%>
      <!DOCTYPE html>
      <html>
      <head>
          <title>TIMAS | Year Of Study Timetable</title>
          <script>
              function printPage(id) {
                  var html = "<html>";
                  html += document.getElementById(id).innerHTML;
                  html += "</html>";
                  var printWin = window.open('', '', 'left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
                  printWin.document.write(html);
                  printWin.document.close();
                  printWin.focus();
                  printWin.print();
                  printWin.close();
              }
          </script>
      </head>
      <body bgcolor="FDF5E6">
      <%
          try {
              String ac_year = request.getParameter("ac_year");
              String semester = request.getParameter("semester");
              int yos = Integer.parseInt(request.getParameter("yos"));
      
              Class.forName("com.mysql.jdbc.Driver");
              Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
              Statement statement = connection.createStatement();
              String timetable = "select ac_year, timetable.semester as semester, timetable.course_code as course_code, day, lesson_type, room_no, block_no, start_time, end_time, room_name from timetable, course where ac_year='" + ac_year + "' and timetable.semester='" + semester + "' and course.course_code=timetable.course_code and course.yos=" + yos + ";";
              ResultSet rs = statement.executeQuery(timetable);
      
              if (!rs.next()) {
      %>
              <br>
              <div style="color:red;font-size: 14px;"> Sorry, the timetable for this Year of Study is still not available/no longer existing in the system</div>
      <%
              } else {
      %>
              <div align="right">
                  <br><input type="button" value="PRINT THIS TIMETABLE" onclick="printPage('printable');">
              </div>
              <div id="printable">
      <%
                  if (yos == 1) {
      %>
                  <h2 align="center">FIRST YEAR TIMETABLE FOR SEMESTER <%= semester %> OF ACADEMIC YEAR <%= ac_year %></h2>
      <%
                  } else if (yos == 2) {
      %>
                  <h2 align="center">SECOND YEAR TIMETABLE FOR SEMESTER <%= semester %> OF ACADEMIC YEAR <%= ac_year %></h2>
      <%
                  } else if (yos == 3) {
      %>
                  <h2 align="center">THIRD YEAR TIMETABLE FOR SEMESTER <%= semester %> OF ACADEMIC YEAR <%= ac_year %></h2>
      <%
                  } else if (yos == 4) {
      %>
                  <h2 align="center">FOURTH YEAR TIMETABLE FOR SEMESTER <%= semester %> OF ACADEMIC YEAR <%= ac_year %></h2>
      <%
                  }
      %>
                  <table BORDER="1" align="center">
                      <tr bgcolor="matembele">
                          <th>COURSE CODE</th>
                          <th>LESSON TYPE</th>
                          <th>DAY</th>
                          <th>START TIME</th>
                          <th>END TIME</th>
                          <th>ROOM NAME</th>
                          <th>BLOCK NUMBER</th>
                      </tr>
      <%
                  rs.beforeFirst();
                  while (rs.next()) {
                      String bgcolor = "";
                      switch (rs.getString("day").toLowerCase()) {
                          case "monday":
                              bgcolor = "yellow";
                              break;
                          case "tuesday":
                              bgcolor = "abcdef";
                              break;
                          case "wednesday":
                              bgcolor = "ea9020";
                              break;
                          case "thursday":
                              bgcolor = "loveness";
                              break;
                          case "friday":
                              bgcolor = "stanford";
                              break;
                          case "saturday":
                              bgcolor = "orange";
                              break;
                          case "sunday":
                              bgcolor = "pink";
                              break;
                      }
                      out.println("<tr bgcolor=\"" + bgcolor + "\"><td>" + rs.getString("course_code") + "</td><td>" + rs.getString("lesson_type") + "</td><td bgcolor=\"" + bgcolor + "\">" + rs.getString("day") + "</td>");
      
                      int start_time = rs.getInt("start_time");
                      String start_time_str = start_time < 10 ? "0" + start_time + "00" : start_time + "00";
                      String end_time_str = (start_time + (rs.getString("lesson_type").equalsIgnoreCase("Practical") ? 3 : 1)) + "00";
                      start_time_str = start_time < 10 ? "0" + start_time + "00" : start_time + "00";
                      end_time_str = (start_time < 9 ? "0" : "") + (start_time + 1) + "00";
      
                      out.println("<td>" + start_time_str + "</td><td>" + end_time_str + "</td><td>" + rs.getString("room_name") + "</td><td>" + rs.getString("block_no") + "</td></tr>");
                  }
      %>
                  </table>
              </div>
      <%
              }
          } catch (SQLException e) {
              out.println("There is a problem. See more details below: <br><br>" + e.getMessage());
          } catch (NumberFormatException nfe) {
      %>
          <h3>Sorry, there is a problem!! <i>You clicked an "Enter" button from the keyboard</i>
          <br><br>You are advised to click the 'refresh' icon on the right side of the web address (URL) bar of the browser and not the 'Enter' button if you want to refresh the data. This helps you avoid duplicate information.<br><br> Please click the back button or
          <a href="yos_timetable.jsp">restart the process</a></h3>
      <%
          } catch (NullPointerException npe) {
      %>
          <h3>Sorry, there is a problem!! <i>You clicked an "Enter" button from the keyboard</i>.
          <br><br>You are advised to click the 'refresh/reload' icon on the right side of the web address (URL) bar of the browser and not the 'Enter' button if you want to refresh the data. This helps you avoid duplicate information.<br><br> Please click the back button or
          <a href="yos_timetable.jsp">restart the process</a></h3>
      <%
          }
      %>
      </body>
      </html>
      