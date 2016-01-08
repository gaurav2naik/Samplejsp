<%@page import="com.avekshaa.cis.jio.GetChartData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%
	if (session.getAttribute("Role") != null) {
		if (session.getAttribute("Role").equals("CIO")) {
	response.sendRedirect("newdashboard.jsp?role=CIO");
		}
	}
%> --%>
<%@page import="com.avekshaa.cis.Java.DistinctUser"%>
<%@page import="com.avekshaa.cis.Java.WebResponseCount"%>
<%@page import="com.avekshaa.cis.Java.AndroidResponseCount"%>
<%@page import="com.avekshaa.cis.Java.CpuPercentLineGraph"%>
<%@page import="com.avekshaa.cis.Java.DurationBar"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.avekshaa.cis.Java.Live"%>
<%@page import="com.avekshaa.cis.Java.Incident"%>
<%@page import="com.avekshaa.cis.Java.CPU"%>
<%@page import="com.avekshaa.cis.Java.Perc"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.avekshaa.cis.Java.OneHourWeb"%>
<%@page import="com.avekshaa.cis.Java.OneHourAndroid"%>
<%@page import="com.avekshaa.cis.Java.AndroidLive"%>
<%
	String role = (String)session.getAttribute("Role");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Streaming Insights|CIS</title>
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/button.css">
<!-- <link href="../css/index.css" rel="stylesheet" type="text/css" /> -->
<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>



<link rel="stylesheet" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />



<style>
html, body {
	height: 100%;
	margin: 0;
}

body {
	position: relative;
	background-color: white;
	background-size: 150%;
	background-repeat: repeat;
	font-family: 'Lato', Arial, sans-serif;
	color: #000000;
}

#container {
	height: 100%;
	width: 100%;
}

#graph4 {
	height: 65%;
	width: 45%;
	background-color: white;
	color: white;
	margin-left: 4%;
	/*    position: relative;  */
	float: left;
	margin-top: 26%;
	/* border-style: solid;
	border-width: medium;
	border-color: black; */
	position: absolute;
	float: left;
}

#graph5 {
	height: 65%;
	width: 45%;
	background-color: white;
	color: white;
	margin-left: 51%;
	/*    position: relative;  */
	float: left;
	margin-top: 1%;
	/* border-style: solid;
	border-width: medium;
	border-color: yellow; */
	position: relative;
	border: 0px;
}

#graph1 {
	height: 45%;
	width: 30%;
	background: white;
	color: white;
	margin-left: 4%;
	margin-top: 2%;
	float: left;
	/*  margin-right: 1%; */
	/* border-style: solid;
	border-width: medium;
	border-color: yellow;*/
	background-color: white;
	position: relative;
}

#graph2 {
	height: 45%;
	width: 30%;
	background: white;
	color: white;
	margin-left: 35%;
	margin-top: 2%;
	float: left;
	/* margin-right: 1%; */
	/* border-style: solid;
	border-width: medium;
	border-color: yellow; */
	background-color: white;
	position: absolute;
}

#graph3 {
	height: 45%;
	width: 30%;
	background: white;
	color: white;
	margin-left: 31.5%;
	margin-top: 2%;
	float: left;
	/* margin-right: 1%; */
	/* border-style: solid;
	border-width: medium;
	border-color: yellow; */
	background-color: white;
	position: relative;
}
</style>
<script type="text/javascript">
	function loadGraph() {
		/* $('#graph').load('../Graph/androidhighlive.jsp');
		$('#graph').load('../Graph/livehighthreshold.jsp'); */

		loadResponseAcrossDevices();
		loadResponseAcrossDevices1()
		loadHitsCount();
	}
</script>


