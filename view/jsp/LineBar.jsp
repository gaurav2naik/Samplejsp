<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.avekshaa.cis.Java.CpuPercentLineGraph"%>
<%@page import="com.avekshaa.cis.Java.DurationBar"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<style type="text/css">
#container {
	margin-top: 100%;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="Script/jquery.js"></script>
<script src="Script/highcharts.js"></script>
<script src="Script/exporting.js"></script>




<%@page import="java.util.*"%>

<script>
	$(function() {
		$('#container')
				.highcharts(
						{
							chart : {
								zoomType : 'xy'
							},
							title : {
								text : 'Average CPU % and Average Duration for each Activity  '
							},
							subtitle : {
							//   text:		
							},
							xAxis : [ {

								categories : [
								// 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
<%try{ 
		                	CpuPercentLineGraph cc=new CpuPercentLineGraph();
		               Map<String, Double>map1=cc.mtd();
		               String data2 =null;
		               StringBuilder sb = new StringBuilder();

		              
		               for (Iterator iterator = map1.keySet().iterator(); iterator.hasNext();)  //Iterate through key and value of map
		               {
		                   String Activity = (String) iterator.next();   //iterate thru key
		                      Double avg = (Double) map1.get(Activity);    //iterate thru value  based on key                                  //    ////System.out.println("Y VALUR RRT"+yValueRT);
		                             
		                               
		                               sb.append("'"+Activity+"'"+",");                            
		                               }
		                    
		    				data2 = sb.toString();  //string built is stored in data2
		    				out.println(data2);
		    				////System.out.println("AXIS["+data2+"]");
		    				}
		             catch(Exception ex) {
		                 ex.printStackTrace();
		                 }
		        
		          finally
		          {
		              ////System.out.println("");
		              }%>
	],

								title : {
									text : '<b>Activity</b>',

									style : {
										// color:'red',
										fontSize : '15px'
									}

								},

								crosshair : true
							} ],
							yAxis : [
									{ // Primary yAxis
										labels : {
											format : '{value}ms',
											style : {
												color : '#CC33FF'
											}
										},

										stackLabels : {
											enabled : true,
											style : {
												fontWeight : 'bold',
												color : (Highcharts.theme && Highcharts.theme.textColor)
														|| 'gray'
											}
										},

										title : {
											text : 'Average Duration(ms)',
											style : {
												color : '#CC33FF'
											}
										}
									}, { // Secondary yAxis
										title : {
											text : 'Average CPU percentage(%)',
											style : {
												color : '#6600CC'
											}
										},
										labels : {
											format : '{value} %',
											style : {
												color : '#6600CC',
											}
										},
										opposite : true
									} ],
							tooltip : {
								shared : true
							},
							legend : {
								layout : 'vertical',
								align : 'left',
								x : 120,
								verticalAlign : 'top',
								y : 100,
								floating : true,
								backgroundColor : (Highcharts.theme && Highcharts.theme.legendBackgroundColor)
										|| '#FFFFFF'
							},
							series : [
									{
										name : 'CPU%',
										type : 'column',
										color : '#6600CC',
										yAxis : 1,
										data : [
										//49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4
<%try{ 
			                	CpuPercentLineGraph cc=new CpuPercentLineGraph();
			               Map<String, Double>map1=cc.mtd();
			               String data2 =null;
			               StringBuilder sb = new StringBuilder();

			               for (Iterator iterator = map1.keySet().iterator(); iterator.hasNext();)  //Iterate through key and value of map
			               {
			                   String Activity = (String) iterator.next();   //iterate thru key
			                      Double avg = (Double) map1.get(Activity);    //iterate thru value  based on key                                  //    ////System.out.println("Y VALUR RRT"+yValueRT);
			                             sb.append(avg+",");                            
			                               }
			               
			    				data2 = sb.toString();  //string built is stored in data2
			    				out.println(data2);
			    				////System.out.println("AXIS["+data2+"]");
			    				}
			             catch(Exception ex) {
			                 ex.printStackTrace();
			                 }
			        
			          finally
			          {
			              ////System.out.println("");
			              }%>
	],
										tooltip : {
											valueSuffix : '%'
										}

									},
									{
										name : 'Average Duration',
										type : 'spline',
										color : '#CC33FF',

										marker : {
											lineWidth : 2,
											lineColor : ' #CC33FF',
											fillColor : 'white'
										},

										data : [
										//7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6
<%try{ 
			                	DurationBar cc=new DurationBar();
			               Map<String, Double>map1=cc.mtd();
			               String data2 =null;
			               StringBuilder sb = new StringBuilder();

			              
			               for (Iterator iterator = map1.keySet().iterator(); iterator.hasNext();)  //Iterate through key and value of map
			               {
			                   String Device = (String) iterator.next();   //iterate thru key
			                      Double avg = (Double) map1.get(Device);    //iterate thru value  based on key                                  //    ////System.out.println("Y VALUR RRT"+yValueRT);
			                             
			                               
			                               sb.append(avg+",");                            
			                               }
			                    
			    				data2 = sb.toString();  //string built is stored in data2
			    				out.println(data2);
			    				////System.out.println("AXIS["+data2+"]");
			    				}
			             catch(Exception ex) {
			                 ex.printStackTrace();
			                 }
			        
			          finally
			          {
			              ////System.out.println("");
			              }%>
	],
										tooltip : {
											valueSuffix : 'ms'
										}
									} ]
						});
	});
</script>
</head>

<body>

	<%@include file="Header.jsp"%>
	<div id="container"
		style="min-width: 100%; height: 100%; margin-top: 150px;"></div>

	<%@include file="Footer.jsp"%>
</body>
</html>