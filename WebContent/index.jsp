<!DOCTYPE html>
<html>
<head>
<style>
body {
  background-image: url('3cropped2.jpg');
  background-size: cover;
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
}
.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 16px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  transition-duration: 0.4s;
  cursor: pointer;
}
.button1 {
  background-color: #4CAF5000; 
  color: white; 
  border: 4px solid #4CAF50;
  border-radius: 8px;
}
.button1:hover {
  background-color: #4CAF50;
  color: white;
  border-radius: 8px;
}
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
/*   position: fixed;
  top: 0;
  width: 100%; */
  border: 1px solid #484848;
  background-color: #484848;
}

li {
  border-right: 1px solid #484848;
  float: left;
}



li a:hover:not(.active) {
  /* background-color: #22ce22; */
  background-color: #5bc25b;
  
}

li:last-child {
  border-right: none;
}

.active {
  color: white;
  background-color: #4CAF50;
}

li a {
  display: inline-block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

.dropbtn {
  display: inline-block;
  color: #666;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

li a:hover, .dropdown:hover .dropbtn {
  background-color: #4CAF50;
  color: white;
}

li.dropdown {
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
}

.dropdown-content a:hover {background-color: #f1f1f1;}

.dropdown:hover .dropdown-content {
  display: block;
}
</style>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<ul>
  <li><a href="#" class="active">About Us</a></li>

  
  <li><a href="#">Contact</a></li>
  <li style="float:right"><a href="login.jsp">Login</a></li>
  <li style="float:right"><img src="icon-user.png" width="40" height="40"></li>
  
  
  <!-- <li style="float:right"><a href="logout.jsp">Logout</a></li>
  <li style="float:right"><a href="change_pass.jsp">Change Password</a></li> -->
</ul>
<br><br><br>
<h1 style="font-size:55px;color:#A9A9A9;">Purchase Management.<br>Simplified.</h1>
<!-- <h3 style="font-size:40px;color:white;">Simplified.</h3> -->
<button class="button button1" onclick="window.location.href='login.jsp';">Get Started</button>
</body>
</html>