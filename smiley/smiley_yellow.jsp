<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
#smiley {
	position: relative;
	width: 60px;
	height: 60px;
	background-color: #FFFF00;
	border-radius: 100%;
	border: solid #EAC117 3px;
}

#leye {
	position: absolute;
	left: 10px;
	top: 14px;
	width: 3px;
	height: 7px;
	background-color: #EAC117;
	border-radius: 100%;
	border: solid #EAC117 5px;
}

#reye {
	position: absolute;
	right: 10px;
	top: 14px;
	width: 3px;
	height: 7px;
	background-color: #EAC117;
	border-radius: 200%;
	border: solid #EAC117 5px;
}

#mouth {
	position: absolute;
	left: 28%;
	width: 47%;
	height: 2%;
	background-color: #FFFF00;
	border-radius: 100%;
	border-bottom: solid 5px #EAC117;
	/* border-top:solid 5px #EAC117; */
	bottom: 10px;
}
</style>


<body>

	<div id="smiley">
		<div id="leye"></div>
		<div id="reye"></div>
		<div id="mouth"></div>
	</div>

</body>
</html>