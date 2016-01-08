<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	if (session.getAttribute("Role") != null) {
		if (session.getAttribute("Role").equals("CIO")) {
	response.sendRedirect("newdashboard.jsp?role=CIO");
		}
	}
	

	String role = (String) session.getAttribute("Role");

	%>

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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Experience</title>
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
	background: -moz-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* ff3.6+ */
	background: -webkit-gradient(linear, left bottom, right top, color-stop(0%, rgba(0,
		255, 128, 1)), color-stop(100%, rgba(0, 219, 219, 1)));
	/* safari4+,chrome */
	background: -webkit-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* safari5.1+,chrome10+ */
	background: -o-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* opera 11.10+ */
	background: -ms-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* ie10+ */
	background: linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* w3c */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00DBDB',
		endColorstr='#00ff80', GradientType=1); /* ie6-9 */
	background-size: 150%;
	background-repeat: repeat;
}

#container {
	height: 100%;
	width: 100%;
}

#graph2 {
	height: 88%;
	width: 45%;
	background-color: white;
	color: white;
	margin-left: 3%;
	/*    position: relative;  */
	float: left;
	margin-top: 2%;
	border-style: solid;
	border-width: medium;
	border-color: yellow;
	position: absolute;
	float: left;
}

#graph1 {
	height: 50%;
	width: 45%;
	background-color: white;
	color: white;
	margin-left: 52%;
	/*    position: relative;  */
	float: left;
	margin-top: 2%;
	border-style: solid;
	border-width: medium;
	border-color: yellow;
	position: absolute;
}

#graph3 {
	height: 35%;
	width: 22%;
	background: white;
	color: white;
	margin-left: 52%;
	margin-top: 28.4%;
	float: left;
	/*  margin-right: 1%; */
	border-style: solid;
	border-width: medium;
	border-color: yellow;
	background-color: white;
	position: absolute;
}

#map {
	height: 88%;
	width: 45%;
	color: white;
	margin-left: 3%;
	margin-top: 2%;
	position: relative;
	float: left;
	border-style: solid;
	border-width: medium;
	border-color: #FFCC33;
	/*  background: transparent; */
	background: -webkit-linear-gradient(rgb(125, 181, 255),
		rgb(255, 255, 255)); /*Safari 5.1-6*/
	background: -o-linear-gradient(rgb(125, 181, 255), rgb(255, 255, 255));
	/*Opera 11.1-12*/
	background: -moz-linear-gradient(rgb(125, 181, 255), rgb(255, 255, 255));
	/*Fx 3.6-15*/
	background: linear-gradient(rgb(125, 181, 255), rgb(255, 255, 255));
	/*Standard*/
	background-repeat: no-repeat;
	background-size: 100%;
}

#graph4 {
	height: 35%;
	width: 22%;
	background: white;
	color: white;
	margin-left: 75%;
	margin-top: 28.4%;
	float: left;
	/* margin-right: 1%; */
	border-style: solid;
	border-width: medium;
	border-color: yellow;
	background-color: white;
	position: absolute;
}

