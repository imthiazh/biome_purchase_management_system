<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
		<%@page import="java.sql.ResultSet"%>
		<%@page import="java.sql.Statement"%>
		<%@page import="java.sql.Connection"%>
		<%@page import="java.text.*"%>
		<%@ page import="java.sql.*"%>
<%
Class.forName("com.mysql.jdbc.Driver"); // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");
int order_id = Integer.parseInt(request.getParameter("order_id"));
int row_permit = Integer.parseInt(request.getParameter("row_permit"));


ResultSet rs= null;
/* PreparedStatement pst = conn.prepareStatement("SELECT `order_details`.order_id, `dept_details`.dept_name, `user_details`.full_name, `order_details`.po_No, `order_details`.q_No, `order_details`.order_no, `order_details`.ord_date, `order_details`.ord_vendor FROM `order_details`,`user_details`,`dept_details` WHERE order_details.user_id=user_details.user_id AND user_details.dept_id=dept_details.dept_id AND order_details.order_id=?"); */
PreparedStatement pst = conn.prepareStatement("SELECT `order_details`.order_id, `dept_details`.dept_name, `dept_details`.dept_id, `user_details`.full_name, `order_details`.po_No, `order_details`.q_No, `order_details`.item_list, `order_details`.grand_total, `order_details`.currency, `order_details`.ord_date, `order_details`.ord_vendor FROM `order_details`,`user_details`,`dept_details` WHERE order_details.user_id=user_details.user_id AND user_details.dept_id=dept_details.dept_id AND order_id = ?");
pst.setInt(1,Integer.parseInt(request.getParameter("order_id")));
rs = pst.executeQuery();
rs.next();

ResultSet rs_count= null;
PreparedStatement pst2 = conn.prepareStatement("SELECT COUNT(*) FROM add_order_details WHERE order_id = ?");
pst2.setInt(1,Integer.parseInt(request.getParameter("order_id")));
rs_count = pst2.executeQuery();
rs_count.next();
int cnt = rs_count.getInt("COUNT(*)");


ResultSet rs_adddata = null;
PreparedStatement pst_adddata = conn.prepareStatement("SELECT item_name, rate, quantity, unit, cost FROM add_order_details WHERE order_id = ?");
pst_adddata.setInt(1,Integer.parseInt(request.getParameter("order_id")));
rs_adddata = pst_adddata.executeQuery();
//rs_adddata.next();


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script>
window.onload = function(){
	//addFields();
}
</script>


