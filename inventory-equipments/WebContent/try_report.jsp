<%@page import="com.itextpdf.layout.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import ="java.sql.*" %>
<%
Document document;
try{
	PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream("HelloWorld.pdf"));
	document.open();
	document.add(new Paragraph("Welcome to pdf"));
	document.close();
}
catch(Exception e){
	e.printStackTrace();
}
	
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