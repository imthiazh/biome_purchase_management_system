<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<%
int emp_no = Integer.valueOf(request.getParameter("emp_no"));

Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");
/* int emp_no = Integer.valueOf(request.getParameter("user_total_budget")); */
float user_total_budget = Float.valueOf(request.getParameter("user_total_budget"));
float user_main_budget = Float.valueOf(request.getParameter("user_main_budget"));
float user_add_budget = Float.valueOf(request.getParameter("user_add_budget"));
float user_commit = Float.valueOf(request.getParameter("user_commit"));
float user_spent = Float.valueOf(request.getParameter("user_spent"));

PreparedStatement pst = conn.prepareStatement("UPDATE user_details SET user_total_budget=?, main_budget=?, add_budget=?, user_commit=?, user_spent=? WHERE user_id= ? ");
pst.setFloat(1,user_total_budget);
pst.setFloat(2,user_main_budget);
pst.setFloat(3,user_add_budget);
pst.setFloat(4,user_commit);
pst.setFloat(5,user_spent);
pst.setFloat(6,emp_no);
pst.executeUpdate();

String redirectURL = "admin_budget_display.jsp";
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