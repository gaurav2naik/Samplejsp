<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.avekshaa.cis.Java.TotalHits48hrs"%>
<%@page import="com.avekshaa.cis.Java.EXMP"%>

<%@page import="com.avekshaa.cis.Java.EX"%>
<%@page import="java.util.Map"%>

<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>

<%@page import="com.avekshaa.cis.Java.OneHourWeb"%>
<%@page import="com.avekshaa.cis.Java.OneHourAndroid"%>

<%@page import="com.avekshaa.cis.Java.AndroidLive"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Experience</title>



<script src="../script/jquery.min.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>



<script>
	$(function() {
		var chart;

		$(function() {
			setInterval(
					function() {
						//var x = 100, // current time
						data = $
								.parseJSON($
										.ajax({
											url : '../../GetDashboardPieChartData?type=responseAcrossDevices',
											dataType : "json",
											async : false
										}).responseText);
						console.log(data);
						chart.series[0].setData(data, true);

					}, 3000);
		});

		// Build the chart
		var chart = new Highcharts.Chart({
			chart : {
				renderTo : 'graph4',
				plotBackgroundColor : null,
				plotBorderWidth : null,
				plotShadow : false,
				type : 'pie'
			},
			title : {
				text : 'Mobile Response-across devices',

				style : {
					fontSize : '15px'
				}

			},

			credits : {
				enabled : false
			},

			exporting : {
				enabled : false
			},

			tooltip : {
				pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
			},
			plotOptions : {
				pie : {
					allowPointSelect : true,
					cursor : 'pointer',
					size : 160,
					dataLabels : {
						enabled : false
					},
					showInLegend : false
				}
			},
			series : [ {
				name : "Browser Share",
				colorByPoint : true,
				data : [ {
					"name" : "HonorChe1-L04",
					"y" : 856
				}, {
					"name" : "motorolaXT1092",
					"y" : 3207
				}, {
					"name" : "HUAWEIHol-U19",
					"y" : 391
				}, {
					"name" : "motorolaXT1033",
					"y" : 2973
				}, {
					"name" : "motorolaXT1022",
					"y" : 982
				}, {
					"name" : "HuaweiH60-L04",
					"y" : 3002
				}, {
					"name" : "SONYZ2",
					"y" : 813
				} ]
			} ]
		});

	});
</script>
</head>
<body>

	<div id="graph4"
		style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>


</body>
</html>