<%-- 
    Document   : Compute_Timetable
    Created on : Nov 21, 2015, 8:57:57 AM
    Author     : M M TECHNOLOGIES
--%>
<%@page import="java.lang.IllegalArgumentException"  %>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%

/**
 *
 * @author M M TECHNOLOGIES
 */

        
       //out.println("  <SCRIPT type=\"text/javascript\">");  
    //out.println("window.history.forward(); function noBack() { window.history.forward(); }</SCRIPT><SCRIPT type=\"text/javascript\">window.history.forward();function noBack() { window.history.forward(); }</SCRIPT>");
    
%>
<head><title>
TIMAS | Computing Timetable
</title>
       
         <link rel="stylesheet" type="text/css" href="https://saut-timas.co.tz/css/dataTables.css">
      <link rel="stylesheet" type="text/css" href="https://saut-timas.co.tz/css/themeroller.css">


        <script type="text/javascript"  src="https://saut-timas.co.tz/js/min.js"></script>
        <script type="text/javascript"  src="https://saut-timas.co.tz/js/dataTables_min.js"></script>
   
</head><body>
        <script>
          $(document).ready(function() {
    $('#example').dataTable({"sPaginationType": "full_numbers"});
});  
            
            
        </script>
<%

        //out.println("<body onload=\"noBack();\" onpageshow=\"if (event.persisted) noBack();\" onunload=\"\" bgcolor=\"FDF5E6\">");
        

       try {
           String day="";
           HttpSession s2=request.getSession(false);
           String course_code=(String)s2.getAttribute("course_code");
           String ac_year=(String)s2.getAttribute("ac_year");
           String semester=(String)s2.getAttribute("semester");
           String lesson_type=(String)s2.getAttribute("lesson_type");
      /*IN ORDER TO AVOID RESULT SETS TO EXPLICITLY CLOSE DUE TO INTERLEAVING,
       I CREATED A SEPARATE STATEMENT OBJECT FOR EVERY RESULTSET. THIS TECHNIQUE HELPS TO AVOID NULL POINTER EXCEPTION*/
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection=DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas","Jokama@78");
            Statement statement1=connection.createStatement();
            Statement statement2=connection.createStatement(); 
            Statement statement3=connection.createStatement(); 
            Statement statement4=connection.createStatement(); 
            Statement statement5=connection.createStatement();
            Statement statement6=connection.createStatement();  
            Statement statement7=connection.createStatement();   
            Statement statement8=connection.createStatement();
            Statement statement9=connection.createStatement();
            Statement statement10=connection.createStatement();
            Statement statement11=connection.createStatement();
            Statement statement12=connection.createStatement();
            Statement statement13=connection.createStatement();
            Statement statement14=connection.createStatement();
            HttpSession s=request.getSession(false);
            String id=(String)s.getAttribute("id");
            //record the time this course was called
            statement14.executeUpdate("insert into computed(id) values('"+id+"')");
            
              //count the total number of students registered for this course in this semester
            String query1="select count(*) as total_students from student_course where course_code='"+course_code+"' and ac_year='"+ac_year+"' and semester='"+semester+"';"; 
            ResultSet rs1=statement1.executeQuery(query1); 
            //Search the lecturer who is teaching this course in this semester of this academic year
            String query2="select staff_id from tmatrix where "
                    + "course_code='"+course_code+"' and ac_year='"+ac_year+"' and semester="+semester+";";
            ResultSet rs2=statement2.executeQuery(query2);         
           // Search the rooms that can accomodate these students              
             if(!rs1.next()){//courses without students cannot be placed in the timetable
                            out.println("Result Set rs1 did not select from the database. "
                                    + "Please see the database administrator for help");
                       }        
                        else if(rs1.getInt("total_students")==0){//check if there is any student registered for the course
                        out.println(" <br>Sorry, there is no student registered for this course!!! "
                            + "So you can't place this course in the timetable");  
                        } 
                      else{ 
                            //search for reasonably vacant room to accomodate the students. studnts should occupy at least 90% of the venue
                      String query3="select room_no,room_name,block_no,capacity from room where"
                      + " purpose like '%teaching%' and ("+rs1.getInt("total_students")+"/capacity)>=0.9 and ("+rs1.getInt("total_students")+"/capacity)<=1;";
                      //out.println("total students (rs1): "+rs1.getInt("total_students")); 
                      ResultSet rs3=statement3.executeQuery(query3);      
                      if (!rs3.next()){//check if there is a venue to accomodate these students
                      out.println("Sorry!!! It seems there is no venue to accomodate all these students. "
                        + "Strongly advised to categorise them into groups!! and then try again later or see the system administrator");//needs rethinking!
                        }
                      else if(!rs2.next()){ //check whether the course is running/not assigned to a lecturer
                          //if the course does not appear in the teaching allocation for this particular period, It is obviously not running
                      out.println("Sorry, It seems there is no staff allocated to teach this course yet or it is not running in this semester "
                      + "So you cannot locate it in the teaching timetable");
                      }
                      else{ //The course is assigned with a lecturer
                       
                      //Search the year of study the course is set for      
                       String query4="select yos from course where course_code='"+course_code+"';"; 
                       ResultSet rs4=statement4.executeQuery(query4);
                       if(!rs4.next()){
                       out.println("Sorry, this course seems to be not registered in the database "
                               + "or there is no year of study for this course");
                       }
                       else{ 
                      // out.println("<br>YOS rs4 has "+rs4.getInt("yos")); 
                       String query6="select combination from combination_courses "
                               + "where course_code='"+course_code+"';";
                       ResultSet rs6=statement6.executeQuery(query6);
                       if(!rs6.next()){
                       out.println("Sorry this course is not allocated to any subject combination and thus it cannot be placed in the T/timetable of this semester");
                       }
                       else{
                       //check mate courses from different combinations. These courses can not be allocated at the same time
                       String query7="select combination.course_code from combination_courses combination,course where combination.course_code<>'"+course_code+"'"
                       + " and combination like '%"+rs6.getString("combination")+"%' and course.yos="+rs4.getInt("yos")+" and course.semester='"+semester+"' and course.course_code=combination.course_code;";
                       ResultSet rs7=statement7.executeQuery(query7);
                      //check other (mate) courses this lecturer is teaching so that to avoid allocating them at the same time
                       String query5="select course_code from tmatrix where ac_year='"+ac_year+"' and semester='"+semester+"'"
                       + "and staff_id='"+rs2.getString("staff_id")+"'and course_code<>'"+course_code+"';";
                       ResultSet rs5=statement5.executeQuery(query5);
                       if(rs5.next()|rs7.next()){
                       rs5.beforeFirst();rs7.beforeFirst();
                       while(rs5.next()|rs7.next()){
                        String query8="select start_time,course_code,day,lesson_type from timetable "
                                   + "where course_code in('"+rs5.getString("course_code")+"','"+rs7.getString("course_code")+"') and ac_year='"+ac_year+"' and semester='"+semester+"';";
                        ResultSet rs8=statement8.executeQuery(query8);
                           out.println("<h2 align=\"center\">TIMETABLE ARRANGEMENT FOR SEMESTER "+semester.toUpperCase()+" OF ACADEMIC YEAR "+ac_year+"</h2>");
                             
                            out.println("<br><h3 align=\"center\">Available spaces from which the course "+course_code+""
                                    + " can be placed in the timetable without collision.<br> To select the option, Click 'Choose' in the OPTION column</h3>");
                         if(rs8.next())
                         {        
                        %>  <table border="1" cellpadding="0" cellspacing="0"  class="dataTable" id="example"><thead><%
                            out.println("<tr background-color=\"matembele\">");
                            out.println("<th>DAY</th>");
                            out.println("<th>START TIME</th>");
                            out.println("<th>END TIME</th>");
                            out.println("<th>ROOM NO</th>");
                            out.println("<th>ROOM NAME</th>");
                            out.println("<th>BLOCK NO</th>");  
                            out.println("<th>OPTION</th>");
                            out.println("</tr>");
                        %></thead><tbody><%
                            String temp_table="create table enemy_courses(course_code varchar(10),day varchar(10),start_time int(3),lesson_type varchar(20));";
                            statement13.executeUpdate(temp_table);
                                rs8.beforeFirst();
                                rs3.beforeFirst();
                                while(rs8.next())
                                 {
                                String insert="insert into enemy_courses(COURSE_NO,DAY,START_TIME,lesson_type) values('"+rs8.getString("course_code")+"','"+rs8.getString("day")+"','"+rs8.getInt("start_time") +"','"+rs8.getString("lesson_type")+"');";
                                statement11.executeUpdate(insert);
                                 }                            
                                 rs8.beforeFirst();                   
                                 while(rs8.next())
                                 {
                                 while(rs3.next())
                                  {
                                 for(int days=1;days<=7;days++) 
                                 {
                                   if(days==1){day="Monday";}
                                   else if(days==2){ day="Tuesday";}
                                   else if(days==3){ day="Wednesday";}
                                   else if(days==4){ day="Thursday";}
                                   else if(days==5){ day="Friday";} 
                                   else if(days==6){ day="Saturday";}
                                   else if(days==7){ day="Sunday";}
                                   String query12="select distinct day,start_time,course_code,lesson_type from enemy_courses where day='"+day+"';"; 
                                   ResultSet rs12=statement12.executeQuery(query12);
                                     //A course CAN NOT have two sessions within a day
                                      String duplicate="select course_code from timetable where course_code='"+course_code+"' and ac_year='"+ac_year+"' and semester='"+semester+"' and day='"+day+"';";
                                      ResultSet rs10=statement10.executeQuery(duplicate);
                                      if(!rs10.next()){                                         
                                          if(!rs12.next())
                                            {                       
                                            for(int time=7;time<19;time++)
                                                {      
                                                if(!lesson_type.equalsIgnoreCase("Practical"))
                                                {                                                
                                             //check whether there is a vacant room at this (one hour) time
                                               String vacancy="select course_code from timetable where room_no="+rs3.getInt("room_no")+" and block_no='"+rs3.getString("block_no")+"' "
                                             + "and start_time="+time+" and ac_year='"+ac_year+"' and semester='"+semester+"' and day='"+day+"';";                                
                                               ResultSet rs9=statement9.executeQuery(vacancy);                                    
                                               if(!rs9.next())
                                               {                                            
                                               //option to locate the 1 hour course 
                                            if(day.equalsIgnoreCase("Monday")){out.println("<tr bgcolor=\"yellow\"> <td bgcolor=\"yellow\">"+day+"</td>");}
                                            else if(day.equalsIgnoreCase("Tuesday")){out.println("<tr bgcolor=\"abcdef\"> <td bgcolor=\"abcdef\">"+day+"</td>");}
                                            else if(day.equalsIgnoreCase("Wednesday")){out.println("<tr bgcolor=\"ea9020\"> <td bgcolor=\"ea9020\">"+day+"</td>");}
                                            else if(day.equalsIgnoreCase("Thursday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                            else if(day.equalsIgnoreCase("Friday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                            else if(day.equalsIgnoreCase("Saturday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                            else if(day.equalsIgnoreCase("Sunday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
  
                                              if(time<9)
                                              { 
                                              out.println("<td>0"+time+"00</td>");
                                              out.println("<td>0"+(time+1)+"00</td>");
                                              }
                                             else if(time==9){
                                             out.println("<td>0"+time+"00</td>");
                                              out.println("<td>"+(time+1)+"00</td>");
                                              }
                                             else {
                                             out.println("<td>"+time+"00</td>");
                                             out.println("<td>"+(time+1)+"00</td>");
                                             }
                                             out.println("<td>"+rs3.getInt("room_no")+"</td>");
                                             out.println("<td>"+rs3.getString("room_name")+"</td>");
                                             out.println("<td>"+rs3.getString("block_no")+"</td>");
                                             out.println("<FORM METHOD=\"POST\" ACTION=\"https://www.saut-timas.co.tz/insert_course_into_timetable.jsp?course_code="+course_code+"&semester="+semester+"&ac_year="+ac_year+""
                                             +"&start_time="+time+"&end_time="+(time+1)+"&lesson_type="+lesson_type+"&room_no="+rs3.getInt("room_no")+"&block_no="+rs3.getString("block_no")+"&day="+day+"\"> ");
                                             out.println("<td style=\"background-color:green\"><INPUT TYPE=\"SUBMIT\" VALUE=\"Choose\"></td>");
                                             out.println("</tr>"); 
                                             out.println("</FORM>");  
                                               }
                                              }
                                             else if(lesson_type.equalsIgnoreCase("Practical")&time<17) 
                                              {                                         
                                             String vacancy="select course_code from timetable where room_no="+rs3.getInt("room_no")+" and block_no='"+rs3.getString("block_no")+"' "
                                             + "and start_time="+time+" or start_time="+(time+1)+" or start_time="+(time+2)+" and ac_year='"+ac_year+"' and semester='"+semester+"' and day='"+day+"';";                                
                                               ResultSet rs9=statement9.executeQuery(vacancy);                                    
                                               if(!rs9.next())
                                               {                  
                                               if(day.equalsIgnoreCase("Monday")){out.println("<tr bgcolor=\"yellow\"> <td bgcolor=\"yellow\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Tuesday")){out.println("<tr bgcolor=\"abcdef\"> <td bgcolor=\"abcdef\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Wednesday")){out.println("<tr bgcolor=\"ea9020\"> <td bgcolor=\"ea9020\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Thursday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Friday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Saturday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Sunday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}

                                                if(time<7)
                                              {
                                               out.println("<td>0"+time+"00</td>");
                                               out.println("<td>0"+(time+3)+"00</td>");
                                              }
                                              else if(time>=7&time<10)
                                             {
                                              out.println("<td>0"+time+"00</td>");
                                              out.println("<td>"+(time+3)+"00</td>");
                                             }
                                             else {
                                              out.println("<td>"+time+"00</td>");
                                              out.println("<td>"+(time+3)+"00</td>");
                                                }
                                              out.println("<td>"+rs3.getInt("room_no")+"</td>");
                                              out.println("<td>"+rs3.getString("room_name")+"</td>");
                                              out.println("<td>"+rs3.getString("block_no")+"</td>");  
                                              out.println("<FORM METHOD=\"POST\" ACTION=\"https://www.saut-timas.co.tz/insert_course_into_timetable.jsp?course_code="+course_code+"&semester="+semester+"&ac_year="+ac_year+""
                                              + "&start_time="+time+"&end_time="+(time+3)+"&lesson_type="+lesson_type+"&room_no="+rs3.getInt("room_no")+"&block_no="+rs3.getString("block_no")+"&day="+day+"\">");
                                               out.println("<td bgcolor=\"green\"><INPUT TYPE=\"SUBMIT\" VALUE=\"Choose\"></td>");
                                               out.println("</tr>"); 
                                               out.println("</FORM>");
                                                }
                                               } 
                                              }
                                            }
                                           else
                                          { 
                                         //enemy course found running in the same day                                         
                                         for(int time=7;time<19;time++)
                                             {
                                           rs12.beforeFirst();
                                           while(rs12.next()){                                     
                                               //case 1:All are 1hr sessions                     
                                          if(time!=rs12.getInt("start_time")&!rs12.getString("lesson_type").equalsIgnoreCase("Practical")&(lesson_type.equals("Lecture")||lesson_type.equals("Tutorial")||lesson_type.equals("Seminar")))
                                             {
                                              String vacancy="select course_code from timetable where room_no="+rs3.getInt("room_no")+" and block_no='"+rs3.getString("block_no")+"' "
                                             + "and start_time="+time+" and ac_year='"+ac_year+"' and semester='"+semester+"' and day='"+day+"';";                                
                                               ResultSet rs9=statement9.executeQuery(vacancy);                                    
                                               if(!rs9.next())
                                             {
                                              //option to locate the 1 hour course 
                                            if(day.equalsIgnoreCase("Monday")){out.println("<tr bgcolor=\"yellow\"> <td bgcolor=\"yellow\">"+day+"</td>");}
                                            else if(day.equalsIgnoreCase("Tuesday")){out.println("<tr bgcolor=\"abcdef\"> <td bgcolor=\"abcdef\">"+day+"</td>");}
                                            else if(day.equalsIgnoreCase("Wednesday")){out.println("<tr bgcolor=\"ea9020\"> <td bgcolor=\"ea9020\">"+day+"</td>");}
                                            else if(day.equalsIgnoreCase("Thursday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                            else if(day.equalsIgnoreCase("Friday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                              else if(day.equalsIgnoreCase("Saturday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                                else if(day.equalsIgnoreCase("Sunday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}                                        
                                              if(time<9)
                                              { 
                                              out.println("<td>0"+time+"00</td>");
                                              out.println("<td>0"+(time+1)+"00</td>");
                                              }
                                             else if(time==9){
                                             out.println("<td>0"+time+"00</td>");
                                              out.println("<td>"+(time+1)+"00</td>");
                                              }
                                             else {
                                             out.println("<td>"+time+"00</td>");
                                             out.println("<td>"+(time+1)+"00</td>");
                                             }
                                             out.println("<td>"+rs3.getInt("room_no")+"</td>");
                                             out.println("<td>"+rs3.getString("room_name")+"</td>");
                                             out.println("<td>"+rs3.getString("block_no")+"</td>");
                                             out.println("<FORM METHOD=\"POST\" ACTION=\"https://www.saut-timas.co.tz/insert_course_into_timetable.jsp?course_code="+course_code+"&semester="+semester+"&ac_year="+ac_year+""
                                             +"&start_time="+time+"&end_time="+(time+1)+"&lesson_type="+lesson_type+"&room_no="+rs3.getInt("room_no")+"&block_no="+rs3.getString("block_no")+"&day="+day+"\"> ");
                                             out.println("<td bgcolor=\"green\"><INPUT TYPE=\"SUBMIT\" VALUE=\"Choose\"></td>");
                                             out.println("</tr>"); 
                                             out.println("</FORM>");  
                                              }      
                                            }
                                              // case 2: Incoming enemy course has 1hr and the existing is a practical session(3hrs))
                                              else if(time!=rs12.getInt("start_time")&time!=(rs12.getInt("start_time")+1)&time!=(rs12.getInt("start_time")+2)&rs12.getString("lesson_type").equalsIgnoreCase("Practical")&!lesson_type.equalsIgnoreCase("Practical"))
                                              {             
                                              String vacancy="select course_code from timetable where room_no="+rs3.getInt("room_no")+" and block_no='"+rs3.getString("block_no")+"' "
                                             + "and start_time="+time+" and ac_year='"+ac_year+"' and semester='"+semester+"' and day='"+day+"';";                                
                                               ResultSet rs9=statement9.executeQuery(vacancy);                                    
                                               if(!rs9.next())
                                               {
                                               //option to locate the 1 hour course 
                                             if(day.equalsIgnoreCase("Monday")){out.println("<tr bgcolor=\"yellow\"> <td bgcolor=\"yellow\">"+day+"</td>");}
                                             else if(day.equalsIgnoreCase("Tuesday")){out.println("<tr bgcolor=\"abcdef\"> <td bgcolor=\"abcdef\">"+day+"</td>");}
                                             else if(day.equalsIgnoreCase("Wednesday")){out.println("<tr bgcolor=\"ea9020\"> <td bgcolor=\"ea9020\">"+day+"</td>");}
                                             else if(day.equalsIgnoreCase("Thursday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                             else if(day.equalsIgnoreCase("Friday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                             else if(day.equalsIgnoreCase("Saturday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                             else if(day.equalsIgnoreCase("Sunday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
            
                                              if(time<9)
                                              { 
                                              out.println("<td>0"+time+"00</td>");
                                              out.println("<td>0"+(time+1)+"00</td>");
                                              }
                                             else if(time==9){
                                             out.println("<td>0"+time+"00</td>");
                                              out.println("<td>"+(time+1)+"00</td>");
                                              }
                                             else {
                                             out.println("<td>"+time+"00</td>");
                                             out.println("<td>"+(time+1)+"00</td>");
                                             }
                                             out.println("<td>"+rs3.getInt("room_no")+"</td>");
                                             out.println("<td>"+rs3.getString("room_name")+"</td>");
                                             out.println("<td>"+rs3.getString("block_no")+"</td>");
                                             out.println("<FORM METHOD=\"POST\" ACTION=\"https://www.saut-timas.co.tz/insert_course_into_timetable.jsp?course_code="+course_code+"&semester="+semester+"&ac_year="+ac_year+""
                                             +"&start_time="+time+"&end_time="+(time+1)+"&lesson_type="+lesson_type+"&room_no="+rs3.getInt("room_no")+"&block_no="+rs3.getString("block_no")+"&day="+day+"\"> ");
                                             out.println("<td bgcolor=\"green\"><INPUT TYPE=\"SUBMIT\" VALUE=\"Choose\"></td>");
                                             out.println("</tr>"); 
                                             out.println("</FORM>");  
                                               }
                                              }
                                             //case 3:All enemy courses are practical sessions(3 hours)
                                             else if(time!=rs12.getInt("start_time")&time!=(rs12.getInt("start_time")+1)&time!=(rs12.getInt("start_time")+2)&lesson_type.equals("Practical")&rs12.getString("lesson_type").equalsIgnoreCase("Practical")&time<17)
                                             { 
                                             //check whether there is a vacant room during this time (of 3 hours)
                                             String vacancy="select course_code from timetable where room_no="+rs3.getInt("room_no")+" and block_no='"+rs3.getString("block_no")+"' "
                                             + "and start_time="+time+" or start_time="+(time+1)+" or start_time="+(time+2)+" and ac_year='"+ac_year+"' and semester='"+semester+"';";                                
                                               ResultSet rs9=statement9.executeQuery(vacancy);                                    
                                               if(!rs9.next())
                                               {
                                               if(day.equalsIgnoreCase("Monday")){out.println("<tr bgcolor=\"yellow\"> <td bgcolor=\"yellow\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Tuesday")){out.println("<tr bgcolor=\"abcdef\"> <td bgcolor=\"abcdef\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Wednesday")){out.println("<tr bgcolor=\"ea9020\"> <td bgcolor=\"ea9020\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Thursday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Friday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                                else if(day.equalsIgnoreCase("Saturday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                                  else if(day.equalsIgnoreCase("Sunday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                           
                                                if(time<7)
                                              {
                                               out.println("<td>0"+time+"00</td>");
                                               out.println("<td>0"+(time+3)+"00</td>");
                                              }
                                              else if(time>=7&&time<10)
                                             {
                                              out.println("<td>0"+time+"00</td>");
                                              out.println("<td>"+(time+3)+"00</td>");
                                             }
                                             else {
                                              out.println("<td>"+time+"00</td>");
                                              out.println("<td>"+(time+3)+"00</td>");
                                                }
                                              out.println("<td>"+rs3.getInt("room_no")+"</td>");
                                              out.println("<td>"+rs3.getString("room_name")+"</td>");
                                              out.println("<td>"+rs3.getString("block_no")+"</td>");  
                                              out.println("<FORM METHOD=\"POST\" ACTION=\"https://www.saut-timas.co.tz/insert_course_into_timetable.jsp?course_code="+course_code+"&semester="+semester+"&ac_year="+ac_year+""
                                              + "&start_time="+time+"&end_time="+(time+3)+"&lesson_type="+lesson_type+"&room_no="+rs3.getInt("room_no")+"&block_no="+rs3.getString("block_no")+"&day="+day+"\">");
                                              out.println("<td bgcolor=\"green\"><INPUT TYPE=\"SUBMIT\" VALUE=\"Choose\"></td>");
                                              out.println("</tr>"); 
                                              out.println("</FORM>");
                                               }
                                              }
                                              //case 4: Incoming is 3hrs session, found 1hr session
                                               else if(time!=rs12.getInt("start_time")&lesson_type.equalsIgnoreCase("Practical")&!rs12.getString("lesson_type").equalsIgnoreCase("Practical")&time<17)
                                             { 
                                             //check whether there is a vacant room during this time (of 3 hours)
                                              String vacancy="select course_code from timetable where room_no="+rs3.getInt("room_no")+" and block_no='"+rs3.getString("block_no")+"' "
                                             + "and start_time="+time+" or start_time="+(time+1)+" or start_time="+(time+2)+" and ac_year='"+ac_year+"' and semester='"+semester+"';";                                
                                               ResultSet rs9=statement9.executeQuery(vacancy);                                    
                                               if(!rs9.next())
                                               {
                                               if(day.equalsIgnoreCase("Monday")){out.println("<tr bgcolor=\"yellow\"> <td bgcolor=\"yellow\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Tuesday")){out.println("<tr bgcolor=\"abcdef\"> <td bgcolor=\"abcdef\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Wednesday")){out.println("<tr bgcolor=\"ea9020\"> <td bgcolor=\"ea9020\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Thursday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                               else if(day.equalsIgnoreCase("Friday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                                else if(day.equalsIgnoreCase("Saturday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                                  else if(day.equalsIgnoreCase("Sunday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                              
                                                if(time<7)
                                              {
                                               out.println("<td>0"+time+"00</td>");
                                               out.println("<td>0"+(time+3)+"00</td>");
                                              }
                                              else if(time>=7&&time<10)
                                              {
                                              out.println("<td>0"+time+"00</td>");
                                              out.println("<td>"+(time+3)+"00</td>");
                                              }
                                             else {
                                              out.println("<td>"+time+"00</td>");
                                              out.println("<td>"+(time+3)+"00</td>");
                                                }
                                              out.println("<td>"+rs3.getInt("room_no")+"</td>");
                                              out.println("<td>"+rs3.getString("room_name")+"</td>");
                                              out.println("<td>"+rs3.getString("block_no")+"</td>");  
                                              out.println("<FORM METHOD=\"POST\" ACTION=\"https://www.saut-timas.co.tz/insert_course_into_timetable.jsp?course_code="+course_code+"&semester="+semester+"&ac_year="+ac_year+""
                                              + "&start_time="+time+"&end_time="+(time+3)+"&lesson_type="+lesson_type+"&room_no="+rs3.getInt("room_no")+"&block_no="+rs3.getString("block_no")+"&day="+day+"\">");
                                              out.println("<td style=\"background-color:green\"><INPUT TYPE=\"SUBMIT\" VALUE=\"Choose\"></td>");
                                              out.println("</tr>"); 
                                              out.println("</FORM>");
                                               }
                                              }
                                            } 
                                          }
                                        }
                                      } 
                                   }   
                                }
                              }
                                 %></tbody></table><%
                                 String delete_temp_table="drop table enemy_courses;";
                                 statement14.executeUpdate(delete_temp_table);
                            }
                           else
                         {
                           //RS8 IS EMPTY i.e this is the first course to be located in the timetable in this semester
                                   
                          %>  <table border="1" cellpadding="0" cellspacing="0"  class="dataTable" id="example"><thead><%
                            out.println("<tr bgcolor=\"matembele\">");
                            out.println("<th>DAY</th>");
                            out.println("<th>START TIME</th>");
                            out.println("<th>END TIME</th>");
                            out.println("<th>ROOM NO</th>");
                            out.println("<th>ROOM NAME</th>");
                            out.println("<th>BLOCK NO</th>");  
                            out.println("<th>OPTION</th>");
                            out.println("</tr>");
                          %></thead><tbody><%
                           rs3.beforeFirst();
                            while(rs3.next()){ 
                            for(int days=1;days<=5;days++){
                                       if(days==1){day="Monday";}
                                        else if(days==2){ day="Tuesday";}
                                        else if(days==3){ day="Wednesday";}
                                        else if(days==4){ day="Thursday";}
                                        else if(days==5){ day="Friday";}
                                        else if(days==6){ day="Saturday";}
                                        else if(days==6){ day="Sunday";}
                                        //A course can not have two sessions within a day
                                      String duplicate="select course_code from timetable where course_code='"+course_code+"' and ac_year='"+ac_year+"' and semester='"+semester+"' and day='"+day+"';";
                                      ResultSet rs10=statement10.executeQuery(duplicate);
                                      if(!rs10.next()){                                      
                                for(int time=7;time<19;time++){       
                                if(lesson_type.equals("Lecture")||lesson_type.equals("Tutorial")||lesson_type.equals("Seminar"))
                                   {                               
                                     if(day.equalsIgnoreCase("Monday")){out.println("<tr background-color=\"\"> <td style=\"background-color:\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Tuesday")){out.println("<tr bgcolor=\"abcdef\"> <td bgcolor=\"abcdef\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Wednesday")){out.println("<tr bgcolor=\"ea9020\"> <td bgcolor=\"ea9020\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Thursday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Friday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}                   
                                     else if(day.equalsIgnoreCase("Saturday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}                   
                                     else if(day.equalsIgnoreCase("Sunday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}                   
                                      if(time<9){ 
                                     out.println("<td>0"+time+"00</td>");
                                     out.println("<td>0"+(time+1)+"00</td>");
                                     }
                                    else if(time==9){
                                     out.println("<td>0"+time+"00</td>");
                                     out.println("<td>"+(time+1)+"00</td>");
                                      }
                                    else {
                                     out.println("<td>"+time+"00</td>");
                                     out.println("<td>"+(time+1)+"00</td>");
                                     }
                                     out.println("<td>"+rs3.getInt("room_no")+"</td>");
                                     out.println("<td>"+rs3.getString("room_name")+"</td>");
                                     out.println("<td>"+rs3.getString("block_no")+"</td>");
                                     out.println("<FORM METHOD=\"POST\" ACTION=\"https://www.saut-timas.co.tz/insert_course_into_timetable.jsp?course_code="+course_code+"&semester="+semester+"&ac_year="+ac_year+""
                                     +"&start_time="+time+"&end_time="+(time+1)+"&lesson_type="+lesson_type+"&room_no="+rs3.getInt("room_no")+"&block_no="+rs3.getString("block_no")+"&day="+day+"\"> ");
                                     out.println("<td bgcolor=\"green\"><INPUT TYPE=\"SUBMIT\" VALUE=\"Choose\"></td>");
                                     out.println("</tr>"); 
                                     out.println("</FORM>");  
                                    }           
                                    else if(lesson_type.equals("Practical")&time<17)
                                    { 
                                     if(day.equalsIgnoreCase("Monday")){out.println("<tr bgcolor=\"yellow\"> <td bgcolor=\"yellow\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Tuesday")){out.println("<tr bgcolor=\"abcdef\"> <td bgcolor=\"abcdef\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Wednesday")){out.println("<tr bgcolor=\"ea9020\"> <td bgcolor=\"ea9020\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Thursday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Friday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Saturday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Sunday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                     
                                      if(time<7)
                                     {
                                     out.println("<td>0"+time+"00</td>");
                                     out.println("<td>0"+(time+3)+"00</td>");
                                     }
                                     else if(time>=7&&time<10)
                                        {
                                     out.println("<td>0"+time+"00</td>");
                                     out.println("<td>"+(time+3)+"00</td>");
                                        }
                                     else {
                                     out.println("<td>"+time+"00</td>");
                                     out.println("<td>"+(time+3)+"00</td>");
                                        }
                                     out.println("<td>"+rs3.getInt("room_no")+"</td>");
                                     out.println("<td>"+rs3.getString("room_name")+"</td>");
                                     out.println("<td>"+rs3.getString("block_no")+"</td>");  
                                     out.println("<FORM METHOD=\"POST\" ACTION=\"https://www.saut-timas.co.tz/insert_course_into_timetable.jsp?course_code="+course_code+"&semester="+semester+"&ac_year="+ac_year+""
                                   + "&start_time="+time+"&end_time="+(time+3)+"&lesson_type="+lesson_type+"&room_no="+rs3.getInt("room_no")+"&block_no="+rs3.getString("block_no")+"&day="+day+"\">");
                                     out.println("<td bgcolor=\"green\"><INPUT TYPE=\"SUBMIT\" VALUE=\"Choose\"></td>");
                                     out.println("</tr>"); 
                                     out.println("</FORM>");
                                   }
                                 }
                               }
                             rs10.close();                            
                            }    
                          }
                          %></tbody></table><%    
                       }
                      rs8.close();
                       }      
                      }
                       //The course has no collision
                       else{  
                            out.println("<h2 align=\"center\">TIMETABLE ARRANGEMENT FOR SEMESTER "+semester.toUpperCase()+" -ACADEMIC YEAR "+ac_year+"</h2>");
                             
                            out.println("<h3 align=\"center\"><br>Available spaces from which the course "+course_code+""
                                    + " can be placed in the timetable without collision.<br>To select the option, Click 'Choose' in the OPTION column</h3>");
                            out.println("<hr>");
 %>  <table border="1" cellpadding="0" cellspacing="0"  class="dataTable" id="example"><thead><%
                            out.println("<tr bgcolor=\"matembele\">");
                            out.println("<th>DAY</th>");
                            out.println("<th>START TIME</th>");
                            out.println("<th>END TIME</th>");
                            out.println("<th>ROOM NO</th>");
                            out.println("<th>ROOM NAME</th>");
                            out.println("<th>BLOCK NO</th>");  
                            out.println("<th>OPTION</th>");
                            out.println("</tr>"); 
%></thead><tbody><%
                            rs3.beforeFirst();
                            while(rs3.next()){ 
                            for(int days=1;days<=5;days++){
                                       if(days==1){day="Monday";}
                                        else if(days==2){ day="Tuesday";}
                                        else if(days==3){ day="Wednesday";}
                                        else if(days==4){ day="Thursday";}
                                        else if(days==5){ day="Friday";}
                                        //A course cannot have two sessions within a day
                                        String duplicate="select course_code from timetable where course_code='"+course_code+"' and ac_year='"+ac_year+"' and semester='"+semester+"' and day='"+day+"';";
                                        ResultSet rs10=statement10.executeQuery(duplicate);
                                        if(!rs10.next()){                                      
                                        for(int time=7;time<19;time++){       
                                        if(lesson_type.equals("Lecture")||lesson_type.equals("Tutorial")||lesson_type.equals("Seminar"))
                                      {                               
                                     if(day.equalsIgnoreCase("Monday")){
                                         out.println("<tr style=\"background-color:wheat\"> <td style=\"color:\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Tuesday")){out.println("<tr bgcolor=\"abcdef\"> <td bgcolor=\"abcdef\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Wednesday")){out.println("<tr bgcolor=\"ea9020\"> <td bgcolor=\"ea9020\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Thursday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Friday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Saturday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Sunday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}

                                      if(time<9){ 
                                     out.println("<td>0"+time+"00</td>");
                                     out.println("<td>0"+(time+1)+"00</td>");
                                     }
                                    else if(time==9){
                                     out.println("<td>0"+time+"00</td>");
                                     out.println("<td>"+(time+1)+"00</td>");
                                      }
                                    else {
                                     out.println("<td>"+time+"00</td>");
                                     out.println("<td>"+(time+1)+"00</td>");
                                     }
                                     out.println("<td>"+rs3.getInt("room_no")+"</td>");
                                     out.println("<td>"+rs3.getString("room_name")+"</td>");
                                     out.println("<td>"+rs3.getString("block_no")+"</td>");
                                     out.println("<FORM METHOD=\"POST\" ACTION=\"https://www.saut-timas.co.tz/insert_course_into_timetable.jsp?course_code="+course_code+"&semester="+semester+"&ac_year="+ac_year+""
                                     +"&start_time="+time+"&end_time="+(time+1)+"&lesson_type="+lesson_type+"&room_no="+rs3.getInt("room_no")+"&block_no="+rs3.getString("block_no")+"&day="+day+"\"> ");
                                     out.println("<td bgcolor=\"green\"><INPUT TYPE=\"SUBMIT\" VALUE=\"Choose\"></td>");
                                     out.println("</tr>"); 
                                     out.println("</FORM>");  
                                    }           
                                    else if(lesson_type.equals("Practical")&time<17)
                                    { 
                                     if(day.equalsIgnoreCase("Monday")){out.println("<tr bgcolor=\"yellow\"> <td bgcolor=\"\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Tuesday")){out.println("<tr bgcolor=\"abcdef\"> <td bgcolor=\"abcdef\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Wednesday")){out.println("<tr bgcolor=\"ea9020\"> <td bgcolor=\"ea9020\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Thursday")){out.println("<tr bgcolor=\"loveness\"> <td bgcolor=\"loveness\">"+day+"</td>");}
                                     else if(day.equalsIgnoreCase("Friday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                      else if(day.equalsIgnoreCase("Saturday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}
                                        else if(day.equalsIgnoreCase("Sunday")){out.println("<tr bgcolor=\"stanford\"> <td bgcolor=\"stanford\">"+day+"</td>");}

                                      if(time<7)
                                     {
                                     out.println("<td>0"+time+"00</td>");
                                     out.println("<td>0"+(time+3)+"00</td>");
                                     }
                                     else if(time>=7&&time<10)
                                        {
                                     out.println("<td>0"+time+"00</td>");
                                     out.println("<td>"+(time+3)+"00</td>");
                                        }
                                     else {
                                     out.println("<td>"+time+"00</td>");
                                     out.println("<td>"+(time+3)+"00</td>");
                                        }
                                     out.println("<td>"+rs3.getInt("room_no")+"</td>");
                                     out.println("<td>"+rs3.getString("room_name")+"</td>");
                                     out.println("<td>"+rs3.getString("block_no")+"</td>");  
                                     out.println("<FORM METHOD=\"POST\" ACTION=\"https://www.saut-timas.co.tz/insert_course_into_timetable.jsp?course_code="+course_code+"&semester="+semester+"&ac_year="+ac_year+""
                                   + "&start_time="+time+"&end_time="+(time+3)+"&lesson_type="+lesson_type+"&room_no="+rs3.getInt("room_no")+"&block_no="+rs3.getString("block_no")+"&day="+day+"\">");
                                     out.println("<td bgcolor=\"green\"><INPUT TYPE=\"SUBMIT\" VALUE=\"Choose\"></td>");
                                     out.println("</tr>"); 
                                     out.println("</FORM>");
                                    }
                                  }
                               }
                              rs10.close();                                 
                            }    
                          }
                       %>
     </tbody></table>                   
         <%
                        rs3.close();  
                       }
                   }//closes else of if(!rs6.next())   
              }//closes else of if(!rs4.next())
           }          
        }//closes  else of if(rs1.next()) 

 if(statement1!=null){
   statement1.close();
}
if(statement2!=null){
   statement2.close();
   }
 if(statement3!=null){
   statement3.close();
}
if(statement4!=null){
   statement4.close();
   }
 if(statement5!=null){
   statement5.close();
}
if(statement6!=null){
   statement6.close();
   }
 if(statement7!=null){
   statement7.close();
}
if(statement8!=null){
   statement8.close();
   }
 if(statement9!=null){
   statement9.close();
}
if(statement10!=null){
   statement10.close();
   }
 if(statement11!=null){
   statement11.close();
}
if(statement12!=null){
   statement12.close();
   }
 if(statement13!=null){
   statement13.close();
}
if(statement14!=null){
   statement14.close();
   }

 if(connection!=null){
   connection.close();
   }
      }
         catch(ClassNotFoundException classe) {            
            out.println("<br>Class not found! : <br>  "+classe.getMessage());
         }
        catch(NumberFormatException nf)
         {
         out.println("<br>Invalid format "+nf.getMessage());  
         }
        catch(NullPointerException npe){
        out.println("There is a Null Pointer Exception :"+npe.getMessage());
         }
        catch(SQLException e){
            %><hr><%=e%><%
         }
           out.println("<button onclick=\"window.print();\">Print This Page?</button>");  
       %>
</body></html>

ffffffff
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TIMAS | Computing Timetable</title>
    <link rel="stylesheet" type="text/css" href="https://saut-timas.co.tz/css/dataTables.css">
    <link rel="stylesheet" type="text/css" href="https://saut-timas.co.tz/css/themeroller.css">
    <script type="text/javascript" src="https://saut-timas.co.tz/js/min.js"></script>
    <script type="text/javascript" src="https://saut-timas.co.tz/js/dataTables_min.js"></script>
    <script>
        $(document).ready(function() {
            $('#example').dataTable({"sPaginationType": "full_numbers"});
        });
    </script>
</head>
<body>
<%
    Connection connection = null;
    PreparedStatement ps1 = null, ps2 = null, ps3 = null;
    ResultSet rs1 = null, rs2 = null, rs3 = null;
    
    try {
        HttpSession session = request.getSession(false);
        String courseCode = (String) session.getAttribute("course_code");
        String acYear = (String) session.getAttribute("ac_year");
        String semester = (String) session.getAttribute("semester");
        String lessonType = (String) session.getAttribute("lesson_type");
        
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas", "Jokama@78");

        // Check if there are students registered for the course
        String query1 = "SELECT COUNT(*) AS total_students FROM student_course WHERE course_code=? AND ac_year=? AND semester=?";
        ps1 = connection.prepareStatement(query1);
        ps1.setString(1, courseCode);
        ps1.setString(2, acYear);
        ps1.setString(3, semester);
        rs1 = ps1.executeQuery();
        
        if (rs1.next() && rs1.getInt("total_students") > 0) {
            int totalStudents = rs1.getInt("total_students");

            // Check if the course has a lecturer assigned
            String query2 = "SELECT staff_id FROM tmatrix WHERE course_code=? AND ac_year=? AND semester=?";
            ps2 = connection.prepareStatement(query2);
            ps2.setString(1, courseCode);
            ps2.setString(2, acYear);
            ps2.setString(3, semester);
            rs2 = ps2.executeQuery();
            
            if (rs2.next()) {
                String staffId = rs2.getString("staff_id");

                // Find rooms that can accommodate the students
                String query3 = "SELECT room_no, room_name, block_no, capacity FROM room WHERE purpose LIKE '%teaching%' AND (? / capacity) >= 0.9 AND (? / capacity) <= 1";
                ps3 = connection.prepareStatement(query3);
                ps3.setInt(1, totalStudents);
                ps3.setInt(2, totalStudents);
                rs3 = ps3.executeQuery();

                // Generate timetable options
                if (rs3.next()) {
                    // Display available options in a table
                } else {
                    out.println("No suitable room available. Please try again later or contact the system administrator.");
                }
            } else {
                out.println("No lecturer assigned to this course for the current semester.");
            }
        } else {
            out.println("No students registered for this course.");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs1 != null) rs1.close();
        if (rs2 != null) rs2.close();
        if (rs3 != null) rs3.close();
        if (ps1 != null) ps1.close();
        if (ps2 != null) ps2.close();
        if (ps3 != null) ps3.close();
        if (connection != null) connection.close();
    }
%>
    <button onclick="window.print();">Print This Page?</button>
</body>
</html>
