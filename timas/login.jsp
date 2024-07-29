<%-- 
    Document   : index
    Created on : Nov 9, 2015, 7:53:38 PM
    Author     : M M TECHNOLOGIES
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <meta http-equiv="cache-control" content="no-cache">
      <meta http-equiv="expires" content="3600">
      <meta name="revisit-after" content="2 days">
      <meta name="robots" content="index,follow">
      <meta name="publisher" content="Your publisher info here ...">
      <meta name="copyright" content="Your copyright info here ...">
      <meta name="author" content="Design: 1234.info / Modified: Your Name">
      <meta name="distribution" content="global">
      <meta name="description" content="Your page description here ...">
      <meta name="keywords" content="Your keywords, keywords, keywords, here ...">
      <link rel="stylesheet" href="./css/mf42_layout2_setup.css">
      <link rel="stylesheet" href="./css/mf42_layout2_text.css">
      <link rel="icon" href="./img/favicon.ico">
      <title>TIMAS | Login</title>
      <style>
          body {
              background-color: #c2947d;
          }
          .login-container {
              text-align: center;
          }
          .login-form {
              display: inline-block;
              width: 650px;
              background-color: #fff;
              border: 2px solid #0361A8;
              border-radius: 5px;
              box-shadow: 0px 0px 8px #0361A8;
              margin: 0 auto;
          }
          .login-header {
              background: #8b9699;
              border-radius: 5px 5px 0 0;
              padding: 15px;
          }
          .login-header span {
              font-family: verdana, arial;
              color: white;
              font-size: 14px;
              font-weight: bold;
          }
          .login-body {
              padding: 15px;
              background: #E6E7E9;
          }
          .login-body input {
              font-size: 14px;
          }
          .login-body button {
              margin: 5px;
          }
      </style>
      <script>
          function validateForm() {
              var isValid = true;
              if (document.getElementById('id').value === "") {
                  alert("Please write your student reg# (For Students) or email address (for MUCE Staff)");
                  isValid = false;
              } else if (document.getElementById('password').value === "") {
                  alert("Please type your password");
                  isValid = false;
              }
              return isValid;
          }
      </script>
  </head>
  <body>
      <div class="page-container">
          <!-- A. HEADER -->
          <header>
              <jsp:include page="header.jsp"/>
          </header>
  
          <!-- B. MAIN -->
          <main class="main">
              <!-- B.1 MAIN NAVIGATION -->
              <nav>
                  <jsp:include page="left_nav.jsp"/>
              </nav>
  
              <!-- B.1 MAIN CONTENT -->
              <section class="main-content">
                  <h1 class="pagetitle" style="text-align: center">Login Form</h1>
                  <div class="login-container">
                      <div class="login-form">
                          <div class="login-header">
                              <span>The Username for staff is EMAIL and REG# for students</span>
                          </div>
                          <div class="login-body">
                              <form name="member_registration" action="login_process.jsp" method="post" onsubmit="return validateForm();">
                                  <table style="border: 0;" align="center">
                                      <tr>
                                          <td>Username [email (Staff) or Reg#(students)]</td>
                                          <td>
                                              <input type="text" id="id" name="id" maxlength="20" size="30" required title="Reg# for Students and email for Staff" placeholder="eg. staff@hostname.com or 2000-04-00000">
                                          </td>
                                      </tr>
                                      <tr>
                                          <td>Password</td>
                                          <td>
                                              <input type="password" id="password" name="password" size="30" required placeholder="eg Timas2015">
                                          </td>
                                      </tr>
                                      <tr>
                                          <td></td>
                                          <td style="text-align: center">
                                              <button type="reset">Clear All</button>
                                              <button type="submit">Login</button>
                                              <br><hr><br>
                                              <a href="#">Forgot Your Password?</a>
                                          </td>
                                      </tr>
                                  </table>
                              </form>
                          </div>
                      </div>
                  </div>
              </section>
          </main>
  
          <!-- C. FOOTER AREA -->
          <footer>
              <jsp:include page="footer.jsp"/>
          </footer>
      </div>
  </body>
  </html>
  



