<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<% 

int row_permit = -1;
int dept_id = (int)session.getAttribute("dept_id");
int user_id = (int)session.getAttribute("user_id");
int permit = (int)session.getAttribute("permit");

Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");
PreparedStatement pst_budget = conn.prepareStatement("SELECT user_details.dept_id, user_details.user_id, user_details.pass, user_details.user_code, dept_details.dept_code, dept_details.dept_total_budget,dept_details.add_budget AS dept_add_budget ,dept_details.main_budget AS dept_main_budget,dept_details.dept_commit,dept_details.dept_spent, user_details.full_name, user_details.username, user_details.permit, user_details.main_budget AS user_main_budget, user_details.add_budget AS user_add_budget, user_details.user_total_budget,user_details.user_commit,user_details.user_spent, user_details.user_id from user_details, dept_details where user_details.dept_id = dept_details.dept_id");
ResultSet rs_budget = pst_budget.executeQuery();
/* rs_budget.next(); */
float total_avail_budget = 0.00f;
float dept_total_avail_budget = 0.00f;
float sc_budget = 0.00f;

while(rs_budget.next()){
	if(rs_budget.getInt("user_id")==user_id){
total_avail_budget = rs_budget.getFloat("user_main_budget")+rs_budget.getFloat("user_add_budget");
dept_total_avail_budget = rs_budget.getFloat("dept_main_budget")+rs_budget.getFloat("dept_add_budget");
sc_budget = rs_budget.getFloat("user_commit")+rs_budget.getFloat("user_spent");
}}
rs_budget.beforeFirst();
String full_name = (String)session.getAttribute("full_name");

PreparedStatement pst_budget_dwise = conn.prepareStatement("SELECT dept_details.dept_id, dept_details.dept_name, user_details.full_name, dept_details.dept_total_budget, dept_details.main_budget AS dept_main_budget, dept_details.add_budget AS dept_add_budget, dept_details.dept_spent, dept_details.dept_commit from dept_details, user_details WHERE dept_details.dept_id=user_details.dept_id AND user_details.permit=4");
ResultSet rs_budget_dwise = pst_budget_dwise.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
div {
  border-radius: 5px;
  border-color: green;
  background-color: #E0E0E0;
  padding: 5px;
}
.divmedium{
	width: 60%;
}
.divlarge{
	width: 70%;
}
form {
	width: 60%;
}
thead input {
        width: 100%;
    }

