<%@page import="com.avekshaa.cis.engine.ExceptionDataCalculate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.avekshaa.cis.jio.GetChartData"%>
<%@page import="java.util.List"%>
<%@page import="com.avekshaa.cis.database.CommonUtils"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="com.avekshaa.cis.login.UserBean"%>

<%
	String day = request.getParameter("day");
	if(day==null){
		day = "1";
	}
	//String role = (String) session.getAttribute("Role");
	UserBean currUser = (UserBean) session.getAttribute("currentSessionUser");
	/* System.out.println("----------------???????????????????????????????"+session.getAttribute("currentSessionUser")); */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/button.css">
<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>

<title>Incidents |CIS</title>
<style type="text/css">
#topDiv {
	height: 25%;
	width: 97%;
	margin-left: 1%;
	margin-top: 1%;
	/* border-style: solid;
	border-width: medium;
	border-color: yellow */
}

#graph1 {
	height: 34%;
	width: 20%;
	background: white;
	color: white;
	margin-left: 1%;
	margin-top: 0%;
	float: left;
	/*  margin-right: 1%;*/
	/* border-style: solid;
	border-width: medium;
	 border-color: yellow; */
	position: absolute;
}

#graph2 {
	height: 34%;
	width: 20%;
	background: white;
	color: white;
	margin-left: 28%;
	margin-top: 0%;
	float: left;
	/* margin-right: 1%; */
/* 	border-style: solid;
	border-width: medium;
	border-color: yellow;*/
	position: absolute;
}

#graph3 {
	height: 34%;
	width: 20%;
	background: white;
	color: white;
	margin-left: 50%;
	margin-top: 0%;
	float: left;
	/* margin-right: 1%; */
/* 	 border-style: solid;
	border-width: medium;
	border-color: yellow;  */
	position: absolute;
}

#graph4 {
	height: 34%;
	width: 20%;
	background: white;
	color: white;
	margin-left: 73%;
	margin-top: 0%;
	float: left;
	/* margin-right: 1%; */
/* 	border-style: solid;
	border-width: medium;
	border-color: yellow; */
	position: absolute;
}

.myButton {
	margin-top: 1%;
	padding-top: 2%;
	margin-bottom: 0%;
	padding-bottom: 0%;
	background-color: white;
	text-decoration: none;
	border-bottom: 1px solid black;
	cursor: pointer;
	color: black;
	font-family: Arial;
	font-size: 17px;
	/* 	font-weight:bold; */
	text-decoration: none;
}

