
<%
	if (session.getAttribute("Role") != null) {
		if (session.getAttribute("Role").equals("CIO")) {
			System.out.println("Inside Login Header-CIO");
			response.sendRedirect("view/jsp/NewWebAndAppDashbord.jsp?role=CIO");
		} else if (session.getAttribute("Role").equals("IT Admin")) {
			System.out.println("Inside Login Header-IT Admin");
			response.sendRedirect("view/jsp/NewWebAndAppDashbord.jsp?role=IT Admin");
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<style>
.image {
	background-image: url("view/image/case-study.png");
}

/* .bdy {
	margin: 10px;
	line-height: 80px;
	height: 80px;
	
}

#div1 {
	height: 20px;
	width: 10%;
	float: left;
	font-size: 24px;
	font-family: MV Boli;
	background-color: #7DB5FF;
	color: #0000FF;
	padding-left: 1%;
}

#div2 {
	font-size: 24px;
	font-family: MV Boli sans-serif monospace;
	background-color: #7DB5FF;
	color: #0000FF;
	height: 20px;
	width: 80%;
	float: right;
	text-align: right;
	padding-right: 3%;
}

.sublogo {
	padding-left: 18px;
	font-size: 14px;
	font-family: MV Boli;
	background-color: #7DB5FF;
	color: #FFFFFF;
} */
.headerTopBorder {
	color: white;
	background-color: #333333;
	border-top-left-radius: 100px;
	border-top-right-radius: 100px;
}

.headerBottomBorder {
	color: white;
	background-color: #333333;
}

.footerTopBorder {
	color: white;
	background-color: #333333;
	border-bottom-left-radius: 0px;
	border-bottom-right-radius: 0px;
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
	font-family: MV Boli sans-serif monospace;
	color: white;
	height: 30px;
	width: 80%;
	float: right;
	text-align: right;
	padding-right: 3%;
}

#div3 {
	height: 30px;
	width: 80%;
	float: right;
	text-align: right;
	padding-right: 3%;
	font-size: 14px;
	font-family: MV Boli;
	padding-bottom: 10px;
	color: #FFFFFF;
}

.sublogo {
	padding-left: 18px;
	font-size: 14px;
	font-family: MV Boli;
	padding-bottom: 10px;
	color: #FFFFFF;
}

#inner {
	height: 47px;
	width: :100%
}
</style>

</head>

<body>
	<div class="headerTopBorder">
		<br>
	</div>

	<div class="image">

		<div class="sublogo">powered by</div>
		<div id="inner">
			<div id="div1">
				<img src="logo.png" style="height: 43px; background-color: white;" />
			</div>
			<div id="div2" align="right">CustExp</div>
			<div id="div3" align="right">Customer Experience</div>
		</div>
		<!-- <div class="sublogo" style="padding-left:86%">Customer Experience</div>  -->
		<div class="footerTopBorder">
			<br>
		</div>

	</div>

	<%-- 	<%@include file="menu.html" %> --%>



</body>
</html>