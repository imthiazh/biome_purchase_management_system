<%@ page import="java.sql.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver"); // MySQL database connection
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
			"root", "");
	int dptid = (int)session.getAttribute("id");
	PreparedStatement pst = conn.prepareStatement("SELECT main_budget, add_budget from dept_details where dept_id = ?");
	pst.setInt(1,dptid);
	float main_budget = 0.00f;
	float add_budget = 0.00f;
	ResultSet rs = pst.executeQuery();
	while(rs.next()){
			main_budget =  rs.getFloat(1);
			add_budget =  rs.getFloat(2);
		}
	session.setAttribute("mainbudget", main_budget);
	session.setAttribute("addbudget", add_budget);
	float total_budget = main_budget + add_budget;
	session.setAttribute("totalbudget", total_budget);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script>
	function validate(){
		var x = document.forms["order_form"]["ord_cost"].value;
		var total_budget =  <%= main_budget+add_budget %>
		if(x>total_budget){
			alert("You have exceeded budget !");
			return false;
		}
	}
</script>
<title>Purchase</title>
</head>
<body>
	<center>
		<h1>Purchase Form</h1>
		<form name="order_form" action="record.jsp" onsubmit="return validate()" method="post">
			<h3>Main Budget: <%=main_budget%></h3>
			<h3>Additional 10% Budget: <%=add_budget%></h3>
			<h3>Total Budget: <%=total_budget%></h3>
			<h3><br>Item Name: 
			<input type="text" id="ord_name" name="ord_name" required></input> <br><br>Order
			Date: 
			<input type="date" id="ord_date" name="ord_date" required></input> <br><br>Vendor
			Name: 
			<input type="text" id="ord_vendor" name="ord_vendor" required></input> <br><br>Item
			Cost: 
			<input type="number" id="ord_cost" name="ord_cost" required></input> <br><br>
			</h3>
			<input type="submit" value="Submit" />
		</form>
	</center>
</body>
</html>