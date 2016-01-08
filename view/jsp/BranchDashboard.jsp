<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="loading">
<head>
<title>Branch Dashboard|CIS</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="../script/jquery.js"></script>
<script src="../script/jquery.min.js"></script>

<script src="../script//highcharts.js"></script>
<script src="../script/exporting.js"></script>
<script src="../script/in-all-disputed.js"></script>
<script src="../script/highmaps.js"></script>

<!-- <script src="https://code.highcharts.com/maps/modules/exporting.js"></script> -->
<style type="text/css">
.myButton {
	margin-top: 0%;
	padding-top: 0%;
	margin-bottom: 0%;
	padding-bottom: 0%;
	background-color: white;
	text-decoration: none;
	border-bottom: 4px solid lightblue;
	cursor: pointer;
	color: black;
	font-family: Arial;
	font-size: 17px;
	/* 	font-weight:bold; */
	text-decoration: none;
}

.myButton:hover {
	color: #1691D8;
	border-bottom: 4px solid black;
}

#active {
	position: relative;
	top: 0;
}

.abd:hover {
	border-bottom-color: 4px solid black;
}
</style>

<script>
		function showDiv(option) {

			$('.cssload-container').hide();

		}
</script>

<link rel="stylesheet" type="text/css" href="../css/index.css" />
<script type="text/javascript" src="../script/styleswitcher.js"></script>

<link rel="stylesheet" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />
<link rel="stylesheet" type="text/css" href="../css/loading.css">

</head>
<body id="bd" onload="showDiv()">

	<%@include file="Header.jsp"%>
	<%@include file="BranchMenu.jsp"%>
	<div style="margin-top: 2%; width: 100%;">
		<div class="abd"
			style="width: 10%; display: inline; border-right: 1px solid black; padding-right: 1%; padding-left: 1%;"
			id="1daysdata">
			<a id="1d" href="#" title="" class="myButton" style="color: #1691D8;"
				page="BranchOneDay.jsp">1 Day</a>
		</div>
		<div class="abd"
			style="width: 10%; display: inline; border-right: 1px solid black; padding-right: 1%; padding-left: 1%;">
			<a id="2d" href="#" title="" class="myButton" page="BranchSevenDay.jsp">1
				Week</a>
		</div>
		<div class="abd"
			style="width: 10%; display: inline; padding-left: 1%; color: #1691D8;">
			<a href="#" title="" class="myButton" page="BranchThirtyDay.jsp" id="3d"
				>1 Month</a>
		</div>
		<!-- <div  style = " margin-left : 22%;  width : 20%; display : inline; font-size : 12px; font-weight : bold;  text-align : right;" >Total Number of hits</div> 
	<div id = "abd" style = "  width : 20%; font-size : 12px; font-weight : bold; display : inline; float : right; text-align : right; padding-right : 30px;">Avg Response Time(ms)</div> -->
	</div>

	
	<div class="cssload-container">
		<div class="cssload-whirlpool"></div>
	</div>
	

<div  style = " width : 100%; " >
		<!-- <div style = " float : left; width: 60px;  text-align : center; height: 60px; border-radius: 60px;  margin-left: 40%;    background-color : #1691D8;"><p style="  text-align : center ; padding-top : 6px;  " >5</p></div>
	<div style = "float : right; margin-left : 35%; text-align : center;  width: 60px; height: 60px; border-radius: 60px; background-color : #1691D8; margin-right : 5%;"><p style="  text-align : center; padding-top : 6px;">1000</p></div> -->
	
	<div id="loader"><%@include file="BranchOneDay.jsp"%></div>
	</div>
	<%@include file="Footer.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {
			//alert("hhh");
			//$("#loader").load("OneDay.jsp");
			$("#1d").css("border-bottom-color", "black");
			$(".myButton").on("click", function() {
				
				$(".myButton").css("color", "black");
				//$(".myButton").css("border-bottom-color", "lightblue");
				//$(this).css("border-bottom", " 4px solid black");
				$(this).css("color", "#1691D8");
				$(".myButton").css("border-color", "lightblue");
				$(this).css("border-bottom-color", "black");
				//$("#1b").fadeIn("slow");
				$("#loader").empty();
				$('.cssload-container').show();
				$("#loader").load($(this).attr("page"));
				//$('#1b').fadeIn('slow').delay(2500).hide(0);
				return false;

			});
		});
	</script>
</body>
</html>