<script>
	//Graph: Dynamic web vs mobile hits count in last hour
	function loadHitsCount() {

		var chart;
 	$(function() {
			setInterval(function() {
				//var x = 100, // current time
				var data = $.parseJSON($.ajax({
					url : '../../GetPieChartData?type=hitsCount',
					dataType : "json",
					async : false
				}).responseText);

				var y = data.y;
				//var x = data.x;
				if (y == 0) {
					chart.setTitle(null, {
						text : 'No Data',
						style : {
							fontSize : '20px',
						}

					});
				} else {
					/* chart.setTitle(null, {
						text : 'Web=' + y + ' Mobile=' + x
					}); */
				}
				chart.series[0].setData(data, true);

			}, 2000);
		}); 
		var chart = new Highcharts.Chart(
				{

					chart : {
						renderTo : 'graph3',
						type : 'pie',
						plotBackgroundColor : null,
						plotBackgroundImage : null,
						plotBorderWidth : 0,
						plotShadow : false
					},
					exporting : {
						enabled : false
					},
					title : {
						text : 'OverAll Buffering Users'
					},
					
					tooltip : {
						pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'//
					},
					credits : {
						enabled : false
					},
					plotOptions : {
						pie : {
							allowPointSelect : true,
							cursor : 'pointer',
							size : 160,
							dataLabels : {
								enabled : false
							},
							showInLegend : true
						}
					},

					series : [ {
						name : "User",
						colorByPoint : true,
						dataLabels: {
			                verticalAlign: 'top',
			                enabled: true,
			                color: '#000000',
			                connectorWidth: 1,
			                distance: -30,
			                connectorColor: '#000000',
			                formatter: function () {
			                    return Math.round(this.percentage) + ' %';
			                }
			            },
						data : [
						        
						        <%
						        GetChartData data = new GetChartData();
						        out.print(data.getPieChartData());
						        %>
						]
					} ]
				});

	};

	function loadResponseAcrossDevices() {
		var chart;

		$(function() {
			setInterval(
					function() {
						//var x = 100, // current time
						data = $
								.parseJSON($
										.ajax({
											url : '../../GetPieChartData?type=PlayerBuffer',
											dataType : "json",
											async : false
										}).responseText);
						console.log(data);
						chart.series[0].setData(data, true);

					}, 1000);
		});

		// Build the chart
		var chart = new Highcharts.Chart(
				{
					chart : {
						renderTo : 'graph1',
						plotBackgroundColor : null,
						plotBorderWidth : null,
						plotShadow : false,
						type : 'pie'
					},
					title : {
						text : 'Buffering Time',
						style : {
							fontSize : '15px'
						}

					},
					subtitle :{
						text :'(Apllication Ver Based) <br>Last 1 Hour',
							style : {
								foutSize : '12px',
							}
					},

					credits : {
						enabled : false
					},

					exporting : {
						enabled : false
					},

					tooltip : {
						pointFormat : ''
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
						},
						series: {
			                cursor: 'pointer',
			                point: {
			                    events: {
			                        click: function () {
			                            location.href = this.options.url;
			                        }
			                    }
			                }
			            }
					},
					series : [ {
						name : "Buffer Share",
						colorByPoint : true,
						dataLabels: {
			                verticalAlign: 'top',
			                enabled: true,
			                color: '#000000',
			                connectorWidth: 1,
			                distance: -30,
			                connectorColor: '#000000',
			                formatter: function () {
			                    return Math.round(this.percentage) + ' %';
			                }
			            },
						data : [
<%-- <%
GetChartData chData = new GetChartData();
out.print(chData.getPlayerVersionBuffer());
%> --%>
	]
					} ]
				});

	};

	function loadResponseAcrossDevices1() {
		var chart;

		$(function() {
			setInterval(
					function() {
						//var x = 100, // current time
						data = $
								.parseJSON($
										.ajax({
											url : '../../GetPieChartData?type=AndroidBuffer',
											dataType : "json",
											async : false
										}).responseText);
						console.log(data);
						chart.series[0].setData(data, true);

					}, 1000);
		});

		// Build the chart
		var chart = new Highcharts.Chart(
				{
					chart : {
						renderTo : 'graph2',
						plotBackgroundColor : null,
						plotBorderWidth : null,
						plotShadow : false,
						type : 'pie'
					},
					title : {
						text : 'Buffering Time',

						style : {
							fontSize : '15px'
						}

					},
					subtitle :{
						text :'(Android Ver Based) <br>Last 1 Hour',
							style : {
								foutSize : '12px',
							}
					},

					credits : {
						enabled : false
					},

					exporting : {
						enabled : false
					},

					tooltip : {
						pointFormat : ''//{series.name}: <b>{point.percentage:.1f}%</b>
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
						},
					series: {
		              //  cursor: 'pointer',
		                point: {
		                    events: {
		                        click: function () {
		                            location.href = this.options.url;
		                        }
		                    }
		                }
		           }
					},
					series : [ {
						name : "Android Share",
						colorByPoint : true,
						 dataLabels: {
				                verticalAlign: 'top',
				                enabled: true,
				                color: '#000000',
				                connectorWidth: 1,
				                distance: -30,
				                connectorColor: '#000000',
				                formatter: function () {
				                    return Math.round(this.percentage) + ' %';
				                }
				            },
						data : [

	]
					} ]
				});

	};
</script>
</head>

<body onload="loadGraph()" id="apd">
	<%@include file="Header.jsp"%>

	<div id="container">

		<%@include file="menu.jsp"%>
		<div id="container">

			<div id="graph1"></div>
			<div id="graph2"></div>
			<div id="graph3">graph3</div>
			<div id="graph4"><%@include file="TableData.jsp"%>
			</div>
			<iframe id='graph5' src='map.jsp'></iframe>

		</div>
	</div>

	<!-- <script type="text/javascript">
		var auto_refresh = setInterval(function() {
			$('#graph1').load('../Graph/androidhighlive.jsp');
		}, 5000)

		var auto_refresh1 = setInterval(function() {
			$('#graph2').load('../Graph/livehighthreshold.jsp');
		}, 5000)
	</script> -->
	<div
		style="background-color: black; color: white; clear: both; text-align: center; padding-top: 5px; bottom: 0; left: 0; margin-top: 15%">Copyright
		© avekshaa.com</div>
</body>
</html>