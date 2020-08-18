<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<style>
body{
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  background-image: url('3croppedlogin.jpg');
  background-size: cover;
}
div {
  width: 40%;
  border: 5px green;
  border-radius: 5px;
  border-color: green;
  color: white;
  background-color: #E0E0E000;
  padding: 5px;
}
form {
	width: 60%;
}
input {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 5px;
  box-sizing: border-box;
  border: 3px solid #ccc;
  -webkit-transition: 0.5s;
  transition: 0.5s;
  outline: none;
}
input:focus {
  border: 3px solid #555;
}
input[type=submit]{
	width: 40%;
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
</head>

<body>
<ul>
  <li><a href="index.jsp">About Us</a></li>

  
  <li><a href="#">Contact</a></li>
  <li style="float:right"><a href="login.jsp" class="active">Login</a></li>
  <li style="float:right"><img src="icon-user.png" width="40" height="40"></li>
  
  
  <!-- <li style="float:right"><a href="logout.jsp">Logout</a></li>
  <li style="float:right"><a href="change_pass.jsp">Change Password</a></li> -->
</ul>
<center>
<br><br><br>
<div style="border:5px solid gray;">
<h1>Login</h1>
<form name="loginform" action="validatelogin.jsp" method="get" onsubmit="refresh()")>
	<%if(session.getAttribute("errorMsg")!=null){%>
		<p style="color:red">Wrong username/password</p>
	<%
		session.setAttribute("errorMsg",null);
	}%>
	<table border=0>
	<tr>
	<td><b>Username:</b></td>
	<td><input type = "text" id="username" name="username" required></input></td>
	</tr>
	<tr>
	<td><b>Password:</b></td>
	<td><input type = "password" id="pass" name="pass" required></input><br></td>
	</tr>
	<tr>
	<td colspan="2" align=center><br><br><input type="submit" value="Login" /></td>
	</tr>
	<!-- <tr>
	<td colspan="2" align=center><br><br><a href="change_pass.jsp">Change Password</a></h3></td>
	</tr> -->
</table>
<br><br>
</form>
</div>
</center>
</body>
</html>