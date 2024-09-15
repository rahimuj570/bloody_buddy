<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register</title>
    <link rel="stylesheet" href="style.css" type="text/css" />
  </head>
  <body>
    <section class="login_par">
      <a href="<%=request.getContextPath()%>"><img width="100" src="img/icon/register.png" alt="" /></a>
      <h1>Create an Account</h1>
      <%if(session.getAttribute("registration_BAD")!=null){ %><p style="color:red"><%=session.getAttribute("registration_BAD") %></p><%}
      session.removeAttribute("registration_BAD");
      %>
      <form class="login_inputs" action="RegisterServlet" method="post">
        <input required placeholder="Your Name" type="text" name="name" id="name" />
        <input required placeholder="Your Email" type="email" name="email" id="email" />
        <input required placeholder="Your Mobile" type="tel" name="mobile" id="mobile" />
        <div class="password_input">
          <input required
            placeholder="Your Password"
            type="password"
            name="password"
            id="password"
          />
          <img
            onclick="tgl()"
            id="eye_icon"
            width="25"
            src="img/icon/eye.png"
            alt=""
          />
        </div>
        <label for="group">Blood Group</label>
        <select name="group" id="group">
          <option value="a_pos">A+</option>
          <option value="a_neg">A-</option>
          <option value="b_pos">B+</option>
          <option value="b_neg">B-</option>
          <option value="ab_pos">AB+</option>
          <option value="ab_neg">AB-</option>
        </select>
        <button id="login_btn">Register</button>
      </form>

      <a href="<%=request.getContextPath()%>/login.jsp">Already have an account?</a>
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
