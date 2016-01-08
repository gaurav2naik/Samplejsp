<%@page import="com.avekshaa.cis.database.CommonThreshold"%>
<%@page import="com.avekshaa.cis.jio.GetChartData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<%@page import="java.util.Map"%>
<%@page import="java.util.*"%>
<%@page import="com.avekshaa.cis.Java.AndroidLive"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
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
<!--  <script src="../script/jquery.min.js"></script> -->
<!-- <script src="../script/jquery.js"></script> -->
<!-- <script src="../script/highcharts.js"></script> -->
<!-- <script src="../script/exporting.js"></script> -->
<!-- <link href="../css/header.css" rel="stylesheet" type="text/css" /> -->
<script>
	$(function() {
		<% GetChartData resChar = new GetChartData();
	String responseAppData = resChar.getWebResposeData(1); 
		
		%>
		$('#container1')
				.highcharts(
						{
							chart:{
								type:'spline',
								zoomType: 'x'
							},
							title : {
								text : 'Avg Response per Hour (one day)',
								 style: {
				                     fontSize: '14px',
				                   /*   fontWeight : 'bold', */
				                     fontFamily: 'Verdana, sans-serif'
				                 },
								x : -20
							//center
							},
							subtitle : {
								text : '',
								x : -20
							},

							exporting : {
								enabled : false
							},

							xAxis : {

								labels : {
									enabled : true
								},

								categories : [

<%try{

                    StringBuilder desktopdat = new StringBuilder();
                    String data1="";
                             StringBuilder sb1 = new StringBuilder();
                             AndroidMap l =new  AndroidMap();
                             Map<Long, Double> data =l.mtd();


                            for (Iterator iterator =data.keySet().iterator(); iterator.hasNext();)
                            {
                                Long timeInMillis = (Long)iterator.next();//key
                                 //  String IPURIRES = (String)data.get(timeInMillis);//val                                        //


                                            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                                            String timeInDateFormat = sdf.format(timeInMillis);
                                            sb1.append("'"+timeInDateFormat+ "',");
      }


                data1 = sb1.toString();
                out.println(data1);
                //System.out.println("y axis ["+data1+"]");
                }
                   catch(Exception ex)
                   {
                       ex.printStackTrace();
                       }

                finally
                {
                    ////System.out.println("");
                    }%>
	],
								labels : {
									rotation : -45,
								/* style: {
								    fontSize: '13px',
								    fontFamily: 'Verdana, sans-serif'
								} */
								}
							},
							yAxis : {
								title : {
									text : 'Avg response<b>(ms)</b>per Hour'
								},
								min : 0,
								plotLines : [ {
									value : <%=CommonThreshold.getWebThreshold()%>,
									//width : 1,
									color : 'red',
									width : 2,
									label : {
										text : 'Web Threshold',
										x : 0,
										y : 15,
										style : {
											fontSize : '10px',
											color : 'red'
										}
									},
									dashStyle : 'ShortDash'
								} 
							]
							},
							tooltip : {

								formatter : function() {
									return 'Time: <b>' + this.point.extra
											+ '</b><br>Response Time :<b>'
											+ this.y + '</b> ms';
								},
								valueSuffix : ''
							},
							credits : {
								enabled : false
							},
							series : [ {
								name:'Web Response',
								showInLegend : false,
								threshold :<%=CommonThreshold.getWebThreshold()%>,
								negativeColor : 'green',
								color : 'red',
								 marker: {
						                symbol: 'triangle'
						            },
								data :
								[ <%out.print(responseAppData);%> ]

							}
							]
						});
	});
</script>
<style>
body {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
	position: relative;
}

html {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body>
	<div id="container1" style="width: 100%; height: 100%;"></div>
</body>
</html>