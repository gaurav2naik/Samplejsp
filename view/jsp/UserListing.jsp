<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import=" com.mongodb.DB"%>
<%@page import=" com.mongodb.DBCollection"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="java.util.List"%>
<%@page import="com.mongodb.DBObject"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Experience | Detail</title>
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link href="../css/treemenu.css" rel="stylesheet" type="text/css" />
<link href="../css/header.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%@include file="Header.jsp"%>

	Client Login Detail

	<%=(String) request.getAttribute("False")%>

	<table border="3" align="center" cellpadding="5" width="300">
		<tr>
			<td>Name :<%=(String) request.getAttribute("name")%>
			</td>
		</tr>
		<tr>
			<td>Password : <%=(String) request.getAttribute("pass")%></td>
		</tr>
		<tr>
			<td>UAID :<%=(String) request.getAttribute("UID")%></td>
		</tr>
	</table>
	<center>
		<a href="view/jsp/ExsistingUsers.jsp"><h4>Existing Users</h4> </a>
	</center>
</body>
</html>