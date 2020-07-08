<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   		<%@ page import="java.sql.*"%>
<%
int user_id = (int)session.getAttribute("user_id");
int dept_id = (int)session.getAttribute("dept_id");
String default_po_No = (String)session.getAttribute("default_po_No");

Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root","");

PreparedStatement pst = conn.prepareStatement("INSERT INTO `order_details`(`user_id`, `po_No`,`ord_status`) VALUES (?,?,?);");
pst.setInt(1,user_id);
pst.setString(2,default_po_No);
pst.setInt(3,0);
pst.executeUpdate();

String redirectURL = "displaydet.jsp";
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