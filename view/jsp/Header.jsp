<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.avekshaa.cis.login.UserBean"%>
<%System.out.println("Role :"+session.getAttribute("Role"));
	if (session.getAttribute("UN") == null
			|| session.getAttribute("UN").equals("")||session.getAttribute("Role")==null||session.getAttribute("Role")=="") {
		System.out.println("Header After Login case: user Null");
		response.sendRedirect("../../index.jsp?err=You are not Logged In!!!");

	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="../image/title.png" type="image/png">

<style>
.image {
	background-image: url("../image/case-study.png");
	background-size: cover;
}

.headerTopBorder {
	color: white;
	background-color: #333333;
	border-top-left-radius: 100px;
	border-top-right-radius: 100px;
	text-align: right;
	font-family: MV Boli sans-serif monospace;
}

.headerBottomBorder {
	color: white;
	background-color: #333333;
}

.footerTopBorder {
	/*  color: white;
    height : 27px;
	background-color: #333333;
	border-bottom-left-radius: 100px;
	border-bottom-right-radius: 100px; */
	
}

.left {
	float: left;
	width: 50%;
}

.right {
	float: right;
	width: 50%;
}

#div1 {
	height: 20px;
	width: 10%;
	float: left;
	font-size: 24px;
	font-family: MV Boli;
	color: #0000FF;
	padding-left: 1%;
}

#div2 {
	font-size: 20px;
	font-weight: bold;
	font-family: MV Boli sans-serif monospace;
	color: #ffffff;
	height: 30px;
	width: 80%;
	float: right;
	text-align: right;
	padding-right: 2%;
}

.sublogo {
	padding-left: 18px;
	font-size: 14px;
	font-family: MV Boli;
	padding-bottom: 5px;
	color: #FFFFFF;
}
</style>

</head>

<body>
	<div class="headerTopBorder">
		<b>Welcome <%
			out.print(session.getAttribute("UN"));
		%>&nbsp;&nbsp;|&nbsp;&nbsp; <span style="padding-right: 2%"> <%
 	out.print(session.getAttribute("Role"));
 %>
		</span></b>
	</div>

	<div class="image">

		<div class="sublogo">powered by</div>
		<div>
			<div id="div1">
				<img src="../image/logo.png"
					style="height: 35px; background-color: white; padding: 5px; width: 100%" />
			</div>

			<div id="div2">CustExp</div>
		</div>
		<div class="sublogo" style="padding-left: 85%">
			<center>Customer Experience</center>
		</div>
		<div style="float: right; margin-top: 0%;"></div>
		<div class="footerTopBorder"></div>

	</div>




</body>
</html>