#graph5 {
	height: 45%;
	width: 45%;
	background: white;
	color: white;
	margin-left: 26.5%;
	margin-top: 26%;
	float: left;
	/* margin-right: 1%; */
	border-style: solid;
	border-width: medium;
	border-color: yellow;
	background-color: white;
	position: relative;
}
</style>
<script type="text/javascript">
	function loadGraph() {
		$('#graph1').load('../Graph/androidhighlive.jsp');
		/* $('#graph2').load('../Graph/livehighthreshold.jsp'); */

		loadResponseAcrossDevices();
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
					url : '../../GetDashboardPieChartData?type=hitsCount',
					dataType : "json",
					async : false
				}).responseText);

				var y = data.y;
				var x = data.x;
				if (y == 0 && x == 0) {
					chart.setTitle(null, {
						text : 'No Data',
						style : {
							fontSize : '20px',
						}

					});
				} else {
					chart.setTitle(null, {
						text : 'Web=' + y + ' Mobile=' + x
					});
				}
				chart.series[0].setData([ [ 'Web', y ], [ 'Mobile', x ],

				], true);

			}, 2000);
		});
		var chart = new Highcharts.Chart(
				{

					chart : {
						renderTo : 'graphpie',
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
						text : 'Web V/S Mobile Hits'
					},
					subtitle : {

						text :
<%OneHourWeb obj1 = new OneHourWeb();
			OneHourAndroid obj2 = new OneHourAndroid();

			String data7 = null;
			StringBuilder sb = new StringBuilder();

			double ans1 = obj1.mtd();
			double ans2 = obj2.mtd();

			sb.append("'" + "Web=" + ans1 + "." + "Android=" + ans2 + "'");
			data7 = sb.toString(); //string built is stored in data2
			out.println(data7);

			////System.out.println("-----count Android----:" + ans1);%>
	,
						style : {
							color : 'red',
						}

					},
					tooltip : {
						pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
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
							showInLegend : false
						}
					},

					series : [ {
						name : "Hits",
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
											url : '../../GetDashboardPieChartData?type=responseAcrossDevices',
											dataType : "json",
											async : false
										}).responseText);
						console.log(data);
						chart.series[0].setData(data, true);

					}, 60000);
		});

		// Build the chart
		var chart = new Highcharts.Chart(
				{
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
						data : [
<%try{ 
  	CPU cc=new CPU();
  	Map<String, Double>map1=cc.mtd();
  	String data2 =null;
  	StringBuilder sb3 = new StringBuilder();


  	for (Iterator iterator = map1.keySet().iterator(); iterator.hasNext();)  //Iterate through key and value of map
  	{
  	   String Device = (String) iterator.next();   //iterate thru key
  	 Double avg = (Double) map1.get(Device);    //iterate thru value  based on key                                  //    //System.out.println("Y VALUR RRT"+yValueRT);
  	             
  	               
  	              // sb3.append("{name: '"+Device+"',data: ["+avg+"], stack: '"+Device+"'},");                            
  					sb3.append("{name :'"+Device+ "',y:"+avg+"},");              
  	}
  	    
  		data2 = sb3.toString();  //string built is stored in data2
  		out.println(data2);
  		//System.out.println("["+data2+"]");
  		}
  	catch(Exception ex) {
  	 ex.printStackTrace();
  	 }%>
	]
					} ]
				});

	};

	$(function() {
		$('#graph5')
				.highcharts(
						{
							chart : {
								type : 'bar',
								backgroundColor : 'transparent'
							},

							exporting : {
								enabled : false
							},

							title : {
								text : 'Customer Response Index'
							},
							/* subtitle : {
							text: 'Total Request vs SLA Breach <br> Perr'
							}, */

							exporting : {
								enabled : false
							},
							subtitle : {
								text :
<%Perc objP = new Perc();

			String dataPer = null;
			StringBuilder stringB = new StringBuilder();

			int ans8 = objP.mtd();

			stringB.append("'" + "Total Request vs SLA Breach <br> "
					+ "Percentage:" + ans8 + "%" + "'");
			dataPer = stringB.toString(); //string built is stored in data2
			out.println(dataPer);

			//////System.out.println("PERCENT" + dataPer);%>
	,
								style : {
									color : 'red',
									font : 'bold 13px "Trebuchet MS", Verdana, sans-serif'
								}

							},
							xAxis : {
								categories : [ 'Users' ],
								title : {
									text : null
								}
							},
							yAxis : {

								min : 0,
								title : {
									text : 'users',
									align : 'high'
								},
								labels : {
									overflow : 'justify',
									enabled : false
								}
							},
							tooltip : {
								valueSuffix : ' Users'
							},
							plotOptions : {
								bar : {
									dataLabels : {
										enabled : true
									}
								}
							},
							legend : {
								layout : 'horizontal',
								align : 'right',
								verticalAlign : 'bottom',
								floating : true,
								backgroundColor : '#FFFFFF',

							},
							credits : {
								enabled : false
							},
							series : [
									{

										//showInLegend:false,
										color : 'Red',
										name : 'Incidents',
										data :
										//[2]

										[
<%WebResponseCount wc1 = new WebResponseCount();
			Long countWeb1 = wc1.error();
			out.println(countWeb1);
			//////System.out.println("count WEB:" + countWeb);%>
	]

									},
									{

										showInLegend : true,
										name : 'Total Hit',
										color : 'blue',
										data :

										//[10]
										[
<%int countAndroid = wc1.response();
			out.println(countAndroid);
			System.out.println("count Android:" + countAndroid);%>
	]

									} ]
						});
	});
</script>
</head>

<body onload="loadGraph()" id="home">
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>


	<div id="container">


		<div id="container">

			<iframe id='map' src='AppMap.jsp'></iframe>
			<div id="graph1"></div>
			<!-- <div id="graph2"></div> -->
			<div id="graph3">
				<iframe frameborder="0" src='DeviceCount.jsp'></iframe>
			</div>
			<a href="CPU.jsp?role=<%out.println(role);%>"><div id="graph4"></div></a>
		</div>
	</div>

	<script type="text/javascript">
		var auto_refresh = setInterval(function() {
			$('#graph1').load('../Graph/androidhighlive.jsp');
		}, 5000)

		/* var auto_refresh1 = setInterval(function() {
			$('#graph2').load('../Graph/livehighthreshold.jsp');
		}, 5000)
 */	</script>
	<div
		style="background-color: black; color: white; clear: both; text-align: center; padding-top: 5px; bottom: 0; left: 0;">Copyright
		© avekshaa.com</div>
</body>
</html>