<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.Donor"%>
<%@page import="entities.DonorRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.DonorRequestDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Requests</title>
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
				<li><a href="">Home</a></li>
				<li><a href="/profile.html">Profile</a></li>
				<li><a href="/message.html">Message(10)</a></li>
				<li><a href="">Notification(10)</a></li>
				<li><a href="">Buddies(10)</a></li>
				<li><a href="create_request.jsp">Create Request</a></li>
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
			style="text-align: center; font-size: 30px; font-weight: bold; margin: 30px; color: red;">MY
			REQUESTS</p>
		<%
		if (session.getAttribute("request_OK") != null) {
		%><p
			style="color: green; margin: 20px; text-align: center;"><%=session.getAttribute("request_OK")%></p>
		<%
		}
		session.removeAttribute("request_OK");
		%>
		<%
		if (session.getAttribute("delete_req_OK") != null) {
		%><p
			style="color: green; margin: 20px; text-align: center;"><%=session.getAttribute("delete_req_OK")%></p>
		<%
		}
		session.removeAttribute("delete_req_OK");
		%>
		<%
		if (session.getAttribute("update_req_OK") != null) {
		%><p
			style="color: green; margin: 20px; text-align: center;"><%=session.getAttribute("update_req_OK")%></p>
		<%
		}
		session.removeAttribute("update_req_OK");
		%>
		<%
		String p = request.getParameter("p");
		if (p == null)
			p = "0";
		int pNum = Integer.parseInt(p);
		Donor current_user = (Donor) session.getAttribute("current_user");
		DonorRequestDao drDao = new DonorRequestDao(ConnectionProvider.main());
		ArrayList<DonorRequest> reqList = drDao.getRequestByDonorId(current_user.getDonor_id(), pNum);
		if (reqList != null) {
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
				<a id="call_btn" href="<%=request.getContextPath()+"/DeleteRequestServlet?req="+dReq.getRequest_id()%>">Delete</a> <a id="msg_btn" href="update_request.jsp?req=<%=dReq.getRequest_id()%>">Edit</a>
			</div>
		</section>
		<%
		}
		} else {
		%>
		<section class="news_card">
			<div style="display: flex; align-items: center">NO REQUEST
				FOUND!</div>
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
			<button id="prev_btn" disabled="disabled" style="background: gray">Previous</button>
			<%
			} else {
			%>
			<a id="next_btn" href="?p=<%=pNum + 1%>">Next</a>
			<%
			}
			%>
		</div>
	</section>

	<footer style="text-align: center">
		<p>S.A.D PROJECT &copy;2024</p>
	</footer>
</body>
</html>
