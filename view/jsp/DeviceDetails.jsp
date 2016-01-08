<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.avekshaa.cis.database.*"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="java.util.List"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%
	String role = (String) session.getAttribute("Role");
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Device Details |CIS</title>

<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>
<link rel="stylesheet" type="text/css" href="../css/index.css" />
<script type="text/javascript" src="../script/styleswitcher.js"></script>
<link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/treeMenu.css" rel="stylesheet" type="text/css" />
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='../script/treeMenu.js'></script>
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/header.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="../css/button.css">
<style>
#container1 {
	width: 100%;
	background: transparent;
}

#container2 {
	width: 100%;
	background: transparent;
}

#container3 {
	width: 100%;
	background: transparent;
}
</style>

</head>

<%
	String Device=request.getParameter("Device");
  
    DB dbs=CommonDB.AndroidConnection();
    DBCollection colls = dbs.getCollection("Regular");
    DBCursor alertData =null;
    BasicDBObject findObj1 = new BasicDBObject("Mobilename",Device);
    try{
     alertData = colls.find(findObj1);
    alertData.sort(new BasicDBObject("_id", -1));
    alertData.limit(50);       
  
   
    List<DBObject> dbObjss = alertData.toArray();
   
    StringBuilder startTime= new StringBuilder(); StringBuilder cpu=new StringBuilder(); StringBuilder ram= new StringBuilder(); StringBuilder req= new StringBuilder() ; StringBuilder res= new StringBuilder(); StringBuilder dur= new StringBuilder();
    StringBuilder NetworkType= new StringBuilder();
    long temp_ram ; String t1 ;  StringBuilder final_value=new StringBuilder() ; StringBuilder Info_device = new StringBuilder();StringBuilder Catagory_value = new StringBuilder();
   
   
    DecimalFormat df = new DecimalFormat("###.##");
   
    for (int i = dbObjss.size()-1; i >= 0; i--)
    {
         
          DBObject txnDataObject = dbObjss.get(i);
       
         
          String info_mob=((String)txnDataObject.get("Mobilename")+", "+(String)txnDataObject.get("acitvity_name"));
         
          cpu.append( df.format(Double.parseDouble(txnDataObject.get("cpu").toString()))).append(",");
          
          //convert ram kilobytes in mb
          
          temp_ram=(Long)txnDataObject.get("ram");
          temp_ram=temp_ram/1024;
          ram.append(temp_ram +",");
          int networkCase;
         
          //convert in time format from long
          t1= new SimpleDateFormat("dd/MM/yyyy : HH:mm:ss").format(txnDataObject.get("response_time"));
          req.append("'" +t1+ ", " +info_mob+"',");
          dur.append((Long)txnDataObject.get("duration")+","); 
          String Network=txnDataObject.get("NetworkType").toString();
         
          			switch (Network) {
	case "Unknown":
		networkCase = 0;
		break;
	case "2G":
		networkCase = 1;
		break;
	case "3G":
		networkCase = 2;
		break;
	case "4G":
		networkCase = 3;
		break;
	case "WIFI":
		networkCase = 4;
		break;
	default:
		networkCase = 0;
	}
	NetworkType.append(networkCase+ ",");

		}
%>




<script>
	function function_name() {
		/*CPU Usage Graph  */
		$(function() {

			$('#container1').highcharts({
				chart : {
					type : 'area'
				},
				title : {
					text : 'CPU Usage %',
					x : -20
				//center
				},
				/* subtitle: {
				    text: 'Source: WorldClimate.com',
				    x: -20
				}, */
				xAxis : {
					categories : [
<%=req%>
	]
				},
				yAxis : {
					title : {
						text : 'CPU Usage'
					},
					plotLines : [ {
						value : 0,
						width : 1,
						color : '#808080'
					} ]
				},
				tooltip : {
					valueSuffix : ' %'
				},
				legend : {
					layout : 'vertical',
					align : 'right',
					verticalAlign : 'middle',
					borderWidth : 0
				},

				credits : {
					enabled : false

				},

				series : [

				{

					showInLegend : false,

					name : 'CPU usage',

					data : [
<%=cpu%>
	],

					color : '#571B7E'

				},

				]
			});
		});
		/*Ram Usage Graph  */

		$(function() {
			$('#container2').highcharts({
				chart : {
					type : 'area'
				},
				title : {
					text : 'RAM Usage',
					x : -20
				//center
				},
				/* subtitle: {
				    text: 'Source: WorldClimate.com',
				    x: -20
				}, */
				credits : {
					enabled : false

				},
				xAxis : {
					categories : [
<%=req%>
	]
				},
				yAxis : {
					title : {
						text : 'RAM Usage'
					},
					plotLines : [ {
						value : 0,
						width : 1,
						color : '#660033'
					} ]
				},
				tooltip : {
					valueSuffix : ' MB'
				},
				legend : {
					layout : 'vertical',
					align : 'right',
					verticalAlign : 'middle',
					borderWidth : 0
				},

				series : [

				{

					showInLegend : false,
					name : 'RAM usage',
					data : [
<%=ram%>
	],
					color : '#660033'

				},

				]
			});
		});
		/* Response Time Graph */
		$(function() {
			$('#container3').highcharts({
				exporting : {
					enabled : false
				},
				chart : {
					type : 'area'
				},
				title : {
					text : 'Response',
					x : -20
				//center
				},

				credits : {
					enabled : false
				},
				xAxis : {
					categories : [
<%=req%>
	]
				},
				yAxis : {
					title : {
						text : 'Duration'
					},
					plotLines : [ {
						value : 0,
						width : 1,
						color : '#808080'
					} ]
				},
				tooltip : {
					valueSuffix : 'ms'
				},
				legend : {
					layout : 'vertical',
					align : 'right',
					verticalAlign : 'middle',
					borderWidth : 0
				},

				series : [

				{
					showInLegend : false,
					name : 'Response time',
					data : [
<%=dur%>
	],
					color : '#FF3300'

				},

				]
			});
		});

		/*Network Graph  */

		$(function() {
			var change = {
				0 : 'No Network',
				1 : '2G',
				2 : '3G',
				3 : '4G',
				4 : 'WIFI'
			};
			$('#container4')
					.highcharts(
							{
								exporting : {
									enabled : false
								},
								chart : {
									type : 'area'
								},
								title : {
									text : 'Network Details',
									x : -20
								//center
								},

								credits : {
									enabled : false
								},
								xAxis : {
									categories : [
<%=req%>
	]
								},
								yAxis : {
									title : {
										text : 'Network Type'
									},
									labels : {
										formatter : function() {
											var value = change[this.value];
											return value !== 'undefined' ? value
													: this.value;
										}
									},
									tickInterval : 1,

								},
								tooltip : {
									formatter : function() {
										return this.x + '<br>' + '<b>'
												+ this.series.name + '</b>:'
												+ change[this.y];
									},

								},
								legend : {
									layout : 'vertical',
									align : 'right',
									verticalAlign : 'middle',
									borderWidth : 0
								},

								series : [

										{
											showInLegend : false,
											name : 'Network Type',
											data : [
<%=NetworkType%>
	],
											labels : {
												formatter : function() {
													var value = change[this.value];
													return value !== 'undefined' ? value
															: this.value;
												}
											},

											color : '#FF3300'

										},

								]
							});
		});

	}

	function_name();
	setInterval('function_name()', 30000);
</script>

<body>
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>
	<br>
	<br>
	<div id="Header" align="center">
		<h1>
			Device Name : <font color="Red"> <%
 	out.println(request.getParameter("Device"));
 %>
			</font>
		</h1>
	</div>

	<br>
	<br>
	<div id="container3" style="height: 250px; width: 98%;"></div>
	<br>
	<br>
	<div id="container1" style="height: 250px; width: 98%;"></div>
	<br>
	<br>
	<div id="container2" style="height: 250px; width: 98%;"></div>
	<br>
	<div id="container4" style="height: 250px; width: 98%;"></div>
	<br>
	<br>

	<%@include file="Footer.jsp"%>
</body>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		alertData.close();
	}
%>

</html>