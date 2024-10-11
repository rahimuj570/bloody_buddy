<%@page import="dao.DonorDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.DonorRequest"%>
<%@page import="dao.DonorRequestDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ChatRoomDao"%>
<%@page import="entities.Donor"%>
<%@page import="dao.InterestDao"%>
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
			style="text-align: center; font-size: 30px; font-weight: bold; margin: 30px; color: red;">FIND
			DONOR</p>
		<form action="find_donor.jsp" class="login_inputs"
			style="display: flex; gap: 30px; margin: 20px 0px; justify-content: center; background: rgb(255, 234, 234); padding: 10px; align-items: center;">
			<div>
				<label for="division">Division</label> <select
					style="display: inline-block; margin-bottom: 0; padding: 10px; width: fit-content; border-radius: 5px; border: 0; height: unset; background-color: rgb(255, 206, 206);"
					name="div" id="division" required>
					<option selected="selected" value="">Choose One</option>
				</select>
			</div>
			<div>
				<label for="district">District</label> <select
					style="display: inline-block; margin-bottom: 0; padding: 10px; width: fit-content; border-radius: 5px; border: 0; height: unset; background-color: rgb(255, 206, 206);"
					name="dis" id="district" required>
					<option selected="selected" value="">Choose One</option>
				</select>
			</div>
			<div>
				<label for="sub_district">Sub-District</label> <select
					style="display: inline-block; margin-bottom: 0; padding: 10px; width: fit-content; border-radius: 5px; border: 0; height: unset; background-color: rgb(255, 206, 206);"
					name="sdis" id="sub_district" required><option
						selected="selected" value="">Choose One</option>
				</select>
			</div>
			<button
				style="display: inline-block; margin-bottom: 0; padding: 10px; width: fit-content; border-radius: 5px; border: 0; height: unset; font-size: 16px; background: rgb(142, 129, 255); color: white;"
				id="login_btn">Filter</button>
			<a href="find_donor.jsp"
				style="display: inline-block; margin-bottom: 0; padding: 10px; width: fit-content; border-radius: 5px; border: 0; height: unset; font-size: 16px; color: white; text-decoration: navajowhite; background: black; } #login_btn { cursor: pointer; background-color: lime; font-size: 20px; transition: linear 0.3s; } * { padding: 0; margin: 0; margin-bottom: 0px; box-sizing: border-box;"
				id="login_btn">Reset</a>
		</form>
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
		DonorDao dDao = new DonorDao(ConnectionProvider.main());
		String div = request.getParameter("div") != null ? request.getParameter("div") : "";
		String dis = request.getParameter("dis") != null ? request.getParameter("dis") : "";
		String sdis = request.getParameter("sdis") != null ? request.getParameter("sdis") : "";
		ArrayList<Donor> dList = dDao.findAvailableDonors(current_user.getDonor_id(), div, dis, sdis, pNum);
		if (dList != null) {
			for (Donor d : dList) {
		%>
		<section class="news_card">
			<div style="display: flex; align-items: center">
				<img width="100" src="img/blood/<%=d.getBloodgroup()%>.png" alt="" />
				<div class="card_details">
					<p>
						Donor Name:
						<%=d.getDonor_name()%></p>
					<p>
						Mobile:
						<%=d.getDonor_mobile()%></p>
					<p>
						Division:
						<%=d.getDivision()%></p>
					<p>
						District:
						<%=d.getDistrict()%></p>
					<p>
						Sub District:
						<%=d.getSub_district()%></p>

				</div>
			</div>
			<div class="news_action_btn">
				<a id="call_btn" href="tel:<%=d.getDonor_mobile()%>">Call</a> <a
					id="msg_btn"
					href="CreateChatRoomServlet?receiver=<%=d.getDonor_id()%>">Message</a>
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
			String url = request.getContextPath() + "/find_donor.jsp";
			if (request.getParameter("div") != null) {
				url += "?div=" + div.replace(" ", "+") + "&dis=" + dis.replace(" ", "+") + "&sdis=" + sdis.replace(" ", "+");
			}
			if (p == null || p.equals("0")) {
			%>
			<button id="prev_btn" disabled="disabled" style="background: gray">Previous</button>
			<%
			} else {
			%>
			<a id="prev_btn" href="<%=url%>&p=<%=pNum - 1%>">Previous</a>
			<%
			}
			if (dList.size() < 20) {
			%>
			<button id="prev_btn" disabled="disabled" style="background: gray">Next</button>
			<%
			} else {
			%>
			<a id="next_btn" href="<%=url%>&p=<%=pNum + 1%>">Next</a>
			<%
			}
			%>
		</div>
	</section>

	<footer style="text-align: center">
		<p>S.A.D PROJECT &copy;2024</p>
	</footer>

	<script>
      var areas={}
      var districts={}
      let loc = async()=>{    	  
      let division=[];
      let district=[];
      let selectedDivision;
      await fetch('bd_areas.json').then(res=>res.json()).then(data=>areas=data);
      division = Object.keys(areas);
      for (var i = 0; i<division.length; i++){
    	    var opt = document.createElement('option');
    	    opt.value = division[i];
    	    opt.innerHTML = division[i];
    	    document.getElementById('division').appendChild(opt);
    	}
      document.getElementById('division').addEventListener('change',async(e)=> {
    	districts=areas[e.target.value];
      district = Object.keys(areas[e.target.value]);
      document.getElementById('district').innerHTML='';
      
  	   var opt = document.createElement('option');
  	   opt.innerHTML="Choose One";
  	    opt.value = '';
  	    document.getElementById('district').appendChild(opt);
      for (var i = 0; i<district.length; i++){
  	   	opt = document.createElement('option');
  	    opt.value = district[i];
  	    opt.innerHTML = district[i];
  	    document.getElementById('district').appendChild(opt);
  	} 
      });
      
      document.getElementById('district').addEventListener('change',async(e)=> {
          sub_district = (districts[e.target.value]);
          document.getElementById('sub_district').innerHTML='';
          for (var i = 0; i<sub_district.length; i++){
      	    var opt = document.createElement('option');
      	    opt.value = sub_district[i];
      	    opt.innerHTML = sub_district[i];
      	    document.getElementById('sub_district').appendChild(opt);
      	} 
          });
      
      }
      loc();
      
      
    </script>

</body>
</html>
