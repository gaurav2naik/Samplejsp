<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("Role") != null) {
	if(session.getAttribute("Role").equals("IT Admin"))
		{
	response.sendRedirect("DashBoard.jsp?role=IT Admin");
		}
	}
%>
<%
	String role = (String)session.getAttribute("Role");
%>
<%@page import="com.avekshaa.cis.Java.TotalHits48hrs"%>
<%@page import="com.avekshaa.cis.Java.Incident48hrs"%>
<%@page import="com.avekshaa.cis.Java.DistinctUser"%>
<%@page import="com.avekshaa.cis.Java.WebResponseCount"%>
<%@page import="com.avekshaa.cis.Java.AndroidResponseCount"%>
<%@page import="com.avekshaa.cis.Java.CpuPercentLineGraph"%>
<%@page import="com.avekshaa.cis.Java.DurationBar"%>
<%@page import="com.avekshaa.cis.Java.LiveWebMap"%>
<%@page import="com.avekshaa.cis.Java.AndroidMap"%>
<%@page import="com.avekshaa.cis.Java.Perc"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.avekshaa.cis.Java.Live"%>
<%@page import="com.avekshaa.cis.Java.Incident"%>
<%@page import="com.avekshaa.cis.Java.COUNT"%>
<%@page import="com.avekshaa.cis.Java.CPU"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/header.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="../css/button.css">


<!-- <link href="../css/index.css" rel="stylesheet" type="text/css" /> -->
<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>
<style>
html {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
}

body {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
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
	background-repeat: no-repeat;
	background-size: 100%;
	background-repeat: no-repeat;
	/*background-size: 100%;  */
	/*  opacity: 0.4; */
	float: left;
}

#page_wrap_index {
	height: 7%;
	width: 100%;
	position: relative;
}

#container {
	height: 93%;
	width: 100%;
	color: black;
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
	background-repeat: no-repeat;
	background-size: 100%;
	background-repeat: no-repeat;
}

#leftside {
	height: 100%;
	width: 48%;
	color: white;
	position: relative;
	float: left;
	margin-left: 1%;
	margin-right: 1% border-style: solid;
	border-width: medium;
	border-color: #FFCC33;
}

#rightside {
	height: 100%;
	width: 48%;
	color: white;
	margin-left: 1%;
	position: relative;
	float: left;
}

#geolocation {
	height: 58%;
	width: 98%;
	color: white;
	margin-left: 1%;
	margin-right: 1%;
	margin-top: 1%;
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
	float: left;
}

#leftbottom {
	height: 38%;
	width: 98%;
	color: white;
	margin-left: 1%;
	margin-right: 1%;
	margin-top: 1%;
	margin-bottom: 1%;
	position: relative;
	float: left;
}

#graph6 {
	height: 100%;
	width: 48%;
	color: white;
	margin-right: 1%;
	margin-bottom: 1%;
	position: relative;
	background-color: white;
	float: left;
	border-style: solid;
	border-width: medium;
	border-color: #FFCC33;
}

#graph5 {
	height: 100%;
	width: 48%;
	color: black;
	margin-left: 1%;
	margin-bottom: 1%;
	background-color: white;
	position: relative;
	float: left;
	border-style: solid;
	border-width: medium;
	border-color: #FFCC33;
}

#graph2 {
	height: 25%;
	width: 98%;
	color: black;
	margin-left: 1%;
	margin-right: 1%;
	margin-top: 1%;
	margin-bottom: 1% position: relative;
	float: left;
	background-color: white;
	border-style: solid;
	border-width: medium;
	border-color: #FFCC33;
}

#graph3 {
	height: 35%;
	width: 98%;
	color: black;
	margin-left: 1%;
	margin-right: 1%;
	margin-top: 1%;
	margin-bottom: 1% position: relative;
	float: left;
	background-color: white;
	border-style: solid;
	border-width: medium;
	border-color: #FFCC33;
}

