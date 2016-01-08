<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.avekshaa.cis.engine.*"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="com.mongodb.DB"%>
<%@page import="org.apache.log4j.Logger"%>

<%@page import="java.util.Map"%>
<%@page import="java.util.*"%>
<%@page import="com.avekshaa.cis.Java.CPU"%>
<%
	String role = (String) session.getAttribute("Role");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!--  SESSION MANAGEMENT-to store session -->
<%
	String stime = request.getParameter( "startTime" );
   session.setAttribute( "startTime", stime);
%>

<%
	String etime= request.getParameter( "endTime" );
   session.setAttribute( "endTime", etime);
%>

<html>
<head>
<title>Usage Details | CIS</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/index.css" />
<script type="text/javascript" src="../script/styleswitcher.js"></script>
<link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />


<link rel="stylesheet" href="../css/button.css">
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/treeMenu.css" rel="stylesheet" type="text/css" />
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<!--          <link href="../css/piechart.css" rel="stylesheet" type="text/css"/> -->
<script type='text/javascript' src='../script/treeMenu.js'></script>


<script src="datetimepicker_css.js"></script>
<script type='text/javascript' src='../script/jquery.js'></script>
<!--           <script type='text/javascript' src="../script/dashboardrecent.js"></script> -->
<script type='text/javascript' SRC="../script/jquery.min.js"></script>
<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/highcharts-more.js"></script>



<style>
body {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
	position: relative;
	/*  background: -moz-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* ff3.6+ */ */
	/* background: -webkit-gradient(linear, left bottom, right top, color-stop(0%, rgba(0,
		255, 128, 1)), color-stop(100%, rgba(0, 219, 219, 1))); */
	/* safari4+,chrome */
	/* background: -webkit-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* safari5.1+,chrome10+ */
	/*background: -o-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* opera 11.10+ */ */
	/*background: -ms-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* ie10+ */
	/*background: linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* w3c */
	/*filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00DBDB',
		endColorstr='#00ff80', GradientType=1); /* ie6-9 */
	background-repeat: no-repeat;
	background-size: 100%;
	background-repeat: repeat;
	/*background-size: 100%;  */
	/*  opacity: 0.4; */
	float: left;
}
</style>

<script src="../script/solid-gauge.src.js"></script>
<script src="../script/exporting.js"></script>


<script>
	function loadGraphforNewDashboard() {
		
		loadResponseAcrossDevices();
	
	}


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
						renderTo : 'DeviceShare',
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
							size : 200,
							dataLabels : {
								enabled : false
							},
							showInLegend : true
						}
					},
					series : [ {
						name : "Device Share",
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
  	              if(!Device.equals("NoData")){
  					sb3.append("{name :'"+Device+ "',y:"+avg+"},");
  	              }
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
<body id="ud" onload="loadGraphforNewDashboard()">

	<%@include file="Header.jsp"%>

	<%@include file="menu.jsp"%>
	<!-- <div id="BROWSERGRAPH2"></div> -->
	<br>
	<br>
	<div id="DeviceShare" style="padding-bottom: 20px"></div>
	<%@include file="Footer.jsp"%>
</body>
</html>

