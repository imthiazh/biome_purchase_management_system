<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
session.invalidate();
String redirectURL = "login.jsp";
response.sendRedirect(redirectURL);
%>