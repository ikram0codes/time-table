<%-- 
    Document   : left_nav
    Created on : Oct 15, 2015, 10:47:09 PM
    Author     : M M TECHNOLOGIES
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Left Nav</title>
        <script>
            function validateMyForm() { 
                var isValid = true;
                if (document.member_registration.comment.value === "") { 
                    alert("Sorry! You cannot submit an empty comment. Please write something in the comments box."); 
                    isValid = false;
                } else if (confirm('Are you sure you want to send this comment? Press OK to Confirm or CANCEL') === false) {
                    isValid = false;
                }
                return isValid;
            } 
        </script>
    </head>
    <body>
        <%
            HttpSession s = request.getSession(false);
            String id = (String)s.getAttribute("id");
            String category = (String)s.getAttribute("category");
            String type = (String)s.getAttribute("type");
        %>
        <!-- B.1 MAIN NAVIGATION -->
        <div class="main-navigation">
            <!-- Navigation Level 3 -->
            <div class="round-border-topright"></div>
            <h1 class="first">MENU</h1>
            <!-- Navigation with grid style -->
            <dl class="nav3-grid">
                <% if (id == null) { %>
                    <dt class="hovermenue"><a title="" href="login.jsp">Login</a></dt>
                    <dt class="hovermenue"><a title="" href="register.jsp">Register</a></dt>
                <% } %>
                <% if (id != null) { %>
                    <% if (!id.contains("@")) { %>
                        <dt class="hovermenue"><a title="View courses that I have registered in TIMAS" href="#">My Registered Courses</a></dt>
                    <% } else { // staff %>
                        <% if (category.equalsIgnoreCase("Academic")) { %>
                            <dt class="hovermenue"><a title="The link will automatically disappear after the deadline" href="timetable_period.jsp">Arrange Timetable</a>&nbsp;&nbsp;&nbsp;&nbsp;[<span style="color:blue">Deadline:</span> <b style="color:red">22/05/2017</b>]</dt>
                        <% } if (type.equalsIgnoreCase("Administrator") || type.equalsIgnoreCase("Dean Faculty")) { %> 
                            <dt class="hovermenue"><a title="Assign who must teach which course(s) in this semester" href="create_tmatrix.jsp">Create Teaching Matrix</a></dt>
                        <% } %>
                        <dt class="hovermenue"><a title="View who teaches which course" href="view_tmatrix.jsp">View Teaching Matrix</a></dt>
                    <% } %>
                    <dt class="hovermenue"><a title="Find a vacant venue at a particular time" href="find_vacant_venue_includer.jsp">Find Vacant Venue</a></dt>
                    <dt class="hovermenue"><a title="Monday, Tuesday,...or Friday Timetable" href="day_timetable.jsp">View Day Timetable</a></dt>
                    <dt class="hovermenue"><a title="First, Second or Third Year Timetable" href="view_yos_timetable.jsp">View Year Timetable</a></dt>
                    <dt class="hovermenue"><a title="View timetable for the courses of your wish" href="my_timetable.jsp">Generate Your Timetable</a></dt>
                    <dt><div class="hovermenue"><a style="color: brown" title="quit" href="logout.jsp">Logout</a></div></dt>
                <% } %>
            </dl>                        
            <!-- Title -->                
            <h1>News and Events</h1> 
            <dl class="nav3-grid">
                <dt><a style="font-size: 12px; font-family: sans-serif; font-weight: inherit" href="#"><img src="https://www.saut-timas.co.tz/img/new2.gif" alt="New">Some changes on timetable seen...<br><span style="color:firebrick; text-align: left">[Date Posted]</span></a></dt>
            </dl>
            <dl>
                <dt><hr class="newsline" /></dt>
            </dl>
            <dl class="nav3-grid">
                <dt><a style="font-size: 12px; font-family: sans-serif; font-weight: inherit" href="#"><img src="https://www.saut-timas.co.tz/img/new2.gif" alt="New">Register yourselves in TIMAS...<br><span style="color: firebrick; text-align: left">[Date Posted]</span></a></dt>
            </dl>
            <h1>Visitors Counter</h1>
            <!-- Counter Code START -->
            <a href="#"><img src="http://www.e-zeeinternet.com/count.php?page=1127925&style=plain_b&nbdigits=5" alt="Free Hit Counter" border="0"></a><br>
            <a href="http://www.e-zeeinternet.com/" title="Free Hit Counter" target="_blank" style="font-family: Geneva, Arial, Helvetica, sans-serif; font-size: 10px; color: #000000; text-decoration: none;">Visitors</a>
            <!-- Counter Code END -->
            <script>
                // Determine if the handset has client-side geo location capabilities
                if (geo_position_js.init()) {
                    geo_position_js.getCurrentPosition(success_callback, error_callback);
                } else {
                    alert("Functionality not available");
                }
            </script>
        </div>
    </body>
</html>
