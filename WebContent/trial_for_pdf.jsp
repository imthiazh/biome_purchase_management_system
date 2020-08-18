<%@page import="com.itextpdf.text.Paragraph"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.itextpdf.text.Document"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="com.itextpdf.text.Element"%>

<%@page import="com.print_details.Print_details"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<%
Document document = new Document();
PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream("sampleout.pdf"));
document.open();
Paragraph head = new Paragraph("Purchase Order");
head.setAlignment(Element.ALIGN_CENTER);
document.add(head);
document.close();
%>