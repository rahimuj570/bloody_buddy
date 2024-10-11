<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Create Request</title>
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <section class="menu_sec">
      <div class="logo_menu">
        <div style="width: 50px">
          <img style="width: 100%" src="logo.png" alt="" />
        </div>
        <ul class="menu_par">
          <li><a href="">Home</a></li>
          <li><a href="">Profile</a></li>
          <li><a href="/message.html">Message(10)</a></li>
          <li><a href="">Notification(10)</a></li>
          <li><a href="">Buddies(10)</a></li>
          <li><a href="/create_request.html">Create Request</a></li>
        </ul>
      </div>
      <div class="search_par">
        <input
          required
          placeholder="Search Here ..."
          id="search_bar"
          type="text"
        />
        <a id="search_btn" href="">
          <img width="35" src="search.png" alt="" />
        </a>
      </div>
    </section>

    <!-- NEWS FEED -->
    <section class="news_par">
      <div class="create_request_head">
        <h1>Create Request For Blood Donor</h1>
        <p>Must fill in all the input!</p>
      </div>
      <form action="CreateRequestServlet" id="create_request_form" method="post">
        <label for="patient_name">Patient Name</label>
        <br />
        <input required type="text" name="patient_name" id="patient_name" />
        <br />
        <label for="date">When do you need blood?</label>
        <br />
        <input required type="datetime-local" name="date" id="date" />
        <br />
        <label for="why">Why do you need blood?</label>
        <br />
        <input required type="text" name="why" id="why" />
        <br />
        <label for="group">What blood group do you need?</label>
        <br />
        <select name="group" id="group">
          <option value="a_pos">A+</option>
          <option value="a_neg">A-</option>
          <option value="b_pos">B+</option>
          <option value="b_neg">B-</option>
          <option value="o_pos">o+</option>
          <option value="o_neg">o-</option>
          <option value="ab_pos">AB+</option>
          <option value="ab_neg">AB-</option>
        </select>
        <br />
        <label for="need">How many units are needed?</label>
        <br />
        <input required type="number" name="need" id="need" />
        <br />
        <label for="mobile">Mobile Number</label>
        <br />
        <input required type="number" name="mobile" id="mobile" />
        <br />
        <label for="location">Where is it needed?</label>
        <p style="font-size: 12px">ex: Square Hospitals, Panthapath, Dhaka</p>
        <br />
        <input required type="text" name="location" id="location" />
        <br />
        <button>Create Request</button>
      </form>
    </section>

    <footer style="text-align: center">
      <p>S.A.D PROJECT &copy;2024</p>
    </footer>
  </body>
</html>
