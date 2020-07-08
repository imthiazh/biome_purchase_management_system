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
int j =i;
Print_details tc = new Print_details ();
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
	/* location.replace = "test/HelloWorld12345.pdf"; */
	//window.open("https://www.w3schools.com");
	//location.replace = "C:\Users\Imthiaz\eclipse-workspace\inventory-equipments\WebContent\test\HelloWorld12345.pdf";
}*/
</script>
<p>Hello</p>
</body>
</html>