<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
<% 
Class.forName("com.mysql.jdbc.Driver"); // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");
String username = (String)session.getAttribute("username");
String full_name = (String)session.getAttribute("full_name");
int permit = (int)session.getAttribute("permit");

PreparedStatement pst = conn.prepareStatement("SELECT pass from user_details where username=?");
pst.setString(1,username);
ResultSet rs = pst.executeQuery();
rs.next();
String pass = rs.getString("pass");
System.out.println(pass);
%>
<!DOCTYPE html>
<html>
<head>
<style>
#message {
  display:none;
  background: #f1f1f1;
  color: #000;
  position: relative;
  padding: 20px;
  margin-top: 10px;
}

#message p {
  padding: 10px 35px;
  font-size: 18px;
}
body{
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
}
div {
  width: 49%;
  border-radius: 5px;
  border-color: green;
  background-color: #E0E0E0;
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
 
  border: 1px solid #e7e7e7;
  background-color: #D3D3D3;
}

li {
  border-right: 1px solid #bbb;
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
  color: #666;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

.dropbtn {
  display: inline-block;
  /* color: #666; */
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  color: white;
  background-color: #4CAF50;
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
<script>

</script>
<script language="javascript">
function checksame(){
	alert("hello0");
	var pass_old = document.getElementById("pass_old").value;
	alert("hello1");
	alert("pass old:"+pass_old);
	alert("hello2");
	var db_pass_old="<%=pass%>";
	alert("hello3");
	alert("db pass old:"+db_pass_old);
	alert("done");
	if(pass_old!=db_pass_old){
		document.getElementById("wrong_pass").innerHTML = "Wrong Password";
		alert("NOT Authenticated!");
		return false;
	}
	else{
		alert("Authenticated!");
		return true;
	}
	var pass1 = document.getElementById("pass_new_1").value;
	var pass2 = document.getElementById("pass_new_2").value;
	if(pass1!=pass2){
		alert("Passwords do not match !");
		return false;
	}
	else{
		return true;
	}
}
</script>
</head>
<body>
<ul>
  <li><a href="displaydet.jsp">Home</a></li>
  <%if(permit<=3){%>
  <li><a href="user_budget_display.jsp" >My Budget</a></li>
	<%} else{%>
	<li><a href="admin_budget_display.jsp">My Budget</a></li>
	<%}%>
  
  <li><a href="orderform.jsp" >Place Order</a></li>
  
  <li style="float:right" class="dropdown">
    <a href="javascript:void(0)" class="dropbtn"><%=full_name%></a>
    <div class="dropdown-content">
      <a href="logout.jsp">Logout</a>
      <a href="change_pass.jsp">Change Password</a>
    </div>
  </li>
  <li style="float:right"><img src="icon-user.png" width="40" height="40"></li>
  <!-- <li style="float:right"><a href="logout.jsp">Logout</a></li>
  <li style="float:right"><a href="change_pass.jsp">Change Password</a></li> -->
</ul>
<script>
var myInput_1 = document.getElementById("pass_new_1");
var myInput_2 = document.getElementById("pass_new_2");
var letter = document.getElementById("letter");
var capital = document.getElementById("capital");
var number = document.getElementById("number");
var length = document.getElementById("length");

// When the user clicks on the password field, show the message box
myInput_1.onfocus = function() {
  document.getElementById("message").style.display = "block";
}

// When the user clicks outside of the password field, hide the message box
myInput_1.onblur = function() {
  document.getElementById("message").style.display = "none";
}

// When the user starts to type something inside the password field
myInput_1.onkeyup = function() {
  // Validate lowercase letters
  var lowerCaseLetters = /[a-z]/g;
  if(myInput_1.value.match(lowerCaseLetters)) {
    letter.classList.remove("invalid");
    letter.classList.add("valid");
  } else {
    letter.classList.remove("valid");
    letter.classList.add("invalid");
}

  // Validate capital letters
  var upperCaseLetters = /[A-Z]/g;
  if(myInput_1.value.match(upperCaseLetters)) {
    capital.classList.remove("invalid");
    capital.classList.add("valid");
  } else {
    capital.classList.remove("valid");
    capital.classList.add("invalid");
  }

  // Validate numbers
  var numbers = /[0-9]/g;
  if(myInput_1.value.match(numbers)) {
    number.classList.remove("invalid");
    number.classList.add("valid");
  } else {
    number.classList.remove("valid");
    number.classList.add("invalid");
  }

  // Validate length
  if(myInput_1.value.length >= 8) {
    length.classList.remove("invalid");
    length.classList.add("valid");
  } else {
    length.classList.remove("valid");
    length.classList.add("invalid");
  }
}
</script>
<center>
<br><br><br><br>
<div>
<form action="change_pass_validate.jsp" onsubmit="return checksame()" method="post">
<table border="0" width=100%>
		<tr>
		<td colspan=2 align=center>
			<h1>Change Password</h1>
		</tr>
		<tr>
			<td colspan=2 align=center><p id="wrong_pass"></p></td>
		</tr>
		<tr>
			<td><b>Old Password:</b></td>
			<!-- <td><input type="password"  id="pass_new_1" name="pass_new_1"></input></td> -->
			<td><input type="password" id="pass_old" name="pass_old" required></input></td>
		</tr>
		<tr>
			<td><b>New Password:</b></td>
			<!-- <td><input type="password"  id="pass_new_1" name="pass_new_1"></input></td> -->
			<td><input type="password"  id="pass_new_1" name="pass_new_1" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
			title="Must contain at least one number and one uppercase and lowercase letter, 
			and at least 8 or more characters" required></input></td>
		</tr>
		<tr>
			<td><b>Confirm Password:</b></td> 
			<td><input type="password"  id="pass_new_2" name="pass_new_2" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
			title="Must contain at least one number and one uppercase and lowercase letter, 
			and at least 8 or more characters" required></input></td>
		</tr>
		<tr> <td><br></td> <td><br></td> </tr>
		<tr>
			<td colspan=2 align=center><input type="submit"  id="pass" name="pass" value="Change"
			 required></input></td>
		</tr>
		</tr>
		<tr> <td><br></td> <td><br></td> </tr>
		<tr>
</form>
</div>
<div id="message">
  <h3>Password must contain the following:</h3>
  <p id="letter" class="invalid">A <b>lowercase</b> letter</p>
  <p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
  <p id="number" class="invalid">A <b>number</b></p>
  <p id="length" class="invalid">Minimum <b>8 characters</b></p>
</div>
</center>
</body>
</html>