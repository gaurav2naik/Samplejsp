<%@page
	import="com.avekshaa.cis.premiumusers.AveragePremiumResponseData"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.avekshaa.cis.database.*"%>
<%@page import="com.mongodb.*"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="java.util.*"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%
	String role = (String) session.getAttribute("Role");
	 DB db=CommonDB.getBankConnection();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Customer Experience | Premium User</title>

<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>
<link rel="stylesheet" type="text/css" href="../css/index.css" />
<script type="text/javascript" src="../script/styleswitcher.js"></script>
<link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='../script/treeMenu.js'></script>

<link rel="stylesheet" type="text/css" href="../css/index.css" />
<!-- <script type="text/javascript" src="../script/styleswitcher.js"></script> -->

<link rel="stylesheet" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />
<link rel="stylesheet" type="text/css" href="../css/loading.css">



<style>
.body1 {
	height: 550px;
	width: 1100px;
	/* margin: 5%; */
	/* margin-top: 5%; */
	margin-left: 15%;
	background-image: url('../image/tablet_1.png');
	background-size: 1000px 500px;
	background-repeat: no-repeat;
}

#premiumUserSelect {
	margin-top: 20px;
	padding: 5px;
}

#container {
	background-color: white;
	height: 100%;
	width: 100%;
}
</style>

<script>
$(document).ready(function() {
	$("#0").click(function() {
		//alert("CLICKED");
		$("#LINKS").empty();
		$('.cssload-container').show();
		$("#LINKS").load("premiumgraphs/link1.jsp");
	});

		$("#1").click(function() {
			$("#LINKS").empty();
			$('.cssload-container').show();
			$("#LINKS").load("premiumgraphs/link2.jsp");
		});
		$("#2").click(function() {
			$("#LINKS").empty();
			$('.cssload-container').show();
			$("#LINKS").load("premiumgraphs/link3.jsp");
		});

		$("#3").click(function() {
			$("#LINKS").empty();
			$('.cssload-container').show();
			$("#LINKS").load("premiumgraphs/link4.jsp");
		});

		$("#4").click(function() {
			$("#LINKS").empty();
			$('.cssload-container').show();
			$("#LINKS").load("premiumgraphs/link5.jsp");
		});

	});

	function showDiv(option) {

		$('.cssload-container').hide();

	}
</script>

</head>
<%
	String str;
	String Device = request.getParameter("Device");
	
	if(Device==null||Device==""){
		//System.out.println("hello;;");
		response.sendRedirect("CustomerExperience.jsp");
	}
	//DB androidconn = CommonDB.getBankConnection();
	DBCollection coll = db.getCollection("Regular");

	BasicDBObject findobj1 = new BasicDBObject("UUID", Device.trim());

	List alertData1 = coll.distinct("StartTime", findobj1);
	List<String> arr = new ArrayList<String>();
	if (alertData1.size() > 5) {
		for (int i = alertData1.size() - 1, x = 0; i >= alertData1.size() - 5; i--, x++) {
			long l = (Long) alertData1.get(i);
			if (l != 0) {
				String s = alertData1.get(i).toString();
				arr.add(s);
			}
		}
	} else {
		for (int i = alertData1.size() - 1; i >= 0; i--) {
			long l = (Long) alertData1.get(i);
			if (l != 0) {
				String s = alertData1.get(i).toString();
				arr.add(s);
			}
		}
	}
	arr.add(Device);
	new AveragePremiumResponseData(arr);
%>

<body onload="showDiv()">
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>


	<div class="cssload-container">
		<div class="cssload-whirlpool"></div>
	</div>

	<div id="container">
		<div id="digitaljourney"
			style="height: 46%; width: 22%; background-color: white; color: black; margin-left: 1%; float: left; margin-top: 1%;">
			<b style="color: #001966">LAST 5 DIGITAL JOURNEY'S</b>
			<div class="cell">
				<%
					for (int i = 0; i < arr.size() - 1; i++) {
				%><font size="2"><p>

						<%
							str = new SimpleDateFormat("dd MMM yyyy - HH:mm").format(Long.parseLong(arr.get(i)));
						%>
						<%=str%>
						<%
						System.out.println(arr.get(i));
						String path = GetBandwidthPremiumUser.SelectPicturePath(Device,arr.get(i));
						System.out.println(path);
						%>
					</font>
				<button id=<%=i%>>view</button>
				
				<img src=<%=path%> style="width: 7%;">
				</p>

				<%
					}
				%>
			</div>
		</div>

		<div id="devicedetails"
			style="height: 26%; width: 22%; background-color: white; margin-left: 1%; float: left; margin-top: 20%; position: absolute; float: left;">
			<b style="color: #001966">DEVICE DETAILS</b>
			<p>
				<font size="2"> Device Name - <b> <%
 	//MongoClient mongoClient = new MongoClient( "52.24.170.28" , 27017 );
 	//DB con1 = mongoClient.getDB( "NewJIOData" );
 	//DB con1 = CommonDB.JIOConnection();
 	DBCollection collection = db.getCollection("Regular");

 	String uuid = request.getParameter("Device").trim();
 	System.out.println(uuid);
 	BasicDBObject bdb = new BasicDBObject();
 	bdb.put("UUID", uuid);
 	DBObject curso = collection.findOne(bdb);
 	String name = String.valueOf(curso.get("Mobilename"));
 	String andrver = String.valueOf(curso.get("Android_ver"));
 	String appver = String.valueOf(curso.get("App_ver"));

 	out.println(name);
 %>
				</b></font>
			</p>
			<p>
				<font size="2">Android Version - <%=andrver%></font>
			</p>
			<p>
				<font size="2">Application Version - <%=appver%></font>
			</p>
		</div>


		<div id="LINKS" style="padding-top: 2%">
			<%@include file="premiumgraphs/link1.jsp"%>
		</div>

	</div>
	<%@include file="Footer.jsp"%>
</body>
</html>