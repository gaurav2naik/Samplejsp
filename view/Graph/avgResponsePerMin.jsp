<%@page import="com.avekshaa.cis.database.CommonThreshold"%>
<%@page import="com.avekshaa.cis.jio.GetChartData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta content="25" http-equiv="refresh"> -->
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
<%-- <%@page import="com.avekshaa.cis.Java.COUNT"%>
<%@page import="com.avekshaa.cis.Java.CPU"%>
<%@page import="java.text.SimpleDateFormat"%> --%>
<%@page import="com.avekshaa.cis.Java.OneHourWeb"%>
<%@page import="com.avekshaa.cis.Java.OneHourAndroid"%>
<%@page import="com.avekshaa.cis.Java.AndroidLive"%>

<!-- <script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>
<link href="../css/header.css" rel="stylesheet" type="text/css" /> -->
<script>
	$(function() {
		$('#container1')
				.highcharts(
						{
							title : {
								text : ' Avg Response per min (one Hour)',
								x : -20
							//center
							},
							 chart: {
					                zoomType: 'x'
					            },
							subtitle : {
								text : 'One Hour',
								x : -20
							},

							exporting : {
								enabled : false
							},
							credits : {
								enabled : false
							},
							xAxis : {
								/* tickPositions: [3,6,9],
								
								 tickColor: '#5A5E5E',
								 tickWidth: 3, */

								/* tickPositioner : function(min, max) {
									return [ Math.round(min), (min + max) / 2,
											Math.round(max) ];
								}, */

								labels : {
									enabled : true
								},

								categories : [

								//  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
<%try{

                    StringBuilder desktopdat = new StringBuilder();
                    String data1="";
                             StringBuilder sb1 = new StringBuilder();
                             AndroidMap l =new  AndroidMap();
                             Map<Long, Double> data =l.getDataForPerMin();


                            for (Iterator iterator =data.keySet().iterator(); iterator.hasNext();)
                            {
                                Long timeInMillis = (Long)iterator.next();//key
                                 //  String IPURIRES = (String)data.get(timeInMillis);//val                                        //


                                            SimpleDateFormat sdf = new SimpleDateFormat(" HH:mm");
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
	]
							},
							yAxis : {
								title : {
									text : 'Average Response (ms) per min'
								},
								min : 0,
								plotLines : [
										{

											value :<%=CommonThreshold.getWebThreshold()%> ,
											width : 1,
											color : 'red',
											label : {
												text : 'Web Threshold',
												x : 0,
												y : 15,
												style : {
													fontSize : '10px',
													//    fontFamily : 'Verdana, sans-serif'
													color : 'red'
												}

											},
										// 									dashStyle : 'ShortDash'
										},
										{

											value :<%=CommonThreshold.getAndroidThreshold()%>,
	

											width : 1,
											//  color: '#808080',
											color : 'red',
											label : {
												text : 'App Threshold',
												x : 0,
												y : 15,

												style : {
													fontSize : '10px',
													//    fontFamily : 'Verdana, sans-serif'
													color : 'red'
												}

											},

											dashStyle : 'ShortDash'

										} ]
							},
							tooltip : {

								formatter : function() {
									return 'Time: <b>' + this.point.extra
											+ '</b><br>Response Time <b>'
											+ this.y + '</b> ms';
								},
								valueSuffix : ''
							},
							legend : {
							//	layout : 'vertical',
							//align : 'right',
							// 								verticalAlign : 'middle',
							// 								borderWidth : 0
							},
							series : [
									{
										name : 'Web Response',
										showInLegend : true,
										threshold : <%=CommonThreshold.getWebThreshold()%> ,
										negativeColor : 'green',
										color : 'red',
										data : [
<%GetChartData ch = new GetChartData();
								String resChartData = ch.getWebAvgResponsePerMin();
								out.print(resChartData);%>]},
									{
										name : 'App Response',
										showInLegend : true,

										//RED
										threshold :<%=CommonThreshold.getAndroidThreshold()%> ,

	

										//THRESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSHHHHH-1

										negativeColor : '#365BEF',
										color : 'red',
										 marker: {
								                symbol: 'triangle'
								            },
										data : [
<%try{

						                    StringBuilder sb2 = new StringBuilder();
						                    String data2="";
						                             StringBuilder sb22 = new StringBuilder();
						                             AndroidMap l1 =new  AndroidMap();
						                             Map<Long, Double> data =l1.getDataForPerMin();


						                            for (Iterator iterator =data.keySet().iterator(); iterator.hasNext();)
						                            {
						                                Long timeInMillis = (Long)iterator.next();//key
						                                   Double avgResp = (Double)data.get(timeInMillis);//val                                        //



						                                   SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
						                                   String timeInDateFormat = sdf.format(timeInMillis);
						                                 
						                               
						                                   sb22.append("{y:"+avgResp+ ",extra:'"+timeInDateFormat+"'},");
						      }


						                data2 = sb22.toString();
						                out.println(data2);
						                //System.out.println("x axis ["+data2+"]");
						                }
						                   catch(Exception ex)
						                   {
						                       ex.printStackTrace();
						                       }

						                finally
						                {
						                    ////System.out.println("");
						                    }%>
	]
									},

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