#graph4 {
	height: 35%;
	width: 98%;
	color: black;
	margin-left: 1%;
	margin-right: 1%;
	margin-top: 1%;
	position: relative;
	background-color: white;
	float: left;
	border-style: solid;
	border-width: medium;
	border-color: #FFCC33;
}
</style>
<script>
	function loadGraphforNewDashboard() {
		$('#graph4').load('../Graph/AverageAndro.jsp');
		$('#graph3').load('../Graph/Averageweb.jsp');
		$('#graph2').load('../Graph/SLA.jsp');
		loadResponseAcrossDevices();
		loadHitsCount();
	}

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
						renderTo : 'graph6',
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
						renderTo : 'graph5',
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
</script>
</head>
<body onload="loadGraphforNewDashboard()">
	<%@include file="Header.jsp"%>
	<div id="page_wrap_index">
		<div id='cssmenu'>
			<ul>
				<li><a
					href='LiveResponseCustomized.jsp?role=<%out.println(role);%>'><span>Live
							Response </span></a></li>
				<li><a
					href="CustomizedIncident.jsp?role=<%out.println(role);%>"><span>Incident</span></a></li>
				<li><a
					href='CustomizedMobileVsDesktop.jsp?role=<%out.println(role);%>'><span>Desktop
							v/s Mobile</span></a></li>
				<li><a href='UsageDetail.jsp?role=<%out.println(role);%>'><span>Usage
							Detail</span></a></li>
				<li><a href='#'><span>Incident Detail</span></a>
					<ul>
						<li><a href='IncidentDetail.jsp?role=<%out.println(role);%>'><span>Web
									Incident</span></a></li>
						<li><a href='ExceptionGraph.jsp?role=<%out.println(role);%>'><span>App
									Incident</span></a></li>
					</ul></li>
				<li class="last"><a href='Logout.jsp'><span><img
							src="../image/LOGOUT.png" alt=" Logout"
							style="margin-top: -15%; width: 30px; height: 30px;"></span></a></li>

				<li class="last"><a
					href='Configuration.jsp?role=<%out.println(role);%>'><span><img
							src="../image/CONFIG.png" alt=" Configuration"
							style="margin-top: -15%; width: 30px; height: 30px;"></span></a></li>
				<li class="last"><a
					href='PremiumUser.jsp?role=<%out.println(role);%>'><span><img
							src="../image/STAR.png" alt="Premium User"
							style="margin-top: -15%; width: 30px; height: 30px;"></span></a></li>

				<%
					if (role != null) {
														if (role.startsWith("IT")) {

															out.println(" <li class='last'><a href='DashBoard.jsp?role=IT Admin'><span><img src='../image/home.png' alt='Home' style='  margin-top:-15%;width:30px;height:30px;'></span></a></li>");
															/*  out.println("<a class='button' href='DashBoard.jsp?role=IT Admin'>HOME</a> "); */
														} else if (role.startsWith("CIO")) {

															/*  out.println("<a class='button' href='newdashboard.jsp?role=CIO'>HOME</a> "); */
															out.println(" <li class='last'><a href='newdashboard.jsp?role=CIO'><span><img src='../image/home.png' alt='Home' style='  margin-top:-15%;width:30px;height:30px;'></span></a></li>");

														}
													}
				%>

			</ul>
		</div>


	</div>
	<div id="container">

		<div id="leftside">
			<!-- <div id="geolocation">geolocation</div> -->
			<iframe id='geolocation' src='GeolocationAvg.jsp'></iframe>
			<div id="leftbottom">
				<div id="graph6">graph6</div>
				<a href="CPU.jsp?role=<%out.println(role);%>">
					<div id="graph5">graph5</div>
				</a>
			</div>
		</div>
		<div id="rightside">
			<a href="IncidentDetail.jsp?role=<%out.println(role);%>">
				<div id="graph2"></div>
			</a>

			<div id="graph3"></div>
			<div id="graph4"></div>

		</div>
	</div>

	<script type="text/javascript">
		var auto_refresh = setInterval(function() {
			$('#graph4').load('../Graph/AverageAndro.jsp');
		}, 50000)

		var auto_refresh1 = setInterval(function() {
			$('#graph3').load('../Graph/Averageweb.jsp');
		}, 50000)

		var auto_refresh1 = setInterval(function() {
			$('#graph2').load('../Graph/SLA.jsp');
		}, 30000)
	</script>
	<div
		style="background-color: black; color: white; clear: both; text-align: center; padding-top: 5px; bottom: 0; left: 0;">Copyright
		© avekshaa.com</div>
</body>
</html>