<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<% 

int row_permit = -1;
int dept_id = (int)session.getAttribute("dept_id");
int user_id = (int)session.getAttribute("user_id");
int permit = (int)session.getAttribute("permit");
System.out.println(dept_id);
System.out.println(user_id);
/* permit = 5; */

Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");

ResultSet rs= null;
PreparedStatement pst = conn.prepareStatement("SELECT `order_details`.ord_status, `order_details`.order_id, `dept_details`.dept_name, `dept_details`.dept_id, `user_details`.full_name, `order_details`.po_No, `order_details`.q_No, `order_details`.item_list, `order_details`.grand_total, `order_details`.currency, `order_details`.ord_date, `order_details`.ord_vendor FROM `order_details`,`user_details`,`dept_details` WHERE order_details.user_id=user_details.user_id AND user_details.dept_id=dept_details.dept_id AND user_details.user_id = ?");
pst.setInt(1,user_id);
rs = pst.executeQuery();



PreparedStatement pst_budget = conn.prepareStatement("SELECT user_details.dept_id, user_details.pass, user_details.user_code, dept_details.dept_code, dept_details.dept_total_budget,dept_details.add_budget AS dept_add_budget ,dept_details.main_budget AS dept_main_budget,dept_details.dept_commit,dept_details.dept_spent, user_details.full_name, user_details.username, user_details.permit, user_details.main_budget, user_details.add_budget, user_details.user_total_budget,user_details.user_commit,user_details.user_spent, user_details.user_id from user_details, dept_details where user_details.user_id=?  and user_details.dept_id = dept_details.dept_id");
pst_budget.setInt(1,user_id);
ResultSet rs_budget = pst_budget.executeQuery();
rs_budget.next();
float total_avail_budget = rs_budget.getFloat("main_budget")+rs_budget.getFloat("add_budget");
float sc_budget = rs_budget.getFloat("user_commit")+rs_budget.getFloat("user_spent");
String full_name = (String)session.getAttribute("full_name");
rs_budget.beforeFirst();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
div {
  width: 60%;
  border-radius: 5px;
  border-color: green;
  background-color: #E0E0E0;
  padding: 5px;
}
table td{
	white-space: nowrap;
    overflow: hidden;
}
table  border: 1px solid #ddd;
  padding: 8px;
  overflow: hidden;
  /* white-space: nowrap; */
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
  width: 100%;
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
  border: 1px solid #ddd;
  padding: 8px;
  overflow: hidden;
}
.60width:nth-child(even){background-color: #f2f2f2;}

table tr:hover {background-color: #ddd;}

table th {
  padding-top: 12px;
  padding-bottom: 12px;
  padding-left: 8px;
  text-align: left;
  background-color: #4CAF50;
  color: white;
  
}
table td{
	padding-top: 12px;
  padding-bottom: 12px;
  padding-left: 8px;
}

th:hover{
     cursor:pointer;
    background:#AAA;
}
/* table  border: 1px solid #ddd;
  padding: 8px;
  overflow: hidden;
  /* white-space: nowrap; */

.60width{
width: 60%;
}
.40width{
width: 40%;
}
.100width{
width: 100%;
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
  <li><a href="user_budget_display.jsp"  class="active">My Budget</a></li>
	<%} else{%>
	<li><a href="admin_budget_display.jsp"  class="active">My Budget</a></li>
	<%}%>
  
  <li><a href="orderform.jsp">Place Order</a></li>
  
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
<%-- <h1>Welcome, <%=full_name%></h1> --%>
<center>
<h1>Budget Analysis</h1><br>
<div>
<br>
<table class="40width">
	<tr>
		<td>Available Budget:<td>
		<td><input value="<%=total_avail_budget%>"/></td>
		<%-- <td><%=total_avail_budget%><td> --%>
	</tr>
	<tr>
		<td>Spent+Committed Budget:<td>
		<td><input value="<%=sc_budget%>"/></td>
		<%-- <td><%=sc_budget%><td> --%>
	</tr>
</table>
<br>
</div>
<h1>Pending Orders</h1><br>
<table id="example" border=0 width=100%>
	<thead>
	<tr>
		<th>Order ID</th>
<%-- 		<th>Dept Name</th>
		<%if(permit>4){%>
		<th>Faculty</th> --%>
		<th>PO No.</th>
		<th>Q No.</th>
		<%-- <%
		row_permit = 2;
		}%> --%>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Vendor</th>
		<th>Date</th>
		<%-- <%if(permit>4){%> --%>
		<th>View PO</th>
		<%-- <%}%> --%>
	</tr>
	</thead>
	<!-- <tr>
            <th><input type="text" data-column="1"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="2"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="3"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="4"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="5"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="6"  class="form-control" placeholder="Search"></th>
        </tr>   -->   
    <tbody>
	<!-- <tr>
	<td colspan=2 align="center"><input type="text" id="order_id" onkeyup="myFunction()" placeholder="Search for id" title="Type in a id"></input></td>
	</tr> -->
	<!-- <tr>
		<td id="order_id">Order ID</td>
		<td id="po_No">PO No.</th>
		<td id="dept_name">Dept Name</th>
		<td id="item_list">Items</th>
		<td id="grand_total">Grand Total</th>
		<td id="ord_date">Date</th>
	</tr> -->
	<%while(rs.next()){%>
	<%if(rs.getInt("ord_status")==1){%>
			<tr>
			<td href="show_details.jsp?order_id=<%=rs.getInt("order_id")%>&row_permit=<%=row_permit%>"><%=rs.getInt("order_id")%></td>
			<%-- <td><%=rs.getString("po_No")%></td> --%>
			<%-- <td><%=rs.getString("dept_name")%></td> --%>
			<%-- <%if(permit>4){%>
			<td ><%=rs.getString("full_name")%></td> --%>
			<td ><%=rs.getString("po_No")%></td>
			<td ><%=rs.getString("q_No")%></td>
			<%-- <%}%> --%>
			<td class="hoverclass"><%=rs.getString("item_list")%></td>
			<%String final_total = Float.toString(rs.getFloat("grand_total"))+" "+rs.getString("currency");%>
			<td ><%=final_total%></td>
			<td ><%=rs.getString("ord_vendor")%></td>
			<td ><%=rs.getDate("ord_date")%></td>
			<!-- <td href="login.jsp">Click</td> -->
			<%-- <%if(permit>4){%> --%>
			<td><a href="call_printer.jsp?order_id=<%=rs.getInt("order_id")%>" target="_blank">View</a></td>
			<%-- <%}%> --%>
	   </tr>
	<% }} %>
	</tbody>
	<tfoot>
	<tr>
		<th>Order ID</th>
		<%-- <th>Dept Name</th>
		<%if(permit>4){%>
		<th>Faculty</th> --%>
		<th>PO No.</th>
		<th>Q No.</th>
		<%-- <%}%> --%>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Vendor</th>
		<th>Date</th>
		<%-- <%if(permit>4){%> --%>
		<th>View PO</th>
		<%-- <%}%> --%>
	</tr>
	</tfoot>
</table>

<%rs.beforeFirst();%>
<h1>Cancelled Orders</h1><br>
<table id="example2" class="example2" width=100% border=0>
	<thead>
	<tr>
		<th>Order ID</th>
<%-- 		<th>Dept Name</th>
		<%if(permit>4){%>
		<th>Faculty</th> --%>
		<th>PO No.</th>
		<th>Q No.</th>
		<%-- <%
		row_permit = 2;
		}%> --%>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Vendor</th>
		<th>Date</th>
		<%-- <%if(permit>4){%> --%>
		<%-- <%}%> --%>
	</tr>
	</thead>
	<!-- <tr>
            <th><input type="text" data-column="1"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="2"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="3"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="4"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="5"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="6"  class="form-control" placeholder="Search"></th>
        </tr>   -->   
    <tbody>
	<!-- <tr>
	<td colspan=2 align="center"><input type="text" id="order_id" onkeyup="myFunction()" placeholder="Search for id" title="Type in a id"></input></td>
	</tr> -->
	<!-- <tr>
		<td id="order_id">Order ID</td>
		<td id="po_No">PO No.</th>
		<td id="dept_name">Dept Name</th>
		<td id="item_list">Items</th>
		<td id="grand_total">Grand Total</th>
		<td id="ord_date">Date</th>
	</tr> -->
	<%while(rs.next()){%>
	<%if(rs.getInt("ord_status")==0){%>
			<tr>
			<td href="show_details.jsp?order_id=<%=rs.getInt("order_id")%>&row_permit=<%=row_permit%>"><%=rs.getInt("order_id")%></td>
			<%-- <td><%=rs.getString("po_No")%></td> --%>
			<%-- <td><%=rs.getString("dept_name")%></td> --%>
			<%-- <%if(permit>4){%>
			<td ><%=rs.getString("full_name")%></td> --%>
			<td ><%=rs.getString("po_No")%></td>
			<td ><%=rs.getString("q_No")%></td>
			<%-- <%}%> --%>
			<td class="hoverclass"><%=rs.getString("item_list")%></td>
			<%String final_total = Float.toString(rs.getFloat("grand_total"))+" "+rs.getString("currency");%>
			<td ><%=final_total%></td>
			<td ><%=rs.getString("ord_vendor")%></td>
			<td ><%=rs.getDate("ord_date")%></td>
			<!-- <td href="login.jsp">Click</td> -->
			<%-- <%if(permit>4){%> --%>
			
			<%-- <%}%> --%>
	   </tr>
	<% }} %>
	</tbody>
	<tfoot>
	<tr>
		<th>Order ID</th>
		<%-- <th>Dept Name</th>
		<%if(permit>4){%>
		<th>Faculty</th> --%>
		<th>PO No.</th>
		<th>Q No.</th>
		<%-- <%}%> --%>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Vendor</th>
		<th>Date</th>
		<%-- <%if(permit>4){%> --%>
		<%-- <%}%> --%>
	</tr>
	</tfoot>
</table>

<%rs.beforeFirst();%>
<h1>Completed Orders</h1><br>
<table id="example3" class="example3" border=0 width=100%>
	<thead>
	<tr>
		<th>Order ID</th>
<%-- 		<th>Dept Name</th>
		<%if(permit>4){%>
		<th>Faculty</th> --%>
		<th>PO No.</th>
		<th>Q No.</th>
		<%-- <%
		row_permit = 2;
		}%> --%>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Vendor</th>
		<th>Date</th>
		<%-- <%if(permit>4){%> --%>
		<th>View PO</th>
		<%-- <%}%> --%>
	</tr>
	</thead>
	<!-- <tr>
            <th><input type="text" data-column="1"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="2"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="3"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="4"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="5"  class="form-control" placeholder="Search"></th>
            <th><input type="text" data-column="6"  class="form-control" placeholder="Search"></th>
        </tr>   -->   
    <tbody>
	<!-- <tr>
	<td colspan=2 align="center"><input type="text" id="order_id" onkeyup="myFunction()" placeholder="Search for id" title="Type in a id"></input></td>
	</tr> -->
	<!-- <tr>
		<td id="order_id">Order ID</td>
		<td id="po_No">PO No.</th>
		<td id="dept_name">Dept Name</th>
		<td id="item_list">Items</th>
		<td id="grand_total">Grand Total</th>
		<td id="ord_date">Date</th>
	</tr> -->
	<%while(rs.next()){%>
	<%if(rs.getInt("ord_status")==2){%>
			<tr>
			<td href="show_details.jsp?order_id=<%=rs.getInt("order_id")%>&row_permit=<%=row_permit%>"><%=rs.getInt("order_id")%></td>
			<%-- <td><%=rs.getString("po_No")%></td> --%>
			<%-- <td><%=rs.getString("dept_name")%></td> --%>
			<%-- <%if(permit>4){%>
			<td ><%=rs.getString("full_name")%></td> --%>
			<td ><%=rs.getString("po_No")%></td>
			<td ><%=rs.getString("q_No")%></td>
			<%-- <%}%> --%>
			<td class="hoverclass"><%=rs.getString("item_list")%></td>
			<%String final_total = Float.toString(rs.getFloat("grand_total"))+" "+rs.getString("currency");%>
			<td ><%=final_total%></td>
			<td ><%=rs.getString("ord_vendor")%></td>
			<td ><%=rs.getDate("ord_date")%></td>
			<!-- <td href="login.jsp">Click</td> -->
			<%-- <%if(permit>4){%> --%>
			<td><a href="call_printer.jsp?order_id=<%=rs.getInt("order_id")%>" target="_blank">View</a></td>
			<%-- <td href="call_printer.jsp?order_id=<%=rs.getInt("order_id")%>" target="_blank">View</td> --%>
			<%-- <%}%> --%>
	   </tr>
	<% }}%>
	</tbody>
	<tfoot>
	<tr>
		<th>Order ID</th>
		<%-- <th>Dept Name</th>
		<%if(permit>4){%>
		<th>Faculty</th> --%>
		<th>PO No.</th>
		<th>Q No.</th>
		<%-- <%}%> --%>
		<th>Items</th>
		<th>Grand Total</th>
		<th>Vendor</th>
		<th>Date</th>
		<%-- <%if(permit>4){%> --%>
		<th>View PO</th>
		<%-- <%}%> --%>
	</tr>
	</tfoot>
</table>


</center>
</body>
</html>