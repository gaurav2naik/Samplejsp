<%@page import="com.avekshaa.cis.engine.GetChartData"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mongodb.ServerAddress"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mongodb.BasicDBObject"%>
<%@ page import="com.mongodb.DB"%>
<%@ page import="com.mongodb.MongoClient"%>
<%@ page import="com.mongodb.DBCollection"%>
<%@ page import="com.mongodb.DBCursor"%>
<%@ page import="com.mongodb.MongoException"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="com.mongodb.DBObject"%>
<%@ page import="com.mongodb.Mongo"%>
<%@ page import="com.mongodb.WriteConcern"%>
<%@ page import="com.avekshaa.cis.database.CommonDB"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>CIS| Map</title>


<script src="../script/jquery.js"></script>
<script src="../script/jquery.min.js"></script>

<!-- <script	src="http://code.highcharts.com/mapdata/countries/in/custom/in-all-disputed.js"></script> -->
<script src="../script/exporting.js"></script>
<script src="../script/highmaps.js"></script>
<script src="../script/data.js"></script>
<script src="../script/in-all-disputed.js"></script>
<script type="text/javascript">
<% int i =10;
String web = "web";
String app = "app";
%>
<%
GetChartData chData = new GetChartData();
String appMapData = chData.getMapData(app,1).toString();	
String webMapData = chData.getMapData(web,1).toString();
	%>

$(function(){
$('#set_WebData').click(function() {
	var data = [<%=webMapData %>];
    var chart = $(this).parent('div').attr('id');
    chart = chart.replace('_','');
    $('#'+chart).highcharts().series[0].setData(data);
    $('#'+chart).highcharts().setTitle(null, { text: 'Response Across Regions (Web)'});
});
$('#set_AppData').click(function() {
	var data = [<%=appMapData %>];
    var chart = $(this).parent('div').attr('id');
    chart = chart.replace('_','');
    $('#'+chart).highcharts().series[0].setData(data);
    $('#'+chart).highcharts().setTitle(null, { text: 'Response Across Regions (App)'});
});	
	$(function() {

		// Prepare demo data
		var data = [<%out.print(webMapData);%>

	];

		// Initiate the chart
		$('#map-container')
				.highcharts(
						'Map',
						{

							title : {
								text : 'INDIA',
								 style: {
				                     fontSize: '14px',
				                    
				                     fontFamily: 'Verdana, sans-serif'
				                 }
							},

							subtitle : {
								text : "Response Across Regions (Web)",
								 style: {
				                     fontSize: '14px',
				                     /* fontWeight : 'bold', */
				                     fontFamily: 'Verdana, sans-serif'
				                 }
							},

							mapNavigation : {
								enabled : true,
								buttonOptions : {
									verticalAlign : 'bottom'
								}
							},

							colorAxis : {
								min : 100,
								max : 10000,
								minColor : '#efecf3',
								maxColor : '#990041',
								gridLineWidth : 2,
								gridLineColor : 'black',
								minorGridLineColor : 'white',
								dataClasses : [ {
									to : 0,
									color : '#5CB3FF',
									name : 'NOT ACCESSED'
								}, {
									from : 0,
									to : 1500,
									color : 'green',
									name : 'Good'
								}, {
									from : 1501,
									to : 2500,
									color : 'yellow',
									name : 'average'
								}, {
									from : 2500,

									color : 'Red',
									name : 'Bad'
								} ]
							},
							chart : {
								borderWidth : 0,
								borderColor : 'silver',
								borderRadius : 9,
								shadow : false,
								backgroundColor : {
									linearGradient : {
										x1 : 0,
										y1 : 0,
										x2 : 0,
										y2 : 1
									},
									stops : [ [ 0, 'white' ], [ 1, '#ffffff' ] ]
								}
							},
							credits: {
					            enabled: false
					        },
							series : [ {
								borderColor:'#2e2e2e',
								borderWidth:'1',
								data : data,								
								mapData : Highcharts.maps['countries/in/custom/in-all-disputed'],
								joinBy : 'hc-key',
								name : 'Average Load Time',
								states : {
									hover : {
										color : '#FCF9F9'
									}
								},
								dataLabels : {
									enabled : true,
									format : '{point.name}'
								}
							} ]
						});
	});
	
	});
</script>

</head>
<body>
<div id="map-container_" style="float:left">
   <button id="set_WebData">Web</button>
   <button id="set_AppData">App</button>
  </div>
	<div id="map-container" style="padding-bottom: 10px"></div>

</body>
</html>