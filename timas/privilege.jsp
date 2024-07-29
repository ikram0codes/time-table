<%-- 
    Document   : timetable_period
    Created on : Oct 11, 2013, 3:29:41 PM
    Author     : M M TECHNOLOGIES
    <%@page import="java.sql.*"%>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
    <head>
        <title>TIMAS | Assign Privilege</title>
        <script type="text/javascript" language="javascript">  
        function validateMyForm() { 
            var isValid = true;
            var timetable = document.timetable_period;
           
            if (timetable.ac_year.value === "Select Academic Year") { 
                alert("Please select the academic year from the drop list"); 
                isValid = false;
            } 
            else if (timetable.ac_year.value === "Sorry, no Academic Year registered in the database yet!") { 
                alert("Sorry, you cannot select the warning statement"); 
                isValid = false;
            }
            else if (timetable.semester.value === "Select Semester") { 
                alert("Please select the semester you want to arrange for the timetable"); 
                isValid = false;
            }
            else if (timetable.semester.value === "Sorry, no semester registered in the database yet!") { 
                alert("Sorry, you cannot select the warning statement"); 
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
            <h2>Please choose the academic year and the semester you want to arrange the timetable for</h2>
            
            <form name="timetable_period" action="https://www.saut-timas.co.tz/assign_privilege.jsp" method="POST">
                <fieldset>
                    <legend align="left"><em><b>Assign Privilege</b></em></legend>
                    
                    Staff: 
                    <select name="ac_year"> 
                        <option selected="selected">Select Academic Year</option>
                        <%     
                        String query = "SELECT DISTINCT ac_year FROM semesterisation;";
                        ResultSet rs1 = statement.executeQuery(query);
                        if (!rs1.next()) { 
                        %>             
                        <option>Sorry, no Academic Year registered in the database yet!</option>
                        <% } else { 
                            rs1.beforeFirst();
                            while (rs1.next()) {                           
                        %>  
                        <option><%= rs1.getString("ac_year") %></option>
                        <% } } %>          
                    </select> 
                    <br><br>
                    Semester: 
                    <select id="semester" name="semester"> 
                        <option selected="selected">Select Semester</option>
                        <%     
                        String query2 = "SELECT DISTINCT semester FROM semesterisation;"; 
                        ResultSet rs2 = statement.executeQuery(query2);
                        if (!rs2.next()) { 
                        %>             
                        <option>Sorry, no semester registered in the database yet!</option> 
                        <% } else { 
                            rs2.beforeFirst();
                            while (rs2.next()) {                           
                        %>  
                        <option><%= rs2.getString("semester") %></option>
                        <% } } %>          
                    </select> 
                    <br><br>
                </fieldset>
                <button type="reset" value="Clear All">Reset All</button>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button name="button" type="submit" value="Arrange" onclick="javascript:return validateMyForm();">Continue >></button>
            </form>
        </center>
        <% 
        } catch (Exception e) {
            out.println("There is a problem here: <br>" + e.getMessage());
        }            
        %>                                       
    </body>
    </html>
    