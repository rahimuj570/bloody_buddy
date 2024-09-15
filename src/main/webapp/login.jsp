<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>
    <link rel="stylesheet" href="style.css" type="text/css" />
  </head>
  <body>
    <section class="login_par">
      <a href="<%=request.getContextPath()%>"><img width="100" src="logo.png" alt="" /></a>
      <%if(session.getAttribute("registration_OK")!=null){ %><p style="color:green"><%=session.getAttribute("registration_OK") %></p><%}
      session.removeAttribute("registration_OK");
      %>
      <%if(session.getAttribute("login_BAD")!=null){ %><p style="color:red"><%=session.getAttribute("login_BAD") %></p><%}
      session.removeAttribute("login_BAD");
      %>
      <form class="login_inputs" method="post" action="LoginServlet">
        <input placeholder="Your Email" type="email" name="email" id="email" />
        <div class="password_input">
          <input
            placeholder="Your Password"
            type="password"
            name="password"
            id="password"
          />
          <img
            onclick="tgl()"
            id="eye_icon"
            width="25"
            src="/img/icon/eye.png"
            alt=""
          />
        </div>
        <button id="login_btn">Login</button>
      </form>

      <a href="<%=request.getContextPath() %>/register.jsp">Don't have an account?</a>
    </section>

    <script>
      const eye_icon = document.getElementById("eye_icon");
      const password_input = document.getElementById("password");
      let tgl = () => {
        if (password_input.type == "text") password_input.type = "password";
        else password_input.type = "text";
      };
    </script>
  </body>
</html>
