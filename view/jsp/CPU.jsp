<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String role = (String) session.getAttribute("Role");
%>
<%@page import="com.avekshaa.cis.Java.CPU"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mobile Average Response |CIS</title>

<script src="../script/jquery.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/highcharts-3d.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/button.css">



<style>
body {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
	position: relative;
	background-size: 100%;
	background: -webkit-linear-gradient(rgb(125, 181, 255),
		rgb(255, 255, 255)); /*Safari 5.1-6*/
	background: -o-linear-gradient(rgb(125, 181, 255), rgb(255, 255, 255));
	/*Opera 11.1-12*/
	background: -moz-linear-gradient(rgb(125, 181, 255), rgb(255, 255, 255));
	/*Fx 3.6-15*/
	background: linear-gradient(rgb(125, 181, 255), rgb(255, 255, 255));
	/*Standard*/
	background-repeat: no-repeat;
	/* float: left; */
	/* background-image:url("../image/banner4.jpg");*/
	background-repeat: no-repeat;
	float: left;
}

#footer-bottom {
	background-color: black;
	color: white;
	clear: both;
	text-align: center;
	padding-top: 5px;
	bottom: 0;
	left: 0;
	position: relative;
	width: 100%;
	height: 1.5em;
	margin-top: 4em;
}

#container {
	height: 400px;
	min-width: 310px;
	max-width: 800px;
}
</style>
<script type="text/javascript">
	$(function() {
		$('#container')
				.highcharts(
						{

							exporting : {
								enabled : false
							},
							chart : {
								type : 'column',
								backgroundColor : 'transparent',
								options3d : {
									enabled : true,
									alpha : 15,
									beta : 15,
									viewDistance : 25,
									depth : 40
								},
								marginTop : 80,
								marginRight : 40
							},

							title : {
								text : 'Average Response'
							},
							subtitle : {
								text : '(Device Specific)'
							},

							xAxis : {
								categories : [
<%try{
                               CPU cc=new CPU();
                        Map<String, Double>map1=cc.mtd();
                        String data2 =null;
                        StringBuilder sb = new StringBuilder();

                      
                        for (Iterator iterator = map1.keySet().iterator(); iterator.hasNext();)  //Iterate through key and value of map
                        {
                            String Device = (String) iterator.next();   //iterate thru key
                            Double avg = (Double) map1.get(Device);    //iterate thru value  based on key                                  //    ////System.out.println("Y VALUR RRT"+yValueRT);
                                     
                                       
                                        sb.append("'"+Device+"',");                           
                                        }
                            
                             data2 = sb.toString();  //string built is stored in data2
                             out.println(data2);
                             ////System.out.println("AXIS["+data2+"]");   /* ../../view/jsp/DeviceDetails.jsp?Device="+Device+" */
                             }
                      catch(Exception ex) {
                          ex.printStackTrace();
                          }%>
	]

							},
							yAxis : {
								title : {
									text : 'Response (ms)'
								}
							},

							plotOptions : {
								series : {
									name:'Response (ms)',
									cursor : 'pointer',
									point : {
										events : {
											click : function() {
												location.href = this.options.url;
											}
										}
									}
								}
							},

							series : [ {
								showInLegend : false,
								data : [
<%try{
                          CPU cc=new CPU();
                   Map<String, Double>map1=cc.mtd();
                   String data2 =null;
                   StringBuilder sb = new StringBuilder();

                 
                   for (Iterator iterator = map1.keySet().iterator(); iterator.hasNext();)  //Iterate through key and value of map
                   {
                       String Device = (String) iterator.next();   //iterate thru key
                       Double avg = (Double) map1.get(Device);    //iterate thru value  based on key                                  //    ////System.out.println("Y VALUR RRT"+yValueRT);
                                
                                  
                                   sb.append("{y:"+avg+",url:'DeviceDetails.jsp?Device="+Device+"&role="+role+"'},");                           
                                   }
                       
                        data2 = sb.toString();  //string built is stored in data2
                        out.println(data2);
                        ////System.out.println("AXIS["+data2+"]");   /* ../../view/jsp/DeviceDetails.jsp?Device="+Device+" */
                        }
                 catch(Exception ex) {
                     ex.printStackTrace();
                     }%>
	]
							} ]
						});
	});
</script>
</head>

<body>
	<%@include file="Header.jsp"%>

	<%@include file="menu.jsp"%>


	<div id="container"
		style="margin-top: 1%; margin-left: 20%; margin-right: 20%"></div>
	<div id="footer-bottom">Copyright © avekshaa.com</div>

</body>
</html>