<style>
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
body{
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
}
table {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

table td, table th {
  border: 1px solid #ddd;
  padding: 8px;
}

table tr:nth-child(even){background-color: #f2f2f2;}

table tr:hover {background-color: #ddd;}

table th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: center;
  background-color: #4CAF50;
  color: white;
}
th:hover{
     cursor:pointer;
    background:#AAA;
}
input{
  width: 60%;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
  border: 3px solid #ccc;
  -webkit-transition: 0.5s;
  transition: 0.5s;
  outline: none;
}
input:focus {
  border: 3px solid #555;
}

</style>


</head>
<body>
<script>
<%-- function addFields(){
number = <%=cnt%>;
/*var container1 = document.getElementById("container1");
while (container1.hasChildNodes()) {
    container1.removeChild(container1.lastChild);
}*/
var container2 = document.getElementById("container2");
while (container2.hasChildNodes()) {
    container2.removeChild(container2.lastChild);
}
for (i=0;i<number;i++){
	container2.appendChild(document.createTextNode("Item " + (i+1)+" :"));
    //container1.appendChild(document.createTextNode("Item Name " + (i+1)));
    var input = document.createElement("input");
    input.type = "text";
    //input.class="small_size";
    var curr = i+1;
    var cur = curr.toString(10);
    var item_name = "item_name_";
    var item_name_rd = "Item Name";
    var assign = item_name.concat(cur);
    var assign_rd = item_name_rd;
    input.id = assign;
    input.name = assign;
    
    //input.value="<%=rs_adddata.getString("item_name")%>";
    input.placeholder = assign_rd;
    input.readOnly=true;
    document.getElementById(assign).value="<%=rs_adddata.getString("item_name")%>";
    container2.appendChild(input);
    //make_readonly(assign);
    //container1.appendChild(document.createElement("br"));
    //container1.appendChild(document.createElement("br"));
    //container1.appendChild(document.createElement("br"));
    //container2.appendChild(document.createElement("br"));
    
    var input2 = document.createElement("input");
    input2.type = "number";
    //input.class="small_size";
    var curr = i+1;
    var cur = curr.toString(10);
    var quantity = "quantity_";
    var quantity_rd = "Quantity";
    var assign = quantity.concat(cur);
    var assign_rd = quantity_rd;
    input2.id = assign;
    input2.name = assign;
    input2.placeholder = assign_rd;
    input2.readOnly=true;
    container2.appendChild(input2);
    //document.getElementById(assign).readonly = true;
    
    var input4 = document.createElement("input");
    input4.type = "text";
    //input.class="small_size";
    var curr = i+1;
    var cur = curr.toString(10);
    var unit = "unit_";
    var unit_rd = "Measuring Units";
    var assign = unit.concat(cur);
    //var assign_rd = unit_rd.concat(cur);
    input4.id = assign;
    input4.name = assign;
    input4.placeholder = unit_rd;
    input4.readOnly=true;
    container2.appendChild(input4);
    
    //container1.appendChild(document.createTextNode("Rate of Item " + (i+1)));
    var input3 = document.createElement("input");
    input3.type = "number";
    //input.class="small_size";
    var curr = i+1;
    var cur = curr.toString(10);
    var rate = "rate_";
    var rate_rd = "Rate";
    var assign = rate.concat(cur);
    var assign_rd = rate_rd;
    input3.id = assign;
    input3.name = assign;
    input3.placeholder = assign_rd;
    input3.readOnly=true;
    container2.appendChild(input3);
    /* container1.appendChild(document.createElement("br"));
    container1.appendChild(document.createElement("br"));
    container1.appendChild(document.createElement("br")); */
  
    
    var input5 = document.createElement("input");
    input5.type = "number";
    //input.class="small_size";
    var curr = i+1;
    var cur = curr.toString(10);
    var cost = "cost_";
    var cost_rd = "Cost";
    var assign = cost.concat(cur);
    //var assign_rd = unit_rd.concat(cur);
    input5.id = assign;
    input5.name = assign;
    input5.placeholder = cost_rd;
    //float q = document.getElementById("quantity_"+i+1);
    //float r = document.getElementById("rate_"+i+1);
    //input5.value = q*r;
    input5.readOnly=true;
    container2.appendChild(input5);
    
    
    container2.appendChild(document.createElement("br"));
    <%=rs_adddata.next()%>
}
container2.appendChild(document.createElement("br"));
var input_submit = document.createElement("input");
input_submit.type = "submit";
input_submit.value = "Submit";
container2.appendChild(input_submit);
} --%>
/* function make_readonly(var id) {
	  document.getElementById(id).readOnly = true;
} */
</script>
<script>
function make_readonly(var id){
	  document.getElementById(id).readOnly = true;
}
</script>

<center><br><br>
	<!-- <b>---- Available Funds ----</b><br></br>
	<b>Main Budget: <<//(float)main_budget%>>  &emsp;      
			Additional 10% Budget: <<=//(float)add_budget%>>&emsp;
			Total Budget: <<=//(float)total_budget%>&emsp;</b>
			<br><br><br> -->
		<div class="class1_div">
		<br>
		<form name="display_form" action="" onsubmit="" method="get" onload="alertfn();" >
		
		<table border="1">
		<tr>
		<th colspan=2 align=center>
			<h1>Order Details</h1>
		</th>
		</tr>
		<tr>
			<td><b>Order ID:</b></td>
			<td><input type="text" id="order_id" name="order_id" value="<%=rs.getInt("order_id")%>" readonly></input></td>
		</tr>
		<tr>
			<td><b>Dept. Name:</b></td> 
			<td><input type="text" id="dept_name" name="dept_name" value="<%=rs.getString("dept_name")%>" readonly></input></td>
		</tr>
		<%if(row_permit>=2){%>
		<tr>
			<td><b>Faculty:</b></td> 
			<td><input type="text" id="full_name" name="full_name" value="<%=rs.getString("full_name")%>" readonly></input></td>
		</tr>
		<tr>
			<td><b>PO No.:</b></td> 
			<td><input type="text" id="po_No" name="po_No" value="<%=rs.getString("po_No")%>" readonly></input></td>
		</tr>
		<tr>
			<td><b>Quotation No.:</b></td> 
			<td><input type="text" id="q_No" name="q_No" value="<%=rs.getString("q_No")%>" readonly></input></td>
		</tr>
		<%}%>
		<tr>
			<td><b>Vendor Name:</b></td> 
			<td><input type="text" id="ord_vendor" name="ord_vendor" value="<%=rs.getString("ord_vendor")%>" readonly></input></td>
		</tr>
		<tr>
			<td><b>Order Date:</b></td>
			<td><input type="text" id="ord_date" name="ord_date" value="<%=rs.getDate("ord_date")%>" readonly></input></td>
		</tr>
		<tr>
		<th colspan=2 align=center>
			<h2>Item Details</h2>
		</th>
		</tr>
		<tr>
		<td colspan=2 align=center>
			<table border=1>
			<thead>
				<tr>
					<th>Item Name</th>
					<th>Quantity</th>
					<th>Unit</th>
					<th>Rate</th>
					<th>Cost</th>
				</tr>
			</thead>
			<tbody>
				<%while(rs_adddata.next()){%>
					<tr>
					<td><%=rs_adddata.getString("item_name")%></td>
					<td><%=rs_adddata.getFloat("quantity")%></td>
					<td><%=rs_adddata.getString("unit")%></td>
					<td><%=rs_adddata.getFloat("rate")%></td>
					<%String final_total = Float.toString(rs_adddata.getFloat("cost"))+" "+rs.getString("currency");%>
					<td><%=final_total%></td>
			   		</tr>
				<% } %>
			</tbody>
			</table>
		</td>
		</tr>
		<tr>
			<td>Grand Total : </td>
			<td  colspan=2 align=right><input type="text" id="grand_total" name="grand_total" value="<%=rs.getFloat("grand_total")%>" readonly></td>
		</tr>
		
		<!-- <tr>
			<td><b>PO Number:</b></td> 
			<td><input class="large_size" type="text" id="po_No" name="po_No" required></input></td>
		</tr>
		<tr>
			<td><b>Quotation No.:</b></td> 
			<td><input type="text" class="large_size" id="q_No" name="q_No" required></input></td>
		</tr>
		
		<tr>
			<td><b>Order No.:</b></td> 
			<td><input type="text" class="large_size" id="order_no" name="order_no" required></input></td>
		</tr>
		
		<tr>
			<td><b>Order Date:</b></td> 
			<td><input type="date" class="large_size" id="ord_date" name="ord_date" required></input></td>
		</tr>
		
		<tr>
			<td><b>Vendor Name:</b></td> 
			<td><input type="text" class="large_size" id="ord_vendor" name="ord_vendor" required></input></td>
		</tr> -->
		</table>
		</form>
		</div>
</body>
</html>