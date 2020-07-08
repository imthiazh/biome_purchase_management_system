<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<% 
Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");

int dept_id = (int)session.getAttribute("dept_id");
int user_id = (int)session.getAttribute("user_id");
int order_id = (int)session.getAttribute("order_id");

PreparedStatement pst = conn.prepareStatement("SELECT user_details.dept_id, user_details.pass, user_details.user_code, dept_details.dept_code, dept_details.dept_total_budget,dept_details.add_budget AS dept_add_budget ,dept_details.main_budget AS dept_main_budget,dept_details.dept_commit,dept_details.dept_spent, user_details.full_name, user_details.username, user_details.permit, user_details.main_budget, user_details.add_budget, user_details.user_total_budget,user_details.user_commit,user_details.user_spent, user_details.user_id from user_details, dept_details where user_details.user_id=? and user_details.dept_id = dept_details.dept_id");
pst.setInt(1,user_id);
ResultSet rs = pst.executeQuery();
rs.next();

float dept_total_budget = 0.00f;
float dept_main_budget = 0.00f;
float dept_add_budget = 0.00f;
float dept_commit = 0.00f;
float dept_spent = 0.00f;

float user_total_budget = 0.00f;
float main_budget = 0.00f;
float add_budget = 0.00f;
float user_commit = 0.00f;
float user_spent = 0.00f;

dept_total_budget = rs.getFloat("dept_total_budget");
dept_main_budget = rs.getFloat("dept_main_budget");
dept_add_budget = rs.getFloat("dept_add_budget");
dept_commit = rs.getFloat("dept_commit");
dept_spent = rs.getFloat("dept_spent");

user_total_budget = rs.getFloat("user_total_budget");
main_budget = rs.getFloat("main_budget");
add_budget = rs.getFloat("add_budget");
user_commit = rs.getFloat("user_commit");
user_spent = rs.getFloat("user_spent");


String payment_type = request.getParameter("payment_type");

float grand_total = Float.parseFloat(request.getParameter("grand_total"));
PreparedStatement pstupdate = conn.prepareStatement("UPDATE `order_details` SET `payment_type`=?,`payment_amount`=? WHERE `order_id`=? ");
pstupdate.setString(1,payment_type);
/* pst.setFloat(2,payment_amount); */
pstupdate.setFloat(2,grand_total);
pstupdate.setInt(3,order_id);
pstupdate.executeUpdate();



float mainbudget = rs.getFloat("main_budget");
float addbudget = rs.getFloat("add_budget");
float totalbudget = mainbudget + addbudget;

float diff = mainbudget-grand_total;

float bigdiff = addbudget-(grand_total-mainbudget);
float lessdiff = addbudget - grand_total;
if(diff>=0){
	PreparedStatement pst2 = conn.prepareStatement("UPDATE `user_details` SET `main_budget`=? WHERE user_id=?");
	pst2.setFloat(1,diff);
	pst2.setInt(2,user_id);
	pst2.executeUpdate();
}
else if(bigdiff>0){
	PreparedStatement pst6 = conn.prepareStatement("UPDATE `user_details` SET `main_budget`=?,`add_budget`=? WHERE user_id=?");
	pst6.setFloat(1,0.0f);
	pst6.setFloat(2,bigdiff);
	pst6.setInt(3,user_id);
	pst6.executeUpdate();
}
else if(mainbudget==0 && lessdiff>=0)
{
	PreparedStatement pst4 = conn.prepareStatement("UPDATE `user_details` SET `add_budget`=? WHERE user_id=?");
	pst4.setFloat(1,lessdiff);
	pst4.setInt(2,user_id);
	pst4.executeUpdate();
}
else if(grand_total==totalbudget)
{
	PreparedStatement pst5 = conn.prepareStatement("UPDATE `user_details` SET `main_budget`=0.00,`add_budget`=0.00 WHERE user_id=?");
	pst5.setInt(1,user_id);
	pst5.executeUpdate();
}

user_commit += grand_total;
//dept_commit += grand_total;

PreparedStatement pst_user_commit_update = conn.prepareStatement("UPDATE user_details SET user_commit=? WHERE user_id = ?");
pst_user_commit_update.setFloat(1,user_commit);
pst_user_commit_update.setInt(2,user_id);
pst_user_commit_update.executeUpdate();

/* PreparedStatement pst_dept_commit_update = conn.prepareStatement("UPDATE dept_details SET dept_commit=? WHERE dept_id = ?");
pst_dept_commit_update.setFloat(1,dept_commit);
pst_dept_commit_update.setInt(2,dept_id);
pst_dept_commit_update.executeUpdate(); */

/*float deptmainbudget = rs.getFloat("dept_main_budget");
float deptaddbudget = rs.getFloat("add_budget");
float depttotalbudget = deptmainbudget + deptaddbudget;

diff = deptmainbudget-grand_total;

bigdiff = deptaddbudget-(grand_total-deptmainbudget);
lessdiff = deptaddbudget - grand_total;
if(diff>=0){
	PreparedStatement pst12 = conn.prepareStatement("UPDATE `dept_details` SET `main_budget`=? WHERE dept_id=?");
	pst12.setFloat(1,diff);
	pst12.setInt(2,dept_id);
	pst12.executeUpdate();
}
else if(bigdiff>0){
	PreparedStatement pst16 = conn.prepareStatement("UPDATE `dept_details` SET `main_budget`=?,`add_budget`=? WHERE dept_id=?");
	pst16.setFloat(1,0.0f);
	pst16.setFloat(2,bigdiff);
	pst16.setInt(3,dept_id);
	pst16.executeUpdate();
}
else if(deptmainbudget==0 && lessdiff>=0)
{
	PreparedStatement pst14 = conn.prepareStatement("UPDATE `dept_details` SET `add_budget`=? WHERE dept_id=?");
	pst14.setFloat(1,lessdiff);
	pst14.setInt(2,dept_id);
	pst14.executeUpdate();
}
else if(grand_total==totalbudget)
{
			PreparedStatement pst15 = conn.prepareStatement("UPDATE `dept_details` SET `main_budget`=0.00,`add_budget`=0.00 WHERE dept_id=?");
pst15.setInt(1,dept_id);
	pst15.executeUpdate();
}*/


String redirectURL = "call_printer.jsp?order_id="+String.valueOf(order_id);
response.sendRedirect(redirectURL);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>