.myButton:hover {
	color: #1691D8;
}
</style>
<script type="text/javascript">
	// for applicartion sersion response 

	$(function() {
		$('#graph1')
				.highcharts(
						{
							chart : {
								plotBackgroundColor : null,
								plotBorderWidth : null,
								plotShadow : false,
								type : 'pie'
							},
							exporting : {
								enabled : false
							},
							title : {
								text : 'Exception Distribution'
							},
							credits : {
								enabled : false

							},
							tooltip : {
								headerFormat : '<span style="font-size:10px;color:{series.color}">Excep: </span><b>{point.key}</b><br>',
								pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
							},
							plotOptions : {
								pie : {
									allowPointSelect : true,
									cursor : 'pointer',
									dataLabels : {
										enabled : false,
										/* format : '<b>{point.name}</b>: {point.percentage:.1f} %',
										style : {
											color : (Highcharts.theme && Highcharts.theme.contrastTextColor)
													|| 'black'
										} */
									}
								}
							},
							series : [ {
								name : "Percentage",
								colorByPoint : true,
								dataLabels : {
									enabled : true,
									verticalAlign : 'top',
									connectorWidth : 1,
									distance : -30,
									formatter : function() {
										return Math.round(this.percentage) + ' %';
										//return this.percentage;
									}
								},
								data : [
<%ExceptionDataCalculate edc1 = new ExceptionDataCalculate();

			String webExcp1 = edc1.Exception("$Exception", day);
			out.print(webExcp1);%>
	]
							} ]
						});
	});

	$(function() {
		$('#graph2')
				.highcharts(
						{
							chart : {
								renderTo : 'graph2',
								plotBackgroundColor : null,
								plotBorderWidth : null,
								plotShadow : false,
								type : 'pie'
							},
							title : {
								text : 'Application Version'
							},
							exporting : {
								enabled : false
							},
							credits : {
								enabled : false

							},
							tooltip : {
								/* pointFormat : '' */
								headerFormat : '<span style="font-size:10px;color:{series.color}">App Ver: </span><b>{point.key}</b><br>',
								pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
							},
							plotOptions : {
								pie : {
									allowPointSelect : true,
									cursor : 'pointer',
									dataLabels : {
										enabled : false,
									}
								}
							},
							series : [ {
								name : "Percentage",
								colorByPoint : true,
								dataLabels : {
									enabled : true,
									verticalAlign : 'top',
									connectorWidth : 1,
									distance : -30,
									formatter : function() {
										//return Math.round(this.percentage) + ' %';
										return this.point.name;
									}
								},
								data : [
<%ExceptionDataCalculate edc2 = new ExceptionDataCalculate();
String webExcp2 = edc2.Exception("$App_ver", day);
			out.print(webExcp2);%>
			]
							} ]
						});
	});

	$(function() {
		$('#graph3')
				.highcharts(
						{
							chart : {
								plotBackgroundColor : null,
								plotBorderWidth : null,
								plotShadow : false,
								type : 'pie'
							},
							exporting : {
								enabled : false
							},
							credits : {
								enabled : false

							},
							title : {
								text : 'Android Version'
							},
							tooltip : {
								headerFormat : '<span style="font-size:10px;color:{series.color}">Android Ver: </span><b>{point.key}</b><br>',
								pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
							},
							plotOptions : {
								pie : {
									allowPointSelect : true,
									cursor : 'pointer',
									dataLabels : {
										enabled : false,
										/* format : '<b>{point.name}</b>: {point.percentage:.1f} %',
										style : {
											color : (Highcharts.theme && Highcharts.theme.contrastTextColor)
													|| 'black'
										} */
									}
								}
							},
							series : [ {
								name : "Percentage",
								colorByPoint : true,
								dataLabels : {
									enabled : true,
									verticalAlign : 'top',
									connectorWidth : 1,
									distance : -30,
									formatter : function() {
										//return Math.round(this.percentage) + ' %';
										return this.point.name;
									}
								},
								data : [
<%ExceptionDataCalculate edc3 = new ExceptionDataCalculate();
			String webExcp3 = edc3.Exception("$Android_ver", day);
			out.print(webExcp3);%>
	]
							} ]
						});
	});

	$(function() {
		$('#graph4')
				.highcharts(
						{
							chart : {
								plotBackgroundColor : null,
								plotBorderWidth : null,
								plotShadow : false,
								type : 'pie'
							},
							title : {
								text : 'Exception Distribution'
							},
							exporting : {
								enabled : false
							},
							credits : {
								enabled : false

							},
							tooltip : {
								headerFormat : '<span style="font-size:10px;color:{series.color}">Web Exception:</span><b>{point.key}</b><br>',
								pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
							},
							plotOptions : {
								pie : {
									allowPointSelect : true,
									cursor : 'pointer',
									dataLabels : {
										enabled : false,
									}
								}
							},
							series : [ {
								name : "Percentage",
								colorByPoint : true,
								dataLabels : {
									enabled : true,
									verticalAlign : 'top',
									connectorWidth : 1,
									distance : -30,
									formatter : function() {
										//return Math.round(this.percentage) + ' %';
										return this.point.name;
									}
								},
								data : [
<%ExceptionDataCalculate edc = new ExceptionDataCalculate();
			String webExcp = edc.WebException(day);
			out.print(webExcp);%>
	]
							} ]
						});
	});
</script>
</head>

<script>
	function PassDaysNumber(days) {
		/* alert("here"); */
		var s = document.getElementById(days.id).getAttribute("id");
		var url = window.location.href;
		var param = '?day=' + days.id
		if (url.indexOf('?') > -1) {
			url = url.replace(url.substring(url.indexOf('?')), param)
		} else {
			//	alert("inside else")
			url += param
			//alert(url)
		}
		window.location.href = url;
	}
