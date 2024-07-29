<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    
<title>MJED | Home</title>
</head>
<body>

    <div class="header" style="background-color: #92a69b">
      
      <!-- A.1 HEADER TOP -->
      <div class="header-top">
        <div class="round-border-topleft"></div><div class="round-border-topright"></div>      
        
        <!-- Sitelogo and sitename -->
        <!-- <a class="sitelogo" href="#" title="Home"></a>-->
        <div class="sitename">
            <table><tr><td style=" float: left"><a href="http://www.saut.ac.tz"><img title="St. Augustine University of Tanzania" src="img/saut logo.png" alt="muce logo" width="90" height="90"></a></td><td style="width: 920px"> <h1 href="#" title="MJED" style="color: brown;text-align:center; font-size:  30px">St. Augustine University Of Tanzania</h1>
                        <h2 style="text-align: center; font-family: cursive;color: #076f65; font-weight:  bolder;  font-size:  20px; ">Time-Table Management System (TIMAS)</h2>
                        <%
                          try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection=DriverManager.getConnection("jdbc:mysql://www.saut-timas.co.tz:3306/makubogm_timas", "makubogm_timas","Jokama@78");connection.createStatement().executeUpdate("set time_zone='+3:00';");         
        Statement statement=connection.createStatement();
        ResultSet rs=statement.executeQuery("select ac_year,semester from semesterisation where date(now()) between start_date and end_date ");
        if(rs.next()){
                        %>
                        <br><h2 style="text-align: center; font-family: fantasy; "><a style="color: blue" title="Click To Read Details of this Academic Year" href="#">Current Academic Year : <b style="color: #076f65;"><%=rs.getString("ac_year")%> Semester <%=rs.getInt("semester")%> </b></a></h2> 
                        <%rs.close();} else{
            %><br><h2 style="text-align: center; font-family: fantasy; "><a style="color: blue" title="Academic Year Not Available" href="#">Current Academic Year : <b style="color: red;"> Not Set</b></a></h2><%
        }}catch(Exception e){
            %><b style="color:red; text-align: center"><img src="img/error.png" height="20" width="25" alt="Warning!"> <em> Database Server Not Recheable</em>. Please inform the TIMAS administrator</b> <%=e%><% 
                        }%>
                    </td> <td style="text-align: right"><a href="http://www.saut.ac.tz" title="St. Augustine University of Tanzania"><img src="img/udsm.jpg" height="90" width="80"  alt="SAUT" /></a></td> </tr></table>
           
        </div>
    
        <!-- Navigation Level 0 
        <div class="nav0">
          <ul>
            <li><a href="#" title="SAUT"><img src="https://www.saut-timas.co.tz/img/udsm.jpg" alt="SAUT" /></a></li>
            <li><a href="#" title="Tanzania"><img src="./img/tz.png" alt="TZ" /></a></li>
          </ul>
        </div>	-->		

        <!-- Navigation Level 1
        <div class="nav1">
          <ul>
            <li><a href="#" title="Frequent Asked Questions">FAQ</a></li>
            <li><a href="#" title="Contact us">Contact</a></li>								
           								            
          </ul>
        </div>    -->           
      </div>
              <%
                
  HttpSession s=request.getSession(false);
  String id=(String)s.getAttribute("id");
   String fname=(String)s.getAttribute("fname");
    String mname=(String)s.getAttribute("mname");
     String lname=(String)s.getAttribute("lname");
      String title=(String)s.getAttribute("title");
      String type=(String)s.getAttribute("type"); 
          try{ 
        %>   
      <!-- A.3 HEADER BOTTOM -->
      <div class="header-bottom">
      
        <!-- Navigation Level 2 (Drop-down menus) -->
        <div class="nav2">
	
          <!-- Navigation item -->
          <ul>
            <li><a  href="https://www.saut-timas.co.tz/">Home</a></li>
          </ul>
          
          <!-- Navigation item -->
          <ul>
            <li><a href="#">About TIMAS<!--[if IE 7]><!--></a><!--<![endif]-->
              <!--[if lte IE 6]><table><tr><td><![endif]-->
                <ul>
                  <li><a href="#">Aims and Objectives</a></li>
                  <li><a href="#">User Manual</a></li>
               </ul>
              <!--[if lte IE 6]></td></tr></table></a><![endif]-->
            </li>
          </ul>
          <%if(id!=null&&(id.contains("@")&&type.equalsIgnoreCase("Administrator"))){%>
            <ul>
         
            <li><a href="#">Manage Users<!--[if IE 7]><!--></a><!--<![endif]-->
              <!--[if lte IE 6]><table><tr><td><![endif]-->
                <ul>
                  <li><a href="authorise.jsp">Authorize Registration</a></li>
                  <li><a href="manage_user.jsp">Block | Unblock</a></li>
                  <li><a href="assign_privilege.jsp">Assign Privilege</a></li>   
               </ul>
              
          </ul> 
          <ul>
         
            <li><a href="#">Register<!--[if IE 7]><!--></a><!--<![endif]-->
              <!--[if lte IE 6]><table><tr><td><![endif]-->
                <ul>
                  <li><a href="#">New Ac. Year</a></li>
                  <li><a href="#">New Venue</a></li>
                  <li><a href="#"></a></li>   
               </ul>
              
          </ul>
          
          <%}%>
        </div>
	  </div>

      <!-- A.4 HEADER BREADCRUMBS -->

      <!-- Breadcrumbs -->
      <div class="header-breadcrumbs">
        <ul>
            <li><a style="color:black" title="St. Augustine University of Tanzania" href="http://www.saut.ac.tz/">SAUT</a></li>
          <li><a style="color:black" title="Timetable Management System " href="#">TIMAS</a></li>        
        </ul>

        <!-- Search form -->    
        <%if(id==null){%>
        <div class="searchform">
          <form action="#" method="get">
            <fieldset>
                <input type="text" placeholder="Search" name="field" class="field" />
              <input type="submit" name="button" class="button" value="GO!" />
            </fieldset>
          </form>
        </div><%}if(id!=null){%>
        
        <div class="nav" style="text-align: right; background-color:  #ffdddd">  <jsp:include page="greetings.jsp"/> <a class="greet" href="#"><%if(title!=null){%> <%=title%> <%=lname%> <%} else{%><%=fname%> <%}%></a>
        
        </div><%}%><%--
        <div id="google_translate_element"></div><script type="text/javascript">
function googleTranslateElementInit() {
  new google.translate.TranslateElement({pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
}
</script>
<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
        
</div>--%>
      
    </div><%}catch(Exception e){
        
      %>
   There is a technical error
    <%
    }%>
</body> </html>