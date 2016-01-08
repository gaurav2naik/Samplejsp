<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String role = (String) session.getAttribute("Role");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/button.css">
<script src="../script/jquery.min.js"></script>
<script src="../script/highcharts.js"></script>
<script type="text/javascript">
	function loadFun() {
		$('#graph1').load('../Graph/androidhighlive.jsp');
		$('#graph4').load('../Graph/liveweb.jsp');
		/* $('#graph2').load('DeviceCount.jsp'); */
	}
	var auto_refresh = setInterval(function() {
		loadFun();

	}, 10000);
</script>
<title>Live Monitoring|CIS</title>
</head>
<body onload="loadFun()" id="lm"
	style="font-family: 'Lucida Grande', 'Lucida Sans Unicode', Arial, Helvetica, sans-serif;">
	<%@include file="../Header.jsp"%>
	<%@include file="BranchMenu.jsp"%>

	<br>
	<div id="graph2"
		style="width: 20%; height: 400px; float: left; display: inline-block;">
		<iframe src="DeviceCount.jsp" style="border: 0; height: 100%;"></iframe>
	</div>
	<div id="graph1"
		style="width: 70%; display: inline-block; float: left;"></div>
	<div id="graph3"
		style="width: 20%; height: 400px; float: left; display: inline-block;">
		<!-- <iframe src="DeviceCount.jsp" style="border: 0; height: 100%;"></iframe> -->
	</div>
	<div id="graph4"
		style="width: 70%; display: inline-block; float: left;padding-bottom: 2%"></div>
	
	
	<%@include file="../Footer.jsp"%>
</body>
</html>