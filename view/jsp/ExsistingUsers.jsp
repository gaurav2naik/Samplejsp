<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String role = (String) session.getAttribute("Role");
%>
<%@page import="java.util.*"%>
<%@page import="com.avekshaa.cis.login.ExistingUsers"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Experience | Existing User</title>
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link href="../css/treemenu.css" rel="stylesheet" type="text/css" />
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/button.css">
<style>
</style>
</head>

<body>
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>

	<%
		ArrayList<String> list = ExistingUsers.name();
	%>

	<div id="listing"
		style="margin-left: 25%; margin-right: 25%; margin-top: 10%;">
		<form action="../../DeleteServlet" method="get">
			<!-- <form name="passGeneration" action="../../CreateUserServlet"
		method="post"> -->

			<table align="center" bgcolor="#99ccff" title="Existing User"
				border="4" bordercolor="black" align="center" cellpadding="6"
				width="300">
				<%
					for (int i = 0; i < list.size(); i++) {
				%>
				<tr>
					<td><%=list.get(i)%></td>

					<td><input type="checkbox" name="user"
						value="<%=list.get(i)%>"></td>
				</tr>
				<%
					}
				%>
			</table>
			<br> <br>
			<center>
				<input type="submit" name="Delete" value="Delete">
			</center>
		</form>
	</div>
	<!-- <center><a href='DeletionForm.jsp'><h4>Delete User</h4> </a></center> -->
	<center>
		<a href="AdminForm.jsp"><h4>Create User</h4></a>
	</center>
	<center>
		<a href="newdashboard.jsp"><h4>Graph Dashboard</h4></a>
	</center>
	<center>
		<a href="ConfigThreshold.jsp"><h4>Threshold Configuration</h4></a>
	</center>
	<center>
		<a href="Duration.jsp"><h4>Quartz configuration</h4></a>
	</center>

</body>
</html>