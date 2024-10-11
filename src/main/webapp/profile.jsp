<%@page import="dao.ChatRoomDao"%>
<%@page import="dao.InterestDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="entities.DonorRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.DonorRequestDao"%>
<%@page import="entities.Donor"%>
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
	<%
	if (session.getAttribute("current_user") == null)
		response.sendRedirect(request.getContextPath() + "/login.jsp");
	%>
	<section class="menu_sec">
		<div class="logo_menu">
			<div style="width: 50px">
				<img style="width: 100%" src="logo.png" alt="" />
			</div>
			<ul class="menu_par">
				<%
				InterestDao intDao = new InterestDao(ConnectionProvider.main());
				Donor current_user = (Donor) session.getAttribute("current_user");
				int notification_count = intDao.countUnseenInterest(current_user.getDonor_id());
				int message_count = new ChatRoomDao(ConnectionProvider.main()).getUnseenRoom(current_user.getDonor_id());
				%>
				<li><a href="<%=request.getContextPath()%>">Home</a></li>
				<li><a href="profile.jsp">Profile</a></li>
				<li><a href="message.jsp">Message<%=message_count > 0 ? "(" + message_count + ")" : ""%></a></li>
				<li><a href="notification.jsp">Notification<%=notification_count > 0 ? "(" + notification_count + ")" : ""%></a></li>
				<li><a href="">Buddies(10)</a></li>
				<li><a href="create_request.jsp">Create Request</a></li>
				<li><a href="my_request.jsp">My Request</a></li>
				<li><a href="my_interest.jsp">My Interest</a></li>
				<li><a href="LogoutServlet">Logout</a></li>
			</ul>
		</div>
		<div class="search_par">
			<input placeholder="Search Here ..." id="search_bar" type="text" />
			<a id="search_btn" href=""> <img width="35" src="search.png"
				alt="" />
			</a>
		</div>
	</section>


	<section class="login_par">
		<a href="/"><img width="100" src="img/icon/register.png" alt="" /></a>
		<h2 style="color: red">Profile</h2>
		<form class="login_inputs">
			<input disabled placeholder="Your Name" type="text" name="name"
				id="name" /> <input placeholder="Your Email" type="email"
				name="email" id="email" /> <input placeholder="Your Mobile"
				type="tel" name="mobile" id="mobile" />
			<div class="password_input">
				<input placeholder="Your Password" type="password" name="password"
					id="password" /> <img onclick="tgl()" id="eye_icon"
					width="25" src="/img/icon/eye.png" alt="" />
			</div>
			<label for="group">Blood Group</label> <select disabled name="group"
				id="group">
				<option value="a_pos">A+</option>
				<option value="a_neg">A-</option>
				<option value="b_pos">B+</option>
				<option value="b_neg">B-</option>
				<option value="ab_pos">AB+</option>
				<option value="ab_neg">AB-</option>
			</select>
			<button id="login_btn">Update</button>
		</form>
		<div style="font-size: 20px; font-weight: bold">
			<label for="available">I'm available to donate blood</label> <input
				type="checkbox" name="available" id="available" />
		</div>
	</section>

	<script>
      const eye_icon = document.getElementById("eye_icon");
      const password_input = document.getElementById("password");
      let tgl = () => {
        if (password_input.type == "text") password_input.type = "password";
        else password_input.type = "text";
      };
      
      document.getElementById('name').value='<%=current_user.getDonor_name()%>';
      document.getElementById('email').value='<%=current_user.getDonor_email()%>';
      document.getElementById('mobile').value='<%=current_user.getDonor_mobile()%>';
      document.getElementById('password').value='<%=current_user.getDonor_password()%>';
      document.getElementById('group').value='<%=current_user.getBloodgroup()%>';
    </script>
</body>
</html>