</script>
<body>

	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>
	<div style="margin-left: 2%; margin-top: 1%">
		<div
			style="width: 10%; display: inline; border-right: 2px solid black; padding-right: 1%; padding-left: 1%;">
			<a href="#" id="1" style="color: #1691D8;"
				onclick="PassDaysNumber(this)">1 Day</a>
		</div>
		<div
			style="width: 10%; display: inline; border-right: 2px solid black; padding-right: 1%; padding-left: 1%;">
			<a href="#" id="7" style="color: #1691D8;"
				onclick="PassDaysNumber(this)">1 Week</a>
		</div>
		<div
			style="width: 10%; display: inline; border-right: 2px solid black; padding-right: 1%; padding-left: 1%;">
			<a href="#" id="30" style="color: #1691D8;"
				onclick="PassDaysNumber(this)">1 Month</a>
		</div>

	</div>
	<div id="topDiv">
		<h1
			style='color: #0A29B0; font-family: Arial, Calibri; padding-left: 5%'>
			<%
				//System.out.println("inside jsp near count"+day);
				int count = ExceptionDataCalculate.ExceptionCount(day);
				out.println(count);
			%>
		</h1>
		<h5 style="padding-left: 2%">Application Crashes</h5>
		<div id="incident"
			style="height: 60%; width: 30%; margin-left: 25%; margin-top: -7%; padding-top: 2%;">
			<h1 align="center"
				style="margin-top: -5%; color: #0A29B0; font-family: Arial, Calibri;">
				<%
					int thresholdbreach = ExceptionDataCalculate.Alerts(day);
					out.print(thresholdbreach);
				%>
			</h1>
			<h5 align="center" style="padding-right: 15%; padding-left: 15%">Total
				Incidents</h5>
		</div>

		<div id="alert"
			style="height: 60%; width: 30%; margin-left: 63%; margin-top: -10.5%;">
			<h1
				style='color: #0A29B0; font-family: Arial, Calibri; padding-left: 24%'>
				<%
					int total = count + thresholdbreach;
					out.println(total);
				%>
			</h1>
			<h5 style="padding-right: 15%; padding-left: 15%">Number Of
				Alerts</h5>
			<h5 style="padding-right: 15%; padding-left: 0%">
				Email sent to :
				<%
				String email = null;
				DBCursor cursor = null;
				try {
					DB db = CommonDB.getConnection();
					DBCollection coll = db.getCollection("first");
					if(currUser.getUsername()!=null){
					BasicDBObject findObj = new BasicDBObject("UserName", currUser.getUsername());
					cursor = coll.find(findObj);
					cursor.limit(1);
					List<DBObject> dbObjs = cursor.toArray();
					for (int i = dbObjs.size() - 1; i >= 0; i--) {
						DBObject txnDataObject = dbObjs.get(i);
						email = (String) txnDataObject.get("Email");
					}
					}
					if (total == 0 || email == null) {
						out.println("No email sent");
					} else {
						out.println(email);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (cursor != null)
						cursor.close();
				}
			%>
			</h5>
		</div>
	</div>

	<div id="container2" style="margin-top: -3%">
		<p style="margin-left: 3%">
			<span
				style="color: #6c7fc6; font-family: Arial, Calibri; font-weight: bold; font-size: 24px">Application
				Crashes </span> <span
				style="margin-left: 56%; color: #6c7fc6; font-family: Arial, Calibri; font-weight: bold; font-size: 24px">Web
				Errors</span>
		</p>
		<div
			style="width: 30%; margin-left: 1.5%; border-top-color: #f2f2f2; border-top-style: solid;"></div>
		<div id="graph1"></div>
		<div id="graph2"></div>
		<div id="graph3"></div>
		<div id="graph4"></div>
	</div>
	<div
		style="width: 99%; height: 10%; margin-top: 19%">
		<span style="color: #6c7fc6; font-size: 15px; margin-left:2%"><a
			href="ExceptionGraph.jsp?day=<%=day%>">See Details</a> </span> <span
			style="margin-left: 69%; color: #6c7fc6; font-size: 15px"><a
			href="IncidentDetail.jsp?day=<%=day%>">See Details</a> </span>
	</div>
	<%@include file="Footer.jsp"%>
</body>
</html>