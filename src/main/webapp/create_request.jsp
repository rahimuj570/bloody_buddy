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
				<li><a href="find_donor.jsp">Find Donor</a></li>
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

	<!-- NEWS FEED -->
	<section class="news_par">
		<div class="create_request_head">
			<h1>Create Request For Blood Donor</h1>
			<p>Must fill in all the input!</p>
		</div>
		<form action="CreateRequestServlet" id="create_request_form"
			method="post">
			<label for="patient_name">Patient Name</label> <br /> <input
				required type="text" name="patient_name" id="patient_name" /> <br />
			<label for="date">When do you need blood?</label> <br /> <input
				required type="datetime-local" name="date" id="date" /> <br /> <label
				for="why">Why do you need blood?</label> <br /> <input required
				type="text" name="why" id="why" /> <br /> <label for="group">What
				blood group do you need?</label> <br /> <select name="group" id="group">
				<option value="a_pos">A+</option>
				<option value="a_neg">A-</option>
				<option value="b_pos">B+</option>
				<option value="b_neg">B-</option>
				<option value="o_pos">o+</option>
				<option value="o_neg">o-</option>
				<option value="ab_pos">AB+</option>
				<option value="ab_neg">AB-</option>
			</select> <br /> <label for="need">How many units are needed?</label> <br />
			<input required type="number" name="need" id="need" /> <br /> <label
				for="mobile">Mobile Number</label> <br /> <input required
				type="number" name="mobile" id="mobile" /> <br /> <label
				for="location">Where is it needed?</label>
			<p style="font-size: 12px">ex: Square Hospitals, Panthapath,
				Dhaka</p>
			<br /> <input required type="text" name="location" id="location" />
			<br />
			<button>Create Request</button>
		</form>
	</section>

	<footer style="text-align: center">
		<p>S.A.D PROJECT &copy;2024</p>
	</footer>
</body>
</html>
