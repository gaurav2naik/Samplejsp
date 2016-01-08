<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Map"%>
<%@page import="java.util.*"%>
<%@page import="com.avekshaa.cis.engine.Live"%>
<%@page import="java.text.SimpleDateFormat"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta content="25" http-equiv="refresh">
<head>
<title>Insert title here</title>
<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>
<style type="text/css">
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
								text : 'Client Response Time',
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
                                     Live l =new Live();
                                     Map<Long,String> data = l.getResponseTimesForScatterGraph("","","","");
                                   
                                   
                                    for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
                                    {
                                        Long timeInMillis = (Long) iterator.next();
                                           String IPURIRES = (String) data.get(timeInMillis);                                        //    ////System.out.println("Y VALUR RRT"+yValueRT);
                                                  
                                                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss.SSS");
                                                    String timeInDateFormat = sdf.format(timeInMillis);
                                                    mobiledat.append("'"+timeInDateFormat+ "',");                                        }
                                       
       
                        data2 = mobiledat.toString();
                        out.println(data2);
                        ////System.out.println("x axis ["+data2+"]");
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
									text : 'Response Time(in milisecs)'
								},
								plotLines : [ {
									value : 0,
									width : 1,
									color : '#808080'
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

								data : [
<%try{           
                     
                       StringBuilder desktopdat = new StringBuilder();
                       String data2="";
                                StringBuilder mobiledat = new StringBuilder();
                                Live l =new Live();
                                Map<Long,String> data = l.getResponseTimesForScatterGraph("","","","");
                                 for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
                                 {
                                     Long timeInMillis = (Long) iterator.next();
                                        String IPURIRES = (String) data.get(timeInMillis);
                                        ////System.out.println("x axis="+timeInMillis);
                                       
                                   
                                       
                                        //////System.out.println("Y AXIS="+IPURIRES);
                                       
                                    String[] occurrences = IPURIRES.split("_");
                               
                                    String IPURI=occurrences[0]+"_"+occurrences[1];
                                    String Response=occurrences[2];
                                    Double Res = Double.parseDouble(Response);
                                //    ////System.out.println(IPURI+"___"+Response);
                                    ////System.out.println("Y AXIS  "+IPURI+Res);
                               
                                   
                                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss.SSS");
                                    String timeInDateFormat = sdf.format(Res);
                                //    mobiledat.append(yValueRT+ ",");
                                    mobiledat.append("{y:"+Res+",myData:'"+IPURI+"'},");    
                               
                               
                           
                            }
               
                   data2 = mobiledat.toString();
                   out.println(data2);
                   ////System.out.println("Y axis ["+data2+"]");
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
	<div id="container1" style="width: 100%; height: 100%;"></div>

</body>
</body>
</html>