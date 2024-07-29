<%-- 
    Document   : timetable_period
    Created on : Oct 11, 2013, 3:29:41 PM
    Author     : M M TECHNOLOGIES
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding = "UTF-8"%>
<!DOCTYPE html>
<html>
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <title>TIME TABLE ARRANGEMENT</title>
      <script type="text/javascript">
          function validateMyForm() {
              var isValid = true;
              var timetable = document.timetable_period;
  
              if (timetable.ac_year.value === "Select Academic Year") {
                  alert("Please select the academic year from the drop list");
                  isValid = false;
              } else if (timetable.ac_year.value === "Sorry, no Academic Year registered in the database yet!") {
                  alert("Sorry, you cannot select the warning statement");
                  isValid = false;
              } else if (timetable.semester.value === "Select Semester") {
                  alert("Please select the Semester you want to arrange for the timetable");
                  isValid = false;
              } else if (timetable.semester.value === "Sorry, no semester registered in the database yet!") {
                  alert("Sorry, you cannot select the warning statement");
                  isValid = false;
              }
  
              return isValid;
          }
      </script>
  </head>
  <body style="background-color: #FDF5E6;">
      <%
          try (Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
               Statement statement = connection.createStatement()) {
              Class.forName("com.mysql.jdbc.Driver");
      %>
      <center>
          <h2>Please Choose the Academic year and the semester you want to arrange the timetable</h2>
          <form name="timetable_period" action="https://www.saut-timas.co.tz/course_to_arrange.jsp" method="POST">
              <fieldset>
                  <legend align="left"><em><b>Time Table Arrangement</b></em></legend>
                  Academic Year:
                  <select name="ac_year">
                      <option selected="selected">Select Academic Year</option>
                      <%
                          String query = "SELECT ac_year FROM semesterisation LIMIT 1;";
                          ResultSet rs1 = statement.executeQuery(query);
                          if (!rs1.next()) {
                      %>
                      <option>Sorry, no Academic Year registered in the database yet!</option>
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
                  </select>
                  <br><br>
                  Semester:
                  <select name="semester">
                      <option selected="selected">Select Semester</option>
                      <%
                          String query2 = "SELECT DISTINCT semester FROM semesterisation;";
                          ResultSet rs2 = statement.executeQuery(query2);
                          if (!rs2.next()) {
                      %>
                      <option>Sorry, no semester registered in the database yet!</option>
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
                  </select>
                  <br><br>
              </fieldset>
              <button type="reset">Reset All</button>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <button type="submit" onclick="return validateMyForm();">Continue&gt;&gt;&gt;</button>
          </form>
      </center>
      <%
          } catch (Exception e) {
              out.println("There is a problem here: <br>" + e.getMessage());
          }
      %>
  </body>
  </html>
  