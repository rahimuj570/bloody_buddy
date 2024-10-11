<%@page import="helper.GetProperBloodGroupName"%>
<%@page import="dao.DonorDao"%>
<%@page import="entities.ChatRoom"%>
<%@page import="dao.ChatRoomDao"%>
<%@page import="entities.Chats"%>
<%@page import="dao.ChatsDao"%>
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
<title>Buddy namse</title>
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

		<%
		String p = request.getParameter("p");
		if (p == null)
			p = "0";
		int pNum = Integer.parseInt(p);
		int room_id = Integer.parseInt(request.getParameter("room"));
		ChatsDao cDao = new ChatsDao(ConnectionProvider.main());
		ChatRoomDao crDao = new ChatRoomDao(ConnectionProvider.main());
		ChatRoom cr = crDao.getChatRoomByRoomId(room_id);
		ArrayList<Chats> cList = cDao.getAllChatsByRoomId(room_id, pNum);
		String personsID[] = cr.getPersons().split(",");
		int receiver_id = Integer.parseInt(personsID[0]) == current_user.getDonor_id()
				? Integer.parseInt(personsID[1])
				: Integer.parseInt(personsID[0]);
		DonorDao dDao = new DonorDao(ConnectionProvider.main());
		Donor receiver = dDao.getDonorById(receiver_id);

		String pattern = "dd MMMM,yyyy";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		String pattern2 = "hh:mm a";
		SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);
		%>


		<div
			style="display: flex; justify-content: space-between; margin-bottom: 10px; padding-bottom: 10px; border-bottom: 3px dotted red;">
			<strong
				style="background-color: rgb(255, 215, 215); padding: 10px; border-top-left-radius: 30px;"><%=receiver.getDonor_name()%>
				(<%=new GetProperBloodGroupName(receiver.getBloodgroup()).getProper_name()%>)</strong>
			<strong
				style="color: white; background-color: red; padding: 10px; border-top-right-radius: 30px;">Me</strong>
		</div>


		<div class="page_par"
			style="padding: 10px 20px; margin-top: 0px; margin-bottom: 60px; background: rgb(255, 234, 234); border-bottom-left-radius: 50px; border-bottom-right-radius: 50px;">
			<%
			if (p == null || p.equals("0")) {
			%>
			<button style="border-bottom-left-radius: 30px; background: gray"
				id="prev_btn" disabled="disabled">Newer</button>
			<%
			} else {
			%>
			<a style="border-bottom-left-radius: 30px" id="prev_btn"
				href="?room=<%=cr.getRoom_id()%>&p=<%=pNum - 1%>">Newer</a>
			<%
			}
			%>

			<button id="prev_btn" onclick="location.reload()"
				style="background: #ff9793; cursor: pointer;">Reload</button>

			<%
			if (cList.size() < 20) {
			%>
			<button style="border-bottom-right-radius: 30px; background: gray"
				id="prev_btn" disabled="disabled">Older</button>
			<%
			} else {
			%>
			<a style="border-bottom-right-radius: 30px" id="next_btn"
				href="?room=<%=cr.getRoom_id()%>&p=<%=pNum + 1%>">Older</a>
			<%
			}
			%>
		</div>

		<%
		for (Chats chat : cList) {
			String date = simpleDateFormat.format(chat.getSent_date());
			String time = simpleDateFormat2.format(chat.getSent_date());
			if (chat.getSender() == current_user.getDonor_id()) {
		%>
		<section class="my_message">
			<p><%=chat.getChat_text()%></p>
			<p class="message_time"><%=date%>
				at
				<%=time%></p>
		</section>
		<%
		} else {
		%>
		<section class="buddy_message">
			<p><%=chat.getChat_text()%></p>
			<p class="message_time"><%=date%>
				at
				<%=time%></p>
		</section>
		<%
		}
		}
		%>
		<form style="position: relative" class="send_message_input"
			action="SentMessageServlet" method="post">
			<input name="room" hidden="true" value="<%=cr.getRoom_id()%>" />
			<textarea name="message" placeholder="Send Message..."></textarea>
			<button
				style="background-color: unset; padding: unset; margin: unset; width: unset; position: absolute; right: 25px; top: 45px; cursor: pointer;">
				<img width="30" src="img/icon/send.png" alt="" />
			</button>
		</form>

	</section>

	<footer style="text-align: center">
		<p>S.A.D PROJECT &copy;2024</p>
	</footer>


	<script type="text/javascript">
	fetch('SeenChatRoomServlet?room=<%=cr.getRoom_id()%>').then(res=>res.text()).then(data=>console.log("seen"));
	</script>

</body>
</html>
