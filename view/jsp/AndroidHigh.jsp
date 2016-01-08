<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta content="25" http-equiv="refresh">
<head>
<title>Insert title here</title>
<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
	position: relative;
	background: -webkit-linear-gradient(rgb(125, 181, 255),
		rgb(255, 255, 255)); /*Safari 5.1-6*/
	background: -o-linear-gradient(rgb(125, 181, 255), rgb(255, 255, 255));
	/*Opera 11.1-12*/
	background: -moz-linear-gradient(rgb(125, 181, 255), rgb(255, 255, 255));
	/*Fx 3.6-15*/
	background: linear-gradient(rgb(125, 181, 255), rgb(255, 255, 255));
	/*Standard*/
	background-repeat: no-repeat;
}

/* html {
    height: 100%;
    width: 100%;
    margin: 0;
    padding: 0;
} */
#container1 {
	margin-top: 4%;
}
</style>
<script>
	$(function() {
		$('#container1')
				.highcharts(
						{

							exporting : {
								enabled : false
							},

							chart : {
								type : 'line',
								zoomType : 'xy',
								backgroundColor : 'transparent'
							},

							title : {
								text : 'Live Android Response',
								x : -20
							//center
							},
							subtitle : {

								x : -20
							},

							credits : {
								enabled : false
							},

							xAxis : {
								labels : {
									rotation : -90,
									style : {
										fontSize : '13px',
										fontFamily : 'Verdana, sans-serif'
									}
								},

								categories : [
<%try{

                            StringBuilder desktopdat = new StringBuilder();
                            String data2="";
                                     StringBuilder mobiledat = new StringBuilder();
                                     AndroidLive l =new  AndroidLive();
                                     Map<Long,String> data =l.getResponseTimesForScatterGraph("","","","");


                                    for (Iterator iterator =data.keySet().iterator(); iterator.hasNext();)
                                    {
                                        Long resp = (Long)iterator.next();   //key
                                           String execAct = (String)data.get(resp);   //value                                     //
                          SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss.SSS");
                                                    String timeInDateFormat = sdf.format(resp);
                                                    mobiledat.append("'"+timeInDateFormat+ "',");
              }


                        data2 = mobiledat.toString();
                        out.println(data2);
                        //System.out.println("x axis ["+data2+"]");
                        }
                           catch(Exception ex)
                           {
                               ex.printStackTrace();
                               }

                        finally
                        {
                           
                            }%>
	]

							},
							yAxis : {
								title : {
									text : 'Duration(ms)'
								},
								plotLines : [ {

									color : '#FF0000',
									dashStyle : 'ShortDash',
									width : 2,
									value : 2500,
									zIndex : 0,
									label : {
										text : 'Goal'
									}
								}, {
									color : '#008000',
									dashStyle : 'ShortDash',
									width : 2,
									value : 1,
									zIndex : 0,
									label : {
										text : 'Last Year\'s Maximum Revenue'
									}
								} ]

							},
							tooltip : {

								formatter : function() {
									return 'IP and URI: <b>'
											+ this.point.myData
											+ '</b><br>Time <b>' + this.x
											+ '</b><br>Response Time <b>'
											+ this.y + '</b> ms';
								},
								valueSuffix : ''
							},

							legend : {
								layout : 'vertical',
								align : 'right',
								verticalAlign : 'middle',
								borderWidth : 0
							},
							series : [ {

								showInLegend : false,

								//  threshold : 

								//	2500

								//THRESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSHHHHH

								negativeColor : 'green',
								color : 'red',

								tooltip : {
									valueDecimals : 2
								},

								data : [
<%try{

                       StringBuilder desktopdat = new StringBuilder();
                       String data2="";
                                StringBuilder mobiledat = new StringBuilder();
                                AndroidLive l =new AndroidLive();
                                Map<Long,String> data =l.getResponseTimesForScatterGraph("","","","");
                                //System.out.println(data);
                                 for (Iterator iterator =data.keySet().iterator(); iterator.hasNext();)
                                 {
                                     Long exec= (Long) iterator.next(); //key
                                    
                                        String exAct = (String)data.get(exec); //value                                       

                                    String[] occurrences = exAct.split("_");

                                    String activity=occurrences[0];
                                    String Response=occurrences[1];
                                    Integer Res = Integer.parseInt(Response);
////System.out.println(IPURI+"___"+Response);
                                    ////System.out.println("Y AXIS  "+IPURI+Res);


                                    SimpleDateFormat sdf = new
SimpleDateFormat("dd-MMM-yyyy HH:mm:ss.SSS");
                                    String timeInDateFormat = sdf.format(Res);
                                //    mobiledat.append(yValueRT+ ",");

mobiledat.append("{y:"+Res+",myData:'"+activity+"'},");



                            }

                   data2 = mobiledat.toString();
                   out.println(data2);
                   //System.out.println("Y axis ["+data2+"]");
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
							} ]
						});
	});
</script>
</head>
<body>

	<%@include file="Header.jsp"%>
	<div id="page_wrap_graphs">
		<a class="button" href="Copy of FRONT.jsp">HOME</a>

	</div>
	<div id="container1"
		style="min-width: 100%; height: 100%; margin-top: 100px;"></div>
	<%@include file="Footer.jsp"%>
</body>
</body>
</html>