<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles/index.css" />
<title>Cust EXP</title>

<%
	session.invalidate();
	response.sendRedirect("../../index.jsp");
%>

<!-- <SCRIPT>
     parent.close()
     </SCRIPT>
 -->
</head>
<body bgcolor="whitesmoke" id="logout">
	<center>
		<h3>
			You have logged out successfully! Click here to <a
				href="../../index.jsp">Login</a> again.
		</h3>
	</center>

</body>
</html>


