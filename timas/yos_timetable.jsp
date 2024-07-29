<%-- 
    Document   : yos_timetable
    Created on : Nov 14, 2013, 8:39:43 AM
    Author     : M M TECHNOLOGIES
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding = "UTF-8"%>
<!DOCTYPE html>
<html>
  <head> 
    <title>TIMETABLE MANAGEMENT SYSTEM</title>
    <script type="text/javascript" language="javascript">  
      function validateMyForm () { 
        var isValid = true;
        var timetable = document.yos_timetable;
        
        if (timetable.ac_year.value === "Select Academic Year") { 
          alert("Please Select the academic year from the drop list"); 
          isValid = false;
        } else if (timetable.ac_year.value === "Sorry, no academic year is found in the timetable system yet!") { 
          alert("Sorry, you cannot select the warning statement"); 
          isValid = false;
        } else if (timetable.semester.value === "Select Semester") { 
          alert("Please select the Semester"); 
          isValid = false;
        } else if (timetable.semester.value === "Sorry, no semester is found in the timetable system yet!") { 
          alert("Sorry, you cannot select the warning statement"); 
          isValid = false;
        } else if (timetable.yos.value === "choose yos") { 
          alert("Please select the year of study from which you want to view the timetable"); 
          isValid = false;
        }
        return isValid;
      }
    </script>
  </head>
  <body bgcolor="FDF5E6">
    <%
      String url = "jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas";
      String user = "makubogm_timas";
      String password = "Jokama@78";
      
      try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(url, user, password);
        
        String acYearQuery = "SELECT DISTINCT ac_year FROM timetable";
        String semesterQuery = "SELECT DISTINCT semester FROM timetable";
        
        PreparedStatement acYearStmt = connection.prepareStatement(acYearQuery);
        PreparedStatement semesterStmt = connection.prepareStatement(semesterQuery);
        
        ResultSet rsAcYear = acYearStmt.executeQuery();
        ResultSet rsSemester = semesterStmt.executeQuery();
    %>
    <center>
      <h3>To view a timetable for courses of a chosen year of study please fill in the details below and then click 'Retrieve'</h3>
      <form name="yos_timetable" action="view_yos_timetable_process.jsp" method="POST">
        <fieldset>
          <legend align="left"><em><b>Retrieving Timetable for courses of a particular year of study</b></em></legend>
          
          Academic Year: 
          <select name="ac_year"> 
            <option selected="selected">Select Academic Year</option>
            <%
              if (!rsAcYear.next()) { 
            %>             
              <option>Sorry, no academic year is found in the timetable system yet!</option>
            <% 
              } else {
                rsAcYear.beforeFirst();
                while(rsAcYear.next()) { 
            %>  
              <option><%= rsAcYear.getString("ac_year") %></option>
            <% 
                }
              } 
            %>          
          </select> <br><br>
          
          Semester: 
          <select id="semester" name="semester"> 
            <option selected="selected">Select Semester</option>
            <%
              if (!rsSemester.next()) { 
            %>             
              <option>Sorry, no semester is found in the timetable system yet!</option>
            <% 
              } else {
                rsSemester.beforeFirst();
                while(rsSemester.next()) { 
            %>  
              <option><%= rsSemester.getString("semester") %></option>
            <% 
                }
              } 
            %>          
          </select> <br><br>             
          
          Year Of Study: 
          <select name="yos" id="yos"> 
            <option selected="selected">choose yos</option>
            <option>1</option>
            <option>2</option>
            <option>3</option>
          </select><br>  
        </fieldset>   
        <input type="reset" value="Clear All"> &nbsp; &nbsp; &nbsp; &nbsp; 
        <input name="button" type="submit" value="Retrieve" onclick="javascript:return validateMyForm();"/>
      </form>
    </center>
    <%
      } catch (ClassNotFoundException | SQLException e) {
        out.println("There is a problem. See More details hereunder: <br>" + e.getMessage());
      }
    %>
  </body>
</html>
