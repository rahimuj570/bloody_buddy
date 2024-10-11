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
		<a href="<%=request.getContextPath()%>"><img width="100"
			src="img/icon/register.png" alt="" /></a>
		<h1>Create an Account</h1>
		<%
		if (session.getAttribute("registration_BAD") != null) {
		%><p style="color: red"><%=session.getAttribute("registration_BAD")%></p>
		<%
		}
		session.removeAttribute("registration_BAD");
		%>
		<form class="login_inputs" action="RegisterServlet" method="post">
			<input required placeholder="Your Name" type="text" name="name"
				id="name" /> <input required placeholder="Your Email" type="email"
				name="email" id="email" /> <input required
				placeholder="Your Mobile" type="tel" name="mobile" id="mobile" />
			<div class="password_input">
				<input required placeholder="Your Password" type="password"
					name="password" id="password" /> <img onclick="tgl()"
					id="eye_icon" width="25" src="img/icon/eye.png" alt="" />
			</div>
			<label for="group">Blood Group</label> <select name="group"
				id="group">
				<option value="a_pos">A+</option>
				<option value="a_neg">A-</option>
				<option value="b_pos">B+</option>
				<option value="b_neg">B-</option>
				<option value="ab_pos">AB+</option>
				<option value="ab_neg">AB-</option>
			</select>
			<div style="margin: 10px 0px">
				<hr>
				<hr>
				<hr>
			</div>
			<label for="division">Division</label> <select name="division"
				id="division" required>
				<option selected="selected" value="">Choose One</option>
			</select> <label for="district">District</label> <select name="district"
				id="district" required>
				<option selected="selected" value="">Choose One</option>
			</select> <label for="sub_district">Sub-District</label> <select
				name="sub_district" id="sub_district" required><option
					selected="selected" value="">Choose One</option>
			</select>
			<button id="login_btn">Register</button>
		</form>

		<a href="<%=request.getContextPath()%>/login.jsp">Already have an
			account?</a>
	</section>

	<script>
      const eye_icon = document.getElementById("eye_icon");
      const password_input = document.getElementById("password");
      let tgl = () => {
        if (password_input.type == "text") password_input.type = "password";
        else password_input.type = "text";
      };
      
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
