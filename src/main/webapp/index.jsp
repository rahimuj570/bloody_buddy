<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bloody Buddy</title>
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
  <%if(session.getAttribute("current_user")==null)response.sendRedirect(request.getContextPath()+"/login.jsp"); %>
    <section class="menu_sec">
      <div class="logo_menu">
        <div style="width: 50px">
          <img style="width: 100%" src="logo.png" alt="" />
        </div>
        <ul class="menu_par">
          <li><a href="">Home</a></li>
          <li><a href="/profile.html">Profile</a></li>
          <li><a href="/message.html">Message(10)</a></li>
          <li><a href="">Notification(10)</a></li>
          <li><a href="">Buddies(10)</a></li>
          <li><a href="/create_request.html">Create Request</a></li>
          <li><a href="LogoutServlet">Logout</a></li>
        </ul>
      </div>
      <div class="search_par">
        <input placeholder="Search Here ..." id="search_bar" type="text" />
        <a id="search_btn" href="">
          <img width="35" src="search.png" alt="" />
        </a>
      </div>
    </section>

    <!-- NEWS FEED -->
    <section class="news_par">
      <section class="news_card">
        <div style="display: flex; align-items: center">
          <img width="100" src="img/blood/a_neg.png" alt="" />
          <div class="card_details">
            <p>Patient Name: xvb</p>
            <p>Need: 6 Units</p>
            <p>Location: ABC</p>
            <p>Hospital: GHJKL</p>
            <p>Timing: Urgent</p>
          </div>
        </div>
        <div class="news_action_btn">
          <a id="donate_btn" href="">Donate</a>
          <a id="call_btn" href="">Call</a>
          <a id="msg_btn" href="">Message</a>
        </div>
      </section>

      <section class="news_card">
        <div style="display: flex; align-items: center">
          <img width="100" src="img/blood/a_neg.png" alt="" />
          <div class="card_details">
            <p>Patient Name: XYZ</p>
            <p>Need: 6 Units</p>
            <p>Location: ABC</p>
            <p>Hospital: GHJKL</p>
            <p>Timing: Urgent</p>
          </div>
        </div>
        <div class="news_action_btn">
          <a id="donate_btn" href="">Donate</a>
          <a id="call_btn" href="">Call</a>
          <a id="msg_btn" href="">Message</a>
        </div>
      </section>

      <div class="page_par">
        <a id="prev_btn" href="">Previous</a>
        <a id="next_btn" href="">Next</a>
      </div>
    </section>

    <footer style="text-align: center">
      <p>S.A.D PROJECT &copy;2024</p>
    </footer>
  </body>
</html>
