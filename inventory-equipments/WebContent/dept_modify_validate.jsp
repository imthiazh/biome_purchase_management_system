<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<%
int dept_no = Integer.valueOf(request.getParameter("dept_no"));

Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");
/* int emp_no = Integer.valueOf(request.getParameter("user_total_budget")); */
float dept_total_budget = Float.valueOf(request.getParameter("dept_total_budget"));
float dept_main_budget = Float.valueOf(request.getParameter("dept_main_budget"));
float dept_add_budget = Float.valueOf(request.getParameter("dept_add_budget"));
float dept_commit = Float.valueOf(request.getParameter("dept_commit"));
float dept_spent = Float.valueOf(request.getParameter("dept_spent"));

PreparedStatement pst = conn.prepareStatement("UPDATE dept_details SET dept_total_budget=?, main_budget=?, add_budget=?, dept_commit=?, dept_spent=? WHERE dept_id= ? ");
pst.setFloat(1,dept_total_budget);
pst.setFloat(2,dept_main_budget);
pst.setFloat(3,dept_add_budget);
pst.setFloat(4,dept_commit);
pst.setFloat(5,dept_spent);
pst.setFloat(6,dept_no);
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