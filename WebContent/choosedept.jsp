<%@ page import="java.sql.*"%>
<%
Class.forName("com.mysql.jdbc.Driver"); // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");
ResultSet rs2 = null;
PreparedStatement pst2 = conn.prepareStatement("SELECT MAX(ord_id) FROM order_details");
rs2 = pst2.executeQuery();
rs2.next();
System.out.println(rs2.getInt("MAX(ord_id)"));
%>