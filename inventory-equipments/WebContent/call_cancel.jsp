<%@page import="com.print_details.cancel_po"%>
<%@page import="com.itextpdf.text.Image"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.itextpdf.text.Document"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>

<%@page import="com.print_details.Print_details"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%
int i = Integer.parseInt(request.getParameter("order_id"));

Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
		"root", "");


PreparedStatement pst = conn.prepareStatement("UPDATE `order_details` SET `ord_status`=0 WHERE `order_id`=?");
pst.setInt(1,i);
pst.executeUpdate();


/*int i = 30;*/
int j =i;
cancel_po tc = new cancel_po();
//Document doc = new Document();
Image img = Image.getInstance("him40%.jpg");
Image img2 = Image.getInstance("bartry1.jpg");

System.out.println(tc.main_print(i,img,img2));
Thread.sleep(5000);
//String redirectURL = "\\\\C:\\Users\\Imthiaz\\eclipse-workspace\\inventory-equipments\\WebContent\\test\\HelloWorld12345.pdf";
//String redirectURL = "file:///C:/Users/Imthiaz/eclipse-workspace/inventory-equipments/WebContent/test/HelloWorld12345.pdf";
//String redirectURL = "file://C:/Users/Imthiaz/eclipse-workspace/inventory-equipments/WebContent/test/HelloWorld12345.pdf";
String redirectURL = "test/HelloWorld12345.pdf";
/* String redirectURL = "HelloWorld12345.pdf"; */
response.sendRedirect(redirectURL);
/*if(doc==null)
	System.out.println("It is null no !"); */
//PdfWriter writer = PdfWriter.getInstance(doc,new FileOutputStream("HelloWorld2.pdf"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="displayPDF()">
<script>
/* function displayPDF() {
	alert("Hello page loaded");
	/* location.replace = "test/HelloWorld12345.pdf";*/
	//window.open ("https://www.w3schools.com");
	//location.replace = "C:\Users\Imthiaz\eclipse-workspace\inventory-equipments\WebContent\test\HelloWorld12345.pdf";
/*}*/
</script>
<p>Hello</p>
</body>
</html>