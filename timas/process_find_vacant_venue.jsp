<%-- 
    Document   : process_find_vacant_venue
    Created on : Nov 16, 2013, 12:35:39 PM
    Author     : M M TECHNOLOGIES, C.
    <%@page import="java.sql.SQLException"%>
    <%@page import="java.sql.ResultSet"%>
    <%@page import="java.sql.Statement"%>
    <%@page import="java.sql.DriverManager"%>
    <%@page import="java.sql.Connection"%>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    
    <!DOCTYPE html>
    <html>
    <head>
        <link rel="stylesheet" type="text/css" href="https://saut-timas.co.tz/css/dataTables.css">
        <link rel="stylesheet" type="text/css" href="https://saut-timas.co.tz/css/themeroller.css">
        <script type="text/javascript" src="https://saut-timas.co.tz/js/min.js"></script>
        <script type="text/javascript" src="https://saut-timas.co.tz/js/dataTables_min.js"></script>
        <title>TIMAS | Find Vacant Venue</title>
        <link rel="stylesheet" type="text/css" href="mystyle.css">
        <script>
            function printPage(id) {
                var html = "<html>";
                html += document.getElementById(id).innerHTML;
                html += "</html>";
                var printWin = window.open('', '', 'letf=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
                printWin.document.write(html);
                printWin.document.close();
                printWin.focus();
                printWin.print();
                printWin.close();
            }
        </script>
    </head>
    <body bgcolor="FDF5E6">
        <script>
            $(document).ready(function() {
                $('#example').dataTable({"sPaginationType": "full_numbers"});
            });
        </script>
    
        <%
        try { 
            String ac_year = request.getParameter("ac_year");
            String semester1 = request.getParameter("semester");
            int semester = Integer.parseInt(semester1);
            String day = request.getParameter("day");
            String start_time1 = request.getParameter("start_time");
            int start_time = Integer.parseInt(start_time1);
            String end_time1 = request.getParameter("end_time");
            int end_time = Integer.parseInt(end_time1);  
    
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas","Jokama@78");
    
            Statement statement1 = connection.createStatement();
            Statement statement2 = connection.createStatement();
            Statement statement3 = connection.createStatement();
            Statement statement4 = connection.createStatement();
            Statement statement5 = connection.createStatement();
    
            String query1 = "SELECT timetable.lesson_type, timetable.room_name, timetable.block_no, room.capacity AS room_capacity, start_time, end_time " +
                            "FROM timetable, room " +
                            "WHERE ac_year = '" + ac_year + "' AND semester = " + semester + " AND day = '" + day + "' AND room.room_name = timetable.room_name;";
    
            ResultSet rs1 = statement1.executeQuery(query1);
    
            if (!rs1.next()) { 
        %>
                <br>
                <div style="font-size: 16px; color: #076f65"> All Teaching Venues are free on this day as there is no teaching schedule for this day</div>                    
        <%
            } else { 
        %>
                <div align="right"> 
                    <br>
                    <input type="button" value="PRINT THIS DOCUMENT" onclick="printPage('printable');">
                </div>
                <div id="printable">
                    <h2 align="center">
                        <b style="background-color: yellow"><%=day.toUpperCase()%></b> FREE VENUES 
                        FROM <b style="background-color: yellow">
                        <%
                            if (start_time < 10) { 
                                out.println("0" + start_time + "00");
                            } else {
                                out.println(start_time + "00");
                            }
                        %></b>
                        TO
                        <b style="background-color: yellow"><%
                            if (end_time < 10) { 
                                out.println("0" + end_time + "00");
                            } else {
                                out.println(end_time + "00");
                            }
                        %></b>
                    </h2> 
                    <table border="1" cellpadding="0" cellspacing="0" class="dataTable" id="example">
                        <thead>
                            <tr bgcolor="matembele">
                                <th>VENUE</th>
                                <th>BLOCK NUMBER</th>
                                <th>TIME</th>
                                <th>CAPACITY</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            rs1.beforeFirst();
                            // Creating a temporary table to store all venues that are free at a given interval of time
                            String temp_table = "CREATE TABLE temp_table(start_time INT(2), room_name VARCHAR(10), block_no VARCHAR(20), room_capacity INT(3));";
                            statement2.executeUpdate(temp_table);  
                            while (rs1.next()) {
                                if (rs1.getString("lesson_type").equals("Practical")) {
                                    for (int time = start_time; time < end_time; time++) {
                                        // Skip the time occupied by practical sessions                                               
                                        if (rs1.getInt("start_time") != time && rs1.getInt("start_time") + 1 != time && rs1.getInt("start_time") + 2 != time) {
                                            // Insert venue details into the temporary table created                            
                                            String insert = "INSERT INTO temp_table(start_time, room_name, block_no, room_capacity) " +
                                                            "VALUES(" + time + ", '" + rs1.getString("room_name") + "', '" + rs1.getString("block_no") + "', " + rs1.getInt("room_capacity") + ");";   
                                            statement2.executeUpdate(insert);
                                        }
                                    }                                     
                                } else {
                                    for (int time = start_time; time < end_time; time++) { 
                                        // Skip the time occupied by non-practical sessions                                               
                                        if (rs1.getInt("start_time") != time) {
                                            // Insert venue details into the temporary table created                                                                
                                            String insert = "INSERT INTO temp_table(start_time, room_name, block_no, room_capacity) " +
                                                            "VALUES(" + time + ", '" + rs1.getString("room_name") + "', '" + rs1.getString("block_no") + "', " + rs1.getInt("room_capacity") + ");";  
                                            statement2.executeUpdate(insert);                           
                                        }        
                                    }
                                }                                                  
                            }
                            // Retrieve free venues
                            String query2 = "SELECT DISTINCT start_time, room_name, block_no, room_capacity FROM temp_table;";
                            ResultSet rs2 = statement2.executeQuery(query2);
                            rs2.beforeFirst();
                            while (rs2.next()) {
                                // Formatting the time (for display purposes)
                                if (rs2.getInt("start_time") < 10) {
                                    out.println("<tr><td bgcolor=\"capacity\">" + rs2.getString("room_name") + "</td>");
                                    out.println("<td bgcolor=\"capacity\">" + rs2.getString("block_no") + "</td>");
                                    out.println("<td bgcolor=\"capacity\">0" + rs2.getInt("start_time") + "00</td>");
                                    out.println("<td bgcolor=\"capacity\">" + rs2.getInt("room_capacity") + "</td></tr>");
                                } else {
                                    out.println("<tr><td bgcolor=\"capacity\">" + rs2.getString("room_name") + "</td>");
                                    out.println("<td bgcolor=\"capacity\">" + rs2.getString("block_no") + "</td>");
                                    out.println("<td bgcolor=\"capacity\">" + rs2.getInt("start_time") + "00</td>");
                                    out.println("<td bgcolor=\"capacity\">" + rs2.getInt("room_capacity") + "</td></tr>");
                                }
                            }
                            // Retrieve all teaching venues from the database
                            String query3 = "SELECT room_no, room_name, block_no, capacity FROM room WHERE purpose LIKE '%teaching%';";
                            ResultSet rs3 = statement3.executeQuery(query3);
                            while (rs3.next()) {
                                // Retrieve venues that are not found in the temp table but are out of use the whole day  
                                String query4 = "SELECT DISTINCT room_name FROM temp_table WHERE room_name != '" + rs3.getString("room_name") + "';";
                                ResultSet rs4 = statement4.executeQuery(query4);
    
                                if (rs4.next()) {
                                    rs4.beforeFirst();
                                    while (rs4.next()) {
                                        out.println("<tr><td bgcolor=\"abcdef\">" + rs3.getString("room_name") + "</td>");
                                        out.println("<td bgcolor=\"abcdef\">" + rs3.getString("block_no") + "</td>");
                                        out.println("<td bgcolor=\"abcdef\">Whole Day</td>");
                                        out.println("<td bgcolor=\"abcdef\">" + rs3.getInt("capacity") + "</td></tr>");
                                    } 
                                } 
                            }
                            String drop_temp_table = "DROP TABLE temp_table;"; 
                            statement2.executeUpdate(drop_temp_table);
                        %>
                        </tbody>
                    </table>
                </div>
        <%
            }
    
            if (statement1 != null) {
                statement1.close();
           
    