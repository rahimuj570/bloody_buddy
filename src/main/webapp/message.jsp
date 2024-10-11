<%@page import="entities.Chats"%>
<%@page import="dao.ChatsDao"%>
<%@page import="dao.DonorDao"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.security.cert.CRL"%>
<%@page import="entities.ChatRoom"%>
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
<title>Message</title>
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
				<li><a href="<%=request.getContextPath()%>">Home</a></li>
				<li><a href="/profile.html">Profile</a></li>
				<li><a href="message.jsp">Message(10)</a></li>
				<%
				InterestDao intDao = new InterestDao(ConnectionProvider.main());
				Donor current_user = (Donor) session.getAttribute("current_user");
				int notification_count = intDao.countUnseenInterest(current_user.getDonor_id());
				%>
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

	<!-- NEWS FEED -->
	<section class="news_par">

		<p
			style="text-align: center; font-size: 30px; font-weight: bold; margin: 30px; color: red;">MESSAGES</p>

		<%
		String p = request.getParameter("p");
		if (p == null)
			p = "0";
		int pNum = Integer.parseInt(p);

		//////

		ChatRoomDao crDao = new ChatRoomDao(ConnectionProvider.main());
		DonorDao dDao = new DonorDao(ConnectionProvider.main());
		ChatsDao cDao = new ChatsDao(ConnectionProvider.main());
		ArrayList<ChatRoom> crList = crDao.getAllChatRoomByPersonId(current_user.getDonor_id(), pNum);
		if (crList != null && !crList.isEmpty()) {
			for (ChatRoom cr : crList) {

				String per[] = cr.getPersons().split(",");
				int receiver_id = Integer.parseInt(per[0]) == current_user.getDonor_id() ? Integer.parseInt(per[1])
				: Integer.parseInt(per[0]);
				Donor d = dDao.getDonorById(receiver_id);
				Chats c = cDao.getLastChatByRoomId(cr.getRoom_id());

				////////////

				String pattern = "dd MMMM, yyyy";
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
				String date = simpleDateFormat.format(cr.getLast_update());
				String pattern2 = "hh:mm a";
				SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);
				String time = simpleDateFormat2.format(cr.getLast_update());
		%>
		<a style="text-decoration: none; color: #000"
			href="chat.jsp?room=<%=cr.getRoom_id()%>">
			<section style="position: relative" class="news_card">
				<div style="display: flex; align-items: center">
					<img width="100" src="img/blood/<%=d.getBloodgroup()%>.png" alt="" />
					<div class="card_details">
						<strong><%=d.getDonor_name()%></strong>
						<p><%=c.getChat_text().length() > 30 ? c.getChat_text().substring(0, 29) + " ..." : c.getChat_text()%></p>
						<p style="font-size: 12px; padding-top: 10px; color: gray">
							<%=date + " at " + time%></p>
					</div>
				</div>
				<%
				if (cr.getIs_seen() == 0) {
				%>
				<img style="position: absolute; right: 5px; top: 5px" width="20"
					src="img/icon/unread.png" alt="" />
				<%
				}
				%>
			</section>
		</a>

		<%
		}
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
			if (crList.size() < 10) {
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
	</section>

	<footer style="text-align: center">
		<p>S.A.D PROJECT &copy;2024</p>
	</footer>
</body>
</html>