button{
  background-color: #4CAF50;
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
input[type=submit]{
  background-color: #4CAF50; 
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
input {
  width: 60%;
  padding: 12px 20px;
  margin: 8px 5px;
  box-sizing: border-box;
  border: 3px solid #ccc;
  -webkit-transition: 0.5s;
  transition: 0.5s;
  outline: none;
}
/* input[type=search]{
  align: center;
  float: center;
  background-color: #4CAF50;
} */
body{
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
}
table {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}
.70widthtable{
	width: 70%;
}
.100widthtable:nth-child(even){background-color: #f2f2f2;}

.100widthtable{
	width: 100%;
}

table tr:hover {background-color: #ddd;}

table th {
  padding-top: 12px;
  padding-bottom: 12px;
  
  padding-left: 7px;
  text-align: left;
  background-color: #4CAF50;
  color: white;
  
}

table td {
  padding-top: 12px;
  padding-bottom: 12px;
  padding-left: 12px;
  text-align: left;
  
}

th:hover{
     cursor:pointer;
    background:#AAA;
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
/* table td{
	white-space: nowrap;
    overflow: hidden;
} */
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
<h1>Budget Analysis</h1><br>
<div class="divmedium">
<br>
<table class="70widthtable" border=0>
	<%while(rs_budget.next()){
	if(rs_budget.getInt("user_id")==user_id){%>
	<tr>
		<td>Available Budget:</td>
		<td><input type="number" value=<%=total_avail_budget%> readOnly></input></td>
		<%-- <td><%=total_avail_budget%><td> --%>
	</tr>
	<tr>
		<td>Committed Budget:</td>
		<td><input type="number" value=<%=rs_budget.getFloat("user_commit")%> readOnly></input></td>
		<%-- <td><%=rs_budget.getFloat("user_commit")%><td> --%>
	</tr>
	<tr>
		<td>Used Budget:</td>
		<td><input type="number" value=<%=rs_budget.getFloat("user_spent")%> readOnly></input></td>
		<%-- <td><%=rs_budget.getFloat("user_spent")%><td> --%>
	</tr>
	<tr>
		<td>Dept. Available Budget:</td>
		<td><center></center><input type="number" value=<%=dept_total_avail_budget%> readOnly></input><center></td>
		<%-- <td><%=dept_total_avail_budget%><td> --%>
	</tr>
	<tr>
		<td>Dept. Committed Budget:</td>
		<td><input type="number" value=<%=rs_budget.getFloat("dept_commit")%> readOnly></input></td>
		<%-- <td><%=rs_budget.getFloat("dept_commit")%><td> --%>
	</tr>
	<tr>
		<td>Dept. Used Budget:</td>
		<td><input type="number" value=<%=rs_budget.getFloat("dept_spent")%> readOnly></input></td>
		<%-- <td><%=rs_budget.getFloat("dept_spent")%><td> --%>
	</tr>
	<%}}rs_budget.beforeFirst();%>
</table>
<br>
</div>
<br>
<%if(permit<=4){%>
<h1>Department Budget Analysis</h1><br>
<div class="divlarge">
<table class="100widthtable">
	<tr>
		<th>Emp No.</th>
		<th>Faculty</th>
		<th>Total Allocated Budget</th>
		<th>Available</th>
		<th>Committed</th>
		<th>Used</th>
		<th>Modify Budget</th>
	</tr>
	<%while(rs_budget.next()){
	if(rs_budget.getInt("dept_id")==dept_id){%>
	<tr>
		<td><%=rs_budget.getInt("user_id")%></td>
		<td><%=rs_budget.getString("full_name")%></td>
		<%float user_total_avail_budget = rs_budget.getFloat("user_main_budget")+rs_budget.getFloat("user_add_budget");%>
	
		<td><%=rs_budget.getFloat("user_total_budget")%></td>
		<td><%=user_total_avail_budget%></td>
		<td><%=rs_budget.getFloat("user_commit")%></td>
		<td><%=rs_budget.getFloat("user_spent")%></td>
		<td><a href="user_modify.jsp?emp_no=<%=rs_budget.getInt("user_id")%>">Modify</a></td>
	</tr>
	<%}}%>
</table>
</div>
<%}
else{%>
<h1>Department-Wise Budget Analysis</h1><br>
<div class="divlarge">
<table class="100widthtable" border=0>
	<tr>
		<th>Dept ID</th>
		<th>Dept Name</th>
		<th>HOD</th>
		<th>Total Allocated Budget</th>
		<th>Available Budget</th>
		<th>Budget Committed</th>
		<th>Budget Used</th>
		<th>Modify</th>
	</tr>
	<%
	//float dept_total_avail_budget = 0.00f;
	while(rs_budget_dwise.next()){
	/* if(rs_budget_dwise.getInt("dept_id")==dept_id){ */%>
	<tr>
		<td><%=rs_budget_dwise.getInt("dept_id")%></td>
		<td><%=rs_budget_dwise.getString("dept_name")%></td>
		<td><%=rs_budget_dwise.getString("full_name")%></td>
		<%dept_total_avail_budget = rs_budget_dwise.getFloat("dept_main_budget")+rs_budget_dwise.getFloat("dept_add_budget");%>
		<td><%=rs_budget_dwise.getFloat("dept_total_budget")%></td>
		<td><%=dept_total_avail_budget%></td>
		<td><%=rs_budget_dwise.getFloat("dept_commit")%></td>
		<td><%=rs_budget_dwise.getFloat("dept_spent")%></td>
		<td><a href="dept_modify.jsp?dept_no=<%=rs_budget_dwise.getInt("dept_id")%>">Modify</a></td>
	</tr>
	<%}}%>
</table>
</div>

<%-- <h1>Department Budget Analysis</h1><br>
<table>
	<tr>
		<td>Available Budget:<td>
		<td><%=total_avail_budget%><td>
	</tr>
	<tr>
		<td>Committed Budget:<td>
		<td><%=rs_budget.getFloat("user_commit")%><td>
	</tr>
	<tr>
		<td>Used Budget:<td>
		<td><%=rs_budget.getFloat("user_spent")%><td>
	</tr>
</table> --%>
</body>
</html>