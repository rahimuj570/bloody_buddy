<%@page import="dao.InterestDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="entities.DonorRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.DonorRequestDao"%>
<%@page import="entities.Donor"%>
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
		<p
			style="text-align: center; font-size: 30px; font-weight: bold; margin: 30px; color: red;">People's
			Interest of Your Requests</p>
		<%
		if (session.getAttribute("interest_OK") != null) {
		%><p style="color: green; margin: 20px; text-align: center;"><%=session.getAttribute("interest_OK")%></p>
		<%
		}
		session.removeAttribute("interest_OK");
		%>
		<%
		String p = request.getParameter("p");
		if (p == null)
			p = "0";
		int pNum = Integer.parseInt(p);
		ArrayList<DonorRequest> reqList = intDao.getInterestForNotification(pNum, current_user.getDonor_id());
		ArrayList<DonorRequest> unseenReqList = intDao.getUnseenInterestForNotification(pNum, current_user.getDonor_id());
		if (unseenReqList != null && !unseenReqList.isEmpty()) {
			for (DonorRequest dReq : unseenReqList) {
		%>

		<section style="background: gainsboro" class="news_card">
			<div style="display: flex; align-items: center">
				<img width="100" src="img/blood/<%=dReq.getBlood_group()%>.png"
					alt="" />
				<div class="card_details">
					<p>
						Patient Name:
						<%=dReq.getPatient_name()%></p>
					<p>
						Need:
						<%=dReq.getBlood_unit()%>
						<%=dReq.getBlood_unit() < 2 ? "Unit" : "Units"%></p>
					<p>
						Location:
						<%=dReq.getLocation()%></p>
					<p>
						Need For:
						<%=dReq.getWhy_need()%></p>

					<%
					String pattern = "dd MMMM, yyyy";
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
					String date = simpleDateFormat.format(dReq.getWhen_need());
					String pattern2 = "hh:mm a";
					SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);
					String time = simpleDateFormat2.format(dReq.getWhen_need());
					%>

					<p>
						Date:
						<%=date%></p>
					<p>
						Time:
						<%=time%></p>
					<p>
						Mobile:
						<%=dReq.getMobile()%></p>
				</div>
			</div>
			<div class="news_action_btn">
				<a id="call_btn" href="tel:<%=dReq.getMobile()%>">Call</a> <a
					id="msg_btn"
					href="CreateChatRoomServlet?receiver=<%=dReq.getCreated_by()%>">Message</a>
			</div>
		</section>
		<%
		}
		%>
		<button id="refresh" onclick="location.reload()">See All
			Notifications</button>
		<%
		}
		if (reqList != null && unseenReqList.isEmpty()) {
		for (DonorRequest dReq : reqList) {
		%>

		<section class="news_card">
			<div style="display: flex; align-items: center">
				<img width="100" src="img/blood/<%=dReq.getBlood_group()%>.png"
					alt="" />
				<div class="card_details">
					<p>
						Patient Name:
						<%=dReq.getPatient_name()%></p>
					<p>
						Need:
						<%=dReq.getBlood_unit()%>
						<%=dReq.getBlood_unit() < 2 ? "Unit" : "Units"%></p>
					<p>
						Location:
						<%=dReq.getLocation()%></p>
					<p>
						Need For:
						<%=dReq.getWhy_need()%></p>

					<%
					String pattern = "dd MMMM, yyyy";
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
					String date = simpleDateFormat.format(dReq.getWhen_need());
					String pattern2 = "hh:mm a";
					SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);
					String time = simpleDateFormat2.format(dReq.getWhen_need());
					%>

					<p>
						Date:
						<%=date%></p>
					<p>
						Time:
						<%=time%></p>
					<p>
						Mobile:
						<%=dReq.getMobile()%></p>
				</div>
			</div>
			<div class="news_action_btn">
				<a id="call_btn" href="tel:<%=dReq.getMobile()%>">Call</a> <a
					id="msg_btn"
					href="CreateChatRoomServlet?receiver=<%=dReq.getCreated_by()%>">Message</a>
			</div>
		</section>
		<%
		}
		%>

		<div class="page_par">
			<%
			if (p == null || p.equals("0")) {
			%>
			<button id="prev_btn" disabled="disabled" style="background: gray">Previous</button>
			<%
			} else {
			%>
			<a id="prev_btn" href="?p=<%=pNum - 1%>">Previous</a>
			<%
			}
			if (reqList.size() < 5) {
			%>
			<button id="prev_btn" disabled="disabled" style="background: gray">Next</button>
			<%
			} else {
			%>
			<a id="next_btn" href="?p=<%=pNum + 1%>">Next</a>
			<%
			}
			%>
		</div>

		<%
		} else if (reqList.isEmpty() && unseenReqList.isEmpty()) {
		%>
		<section class="news_card">
			<div style="display: flex; align-items: center">NO NOTIFICATON!</div>
		</section>
		<%
		}
		%>
	</section>

	<footer style="text-align: center">
		<p>S.A.D PROJECT &copy;2024</p>
	</footer>

	<style type="text/css">
#refresh {
	background: antiquewhite;
	padding: 10px;
	border: 0;
	cursor: pointer;
	width: 100%;
	font-size: 15px;
	font-weight: bold;
	transition: .3s linear
}

#refresh:hover {
	background: #f9cccc;
}
</style>
	<script type="text/javascript">
	fetch('SeenAllInterestServlet').then(res=>res.text()).then(data=>console.log("seen"));
	</script>
</body>
</html>