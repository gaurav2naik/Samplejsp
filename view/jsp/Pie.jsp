<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.avekshaa.cis.Java.CPU"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.*"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.avekshaa.cis.Java.COUNT"%>
<%@page import="com.avekshaa.cis.Java.OneHourWeb"%>
<%@page import="com.avekshaa.cis.Java.OneHourAndroid"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>

<script src="http://code.highcharts.com/highcharts-3d.js"></script>


<style>
#container {
	height: 400px;
	min-width: 310px;
	max-width: 800px;
	margin: 0 auto;
}
</style>




<script>
	$(function() {

		$(document)
				.ready(
						function() {

							// Build the chart
							$('#container')
									.highcharts(
											{
												chart : {
													plotBackgroundColor : null,
													plotBorderWidth : null,
													plotShadow : false,
													type : 'pie'
												},
												title : {
													text : 'Total number of hits of Web vs Android users'
												},
												tooltip : {
													pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
												},
												plotOptions : {
													pie : {
														allowPointSelect : true,
														cursor : 'pointer',
														dataLabels : {
															enabled : false
														},
														showInLegend : true
													}
												},
												series : [ {
													name : "Users",
													colorByPoint : true,
													data : [

															{
																name : "Web",
																y :
<%OneHourWeb wc = new OneHourWeb();
			double countWeb = wc.mtd();
			out.println(countWeb);
			//System.out.println("-----count WEB------:" + countWeb);%>
	},

															{
																name : "Android",
																y :
<%OneHourAndroid obj = new OneHourAndroid();
			double ans = obj.mtd();
			out.println(ans);
			//System.out.println("-----count Android----:" + ans);%>
	}

													]
												} ]
											});
						});
	});
</script>

</head>
<body>
	<div id="one">
		<div id="container"
			style="min-width: 310px; max-width: 500px; height: 200px; margin: 0 auto"></div>
	</div>
</body>
</html>