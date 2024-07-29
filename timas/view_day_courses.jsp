<%-- 
    Document   : view_day_courses
    Created on : Nov 12, 2013, 7:31:04 PM
    Author     : M M TECHNOLOGIES, C.
    <%@page import="java.sql.*"%>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
    <head>
        <title>TIMAS | View Day Timetable</title>
        <script type="text/javascript" language="javascript">
            function validateMyForm() { 
                var isValid = true;
                var timetable = document.view_day_courses;
    
                if (timetable.ac_year.value === "Select Academic Year") { 
                    alert("Please Select the academic year from the drop list"); 
                    isValid = false;
                } else if (timetable.ac_year.value === "Sorry, no academic year is found in the timetable system yet!") { 
                    alert("Sorry, you cannot select the warning statement"); 
                    isValid = false;
                } else if (timetable.semester.value === "Select Semester") { 
                    alert("Please select the Semester"); 
                    isValid = false;
                } else if (timetable.semester.value === " Sorry, no semester is found in the timetable system yet!") { 
                    alert("Sorry, you cannot select the warning statement"); 
                    isValid = false;
                } else if (timetable.day.value === "choose day") { 
                    alert("Please select the day for which you want to view courses running"); 
                    isValid = false;
                }
                return isValid;
            }
        </script>
    </head>
    <body bgcolor="FDF5E6">
        <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");
            Statement statement = connection.createStatement();
        %>
        <center>
            <h2>Fill in the details below and then click 'View'</h2>
            <form name="view_day_courses" action="day_timetable_process.jsp" method="POST">
                <fieldset>
                    <legend align="left"><em><b>Retrieving Timetable for courses running in a day</b></em></legend>
                    Academic Year: 
                    <select name="ac_year">
                        <option selected="selected">Select Academic Year</option>
                        <%     
                        String query = "select distinct ac_year from timetable;"; 
                        ResultSet rs1 = statement.executeQuery(query);
                        if (!rs1.next()) { 
                        %>             
                        <option>Sorry, no academic year is found in the timetable system yet!</option>
                        <% } else {
                            rs1.beforeFirst();
                            while(rs1.next()) {                           
                        %>  
                        <option><%=rs1.getString("ac_year")%></option>
                        <% }
                        } %>          
                    </select><br><br>
                    Semester: 
                    <select id="semester" name="semester">
                        <option selected="selected">Select Semester</option>
                        <%     
                        String query2 = "select distinct semester from timetable;"; 
                        ResultSet rs2 = statement.executeQuery(query2);
                        if (!rs2.next()) { 
                        %>             
                        <option>Sorry, no semester is found in the timetable system yet!</option>
                        <% } else {
                            rs2.beforeFirst();
                            while(rs2.next()) {                           
                        %>  
                        <option><%=rs2.getString("semester")%></option>
                        <% }
                        } %>          
                    </select><br><br>
                    Day: 
                    <select name="day" id="day">
                        <option selected="selected">choose day</option>
                        <option>Monday</option>
                        <option>Tuesday</option>
                        <option>Wednesday</option>
                        <option>Thursday</option>
                        <option>Friday</option>
                    </select><br>  
                </fieldset>
                <input type="reset" value="Clear All">&nbsp; &nbsp; &nbsp; &nbsp; 
                <input name="button" type="submit" value="View" onclick="javascript:return validateMyForm();"/>
            </form>
        </center>
        <% 
        } catch(Exception e) {
            out.println("There is a problem here: <br>" + e.getMessage());
        }            
        %>
    </body>
    </html>
    