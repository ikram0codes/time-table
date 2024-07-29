<%-- 
    Document   : extract_faculty_tmatrix
    Created on : Jun 8, 2014, 5:38:05 AM
    Author     : M M TECHNOLOGIES
    <%@page import="java.sql.*"%>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>TIMAS | Teaching Matrix</title>
        <script type="text/javascript">  
            function validateMyForm() { 
                var isValid = true;
                var tmatrix1 = document.tmatrix;
                if (tmatrix1.fac_code.value === "Select Faculty") { 
                    alert("Please select the Faculty"); 
                    isValid = false;
                } else if (tmatrix1.ac_year.value === "Select Academic Year") { 
                    alert("Please select the Academic Year"); 
                    isValid = false;
                } else if (tmatrix1.semester.value === "Select Semester") { 
                    alert("Please select the Semester"); 
                    isValid = false;
                }
                return isValid;
            }
        </script>
        <link rel="stylesheet" type="text/css" href="mystylesheet.css">
    </head>
    <body>
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas","Jokama@78");
            Statement statement = connection.createStatement();
    %>
        <center>
            <h2>Please fill in the details below then click 'extract'</h2>
            <form name="tmatrix" action="view_tmatrix_process.jsp" method="POST">
                <fieldset>
                    <legend align="left">
                        <em><b>Extracting Faculty Teaching Matrix</b></em>
                    </legend>
                    <label for="fac_code_no">Faculty Code:</label>   
                    <select id="fac_code_no" name="fac_code"> 
                        <option selected="selected">Select Faculty</option>      
                        <%
                            String query3 = "SELECT fac_code FROM faculty;";
                            ResultSet rs3 = statement.executeQuery(query3);
                            if (!rs3.next()) { 
                        %>             
                            <option>Sorry, no Faculty registered in the database yet!</option>
                        <% } else {  
                            rs3.beforeFirst(); // return the pointer to 'before first row' to avoid skipping the first row 
                            while (rs3.next()) {                           
                        %>             
                            <option><%= rs3.getString("fac_code") %></option>       
                        <% } } %>
                    </select>
                    <br><br>
                    <label for="ac_year">Academic Year:</label>   
                    <select id="ac_year" name="ac_year"> 
                        <option selected="selected">Select Academic Year</option>   
                        <%
                            String query4 = "SELECT ac_year FROM semesterisation;";
                            ResultSet rs4 = statement.executeQuery(query4);
                            if (!rs4.next()) { 
                        %>             
                            <option>Sorry, no academic year registered in the database yet!</option>
                        <% } else {  
                            rs4.beforeFirst(); // return the pointer to 'before first row' to avoid skipping the first row 
                            while (rs4.next()) {                           
                        %>             
                            <option><%= rs4.getString("ac_year") %></option>     
                        <% } } %> 
                    </select>
                    <br><br>
                    <label for="semester">Semester:</label>   
                    <select id="semester" name="semester"> 
                        <option selected="selected">Select Semester</option>   
                        <%
                            String query5 = "SELECT DISTINCT semester FROM semesterisation;";
                            ResultSet rs5 = statement.executeQuery(query5);
                            if (!rs5.next()) { 
                        %>             
                            <option>Sorry, no semester registered in the database yet!</option>
                        <% } else {  
                            rs5.beforeFirst(); // return the pointer to 'before first row' to avoid skipping the first row 
                            while (rs5.next()) {                           
                        %>             
                            <option><%= rs5.getString("semester") %></option>
                        <% } } %> 
                    </select> 
                    <br><br>
                </fieldset>
                <input type="reset" value="Clear"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input name="button" type="submit" value="Extract" onClick="return validateMyForm();"/>
            </form>
        </center>
    <%
        } catch (Exception e) {
            out.println("There is an exception: <br>" + e);
        }
    %>
    </body>
    </html>
    