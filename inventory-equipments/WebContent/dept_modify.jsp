<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%
int dept_no = Integer.valueOf(request.getParameter("dept_no"));
System.out.println("DEPT ID IS: "+dept_no);
String full_name = (String)session.getAttribute("full_name");
int permit = (int)session.getAttribute("permit");
Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");

PreparedStatement pst_budget_dwise = conn.prepareStatement("SELECT dept_details.dept_id, dept_details.dept_name, user_details.full_name, dept_details.dept_total_budget, dept_details.main_budget AS dept_main_budget, dept_details.add_budget AS dept_add_budget, dept_details.dept_spent, dept_details.dept_commit from dept_details, user_details WHERE dept_details.dept_id=? AND dept_details.dept_id=user_details.dept_id");
pst_budget_dwise.setInt(1,dept_no);
ResultSet rs_budget_dwise = pst_budget_dwise.executeQuery();
rs_budget_dwise.next();
/* System.out.println(rs_budget.getString("full_name")); */
//float total_avail_budget = rs_budget.getFloat("user_main_budget")+rs_budget.getFloat("user_add_budget");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
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
  <li><a href="displaydet.jsp">Home</a></li>
  <%if(permit<=3){%>
  <li><a href="user_budget_display.jsp" class="active">My Budget</a></li>
	<%} else{%>
	<li><a href="admin_budget_display.jsp" class="active">My Budget</a></li>
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
<center>
<h1>Budget Allocation</h1>
<div>
<br>
<form action="dept_modify_validate.jsp">
<table>
	<tr>
		<td>Dept ID:</td>
		<td><input type="number" value="<%=dept_no%>" id="dept_no" name="dept_no" readonly></input></td>
	</tr>
	<tr>
		<td>Dept Name:</td>
		<td><input type="text" value="<%=rs_budget_dwise.getString("dept_name")%>"></input></td>
	</tr>
	<tr>
		<td>Total Allocated Budget:</td>
		<td><input type="number" id="dept_total_budget" name="dept_total_budget" value="<%=rs_budget_dwise.getFloat("dept_total_budget")%>"></input></td>
	</tr>
	<tr>
		<td>Main Budget:</td>
		<td><input type="number" id="dept_main_budget" name="dept_main_budget" value="<%=rs_budget_dwise.getFloat("dept_main_budget")%>"></input></td>
	</tr>
	<tr>
		<td>Additional Budget:</td>
		<td><input type="number" id="dept_add_budget" name="dept_add_budget" value="<%=rs_budget_dwise.getFloat("dept_add_budget")%>"></input></td>
	</tr>
	<tr>
		<td>Committed Name:</td>
		<td><input type="number" id="dept_commit" name="dept_commit" value="<%=rs_budget_dwise.getFloat("dept_commit")%>"></input></td>
	</tr>
	<tr>
		<td>Spent Budget:<br><br></td>
		<td><input type="number" id="dept_spent" name="dept_spent" value="<%=rs_budget_dwise.getFloat("dept_spent")%>"></input><br><br></td>
	</tr>
	<tr>
		<td colspan=2 align=center><input type="submit" value="Modify"></td>
	</tr>
</table>
</form>
<br>
</div>
</center>
</body>
</html>