<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver"); // MySQL database connection
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
			"root", "");
	int user_id = (int)session.getAttribute("user_id");
	String pass = request.getParameter("pass_new_1");
	
	
	PreparedStatement pst = conn.prepareStatement("UPDATE user_details SET pass = ? WHERE user_id = ?");
	pst.setString(1,pass);
	pst.setInt(2,user_id);
	int rsa = pst.executeUpdate();
	
	String redirectURL = "displaydet.jsp";
	response.sendRedirect(redirectURL);
	//out.println(pass);
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