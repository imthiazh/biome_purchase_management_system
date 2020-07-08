<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<% 
		Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
		Connection conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
				"root", "");
        
        int order_id = (int)session.getAttribute("order_id");
        int dept_id = (int)session.getAttribute("dept_id");
        int user_id = (int)session.getAttribute("user_id");
        float grand_total = (float)session.getAttribute("grand_total");
        String currency = (String)session.getAttribute("currency");
        System.out.println("Currency is :");
        System.out.println(currency);
        
        ResultSet rs_adddata = null;
        PreparedStatement pst_adddata = conn.prepareStatement("SELECT item_name, rate, quantity, unit, cost FROM add_order_details WHERE order_id = ?");
        pst_adddata.setInt(1,order_id);
        rs_adddata = pst_adddata.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script>
function get_amount(){
	var grand_total = <%=grand_total%>;
	var payment_type = document.getElementById('payment_type').value;
	var payment_amount;
	if(payment_type=="NTD"||payment_type=="COD")
	{
		payment_amount = 0;
	}
	else if(payment_type=="LC")
	{
		payment_amount = (0.90)*grand_total;
	}
	else if(payment_type=="ADV")
	{
		payment_amount = grand_total;
	}
	document.getElementById('payment_amount').value=payment_amount;
}//document.getElementById('grand_total').value
</script>
<style>
body{
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
}
.class1_div {
  width: 80%;
  border-radius: 5px;
  border-color: green;
  background-color: #E0E0E0;
  padding: 5px;
}
table
{
	width: 100%;
}
form {
	width: 100%;
}
input {
  width: 50%;
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
.large_size{
	width: 70%;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
  border: 3px solid #ccc;
  -webkit-transition: 0.5s;
  transition: 0.5s;
  outline: none;
}

input[type=submit]{
	width: 14.5%;
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
  align:
}
.currency
{
	width: 20%;
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
table {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  /* border-collapse: collapse; */
  width: 100%;
  /* table-layout:fixed; */ 
}

table  border: 1px solid #ddd;
  padding: 0px;
  overflow: hidden;
  /* white-space: nowrap; */
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

table td {
  padding-top: 9px;
  padding-bottom: 9px;
}
th:hover{
     cursor:pointer;
    background:#AAA;
}
.insidet{
  border-collapse: collapse;
  border-color: #4CAF50;
}
a.homepage {
    -webkit-appearance: button;
    -moz-appearance: button;
    appearance: button;
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
    text-decoration: none;
    color: white;
}
.gen_po{
	width: 30%;
	color: red;
}
</style>
</head>
<body>
<center>
<div class="class1_div">
<form name="payment_form" action="payment_validate.jsp" method="get">
		<table border="0" width=100%>
		<tr>
		<th colspan=2 align=center>
			<h1>Payment</h1>
		</th>
		<tr>
			<td><b>Order ID:</b></td> 
			<td><input type="number" id="order_id" name="order_id" value=<%=order_id%> readonly></input></td>
		</tr>
		<tr>
		<td colspan=2 align=center>
			<table border=5 class="insidet">
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
					<%String final_total = Float.toString(rs_adddata.getFloat("cost"))+" "+currency;%>
					<td><%=final_total%></td>
			   		</tr>
				<% } %>
			</tbody>
			</table>
		</td>
		</tr>
		<tr>
			<td><b>Grand Total:</b></td> 
			<td><input type="number" id="grand_total" name="grand_total" value=<%=grand_total%> readonly/>
			<input type="text" class="currency" id="currency" name="currency" value=<%=currency%> readonly/>
			</td>
		</tr>
		<tr>
			<td><b>Payment Method:</b></td> 
			<td><select id="payment_type" name="payment_type" onChange="get_amount()">
				  <option value="NTD">Net 30 Days [NTD]</option>
				  <option value="COD">Cash on Delivery [COD]</option>
				  <option value="LC">Letter of Credit [LC]</option>
				  <option value="ADV">Advance Payment [ADV]</option>
			</select></td>
		</tr>
		<%-- <tr>
			<td><b>Amount to be paid currently:</b></td> 
			<td><input type="number" id="payment_amount" name="payment_amount" readonly/>
			<input type="text" class="currency" id="currency" name="currency" value=<%=currency%> readonly/>
			</td>
		</tr> --%>
		<tr>
			<td colspan=2 align=center><input class="gen_po" type="submit" value="Generate PO" readonly></input></td>
		</tr>
		<tr>
		<td colspan=2 align=center>
			<a href="displaydet.jsp" class="homepage">Home Page</a>
		</td>
			<!-- <td colspan=2 align=center><input type="submit" value="Home Page" readonly></input></td> -->
		</tr>
		</table>
</form>
</div>
</center>
</body>
</html>