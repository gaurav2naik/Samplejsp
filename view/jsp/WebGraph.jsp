<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.avekshaa.cis.Java.LiveWebMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>

<script>
	$(function() {
		$('#container')
				.highcharts(
						{
							title : {
								text : 'Average Web Live Response',
								x : -20
							//center
							},
							subtitle : {
								//text: 'Source: WorldClimate.com',
								x : -20
							},
							xAxis : {
								categories : [

								//  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
<%try{

                    StringBuilder desktopdat = new StringBuilder();
                    String data1="";
                             StringBuilder sb1 = new StringBuilder();
                             LiveWebMap l =new  LiveWebMap();
                             Map<Long, Double> data =l.mtd();


                            for (Iterator iterator =data.keySet().iterator(); iterator.hasNext();)
                            {
                                Long timeInMillis = (Long)iterator.next();//key
                                 //  String IPURIRES = (String)data.get(timeInMillis);//val                                        //


                                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
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
									text : 'Average Response(per min)'
								},
								plotLines : [ {
									// value: 0,

									width : 1,
									//  color: '#808080',
									color : 'orange',
									width : 2,
									value : 2500,

									label : {
										text : 'Threshold',
										x : 0,
										y : 20,

										style : {
											fontSize : '17px',
											//    fontFamily : 'Verdana, sans-serif'
											color : 'orange'
										}

									},

									dashStyle : 'longdashdot',

								} ]
							},
							tooltip : {
							//  valueSuffix: '°C'
							},
							legend : {
								layout : 'vertical',
								align : 'right',
								verticalAlign : 'middle',
								borderWidth : 0
							},
							series : [
									{
										// name: 'tokyo',

										threshold :

										2500,

										//THRESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSHHHHH-1

										negativeColor : 'green',
										color : 'red',

										data :

										[
										// 7.0, 6.9
<%try{

                    StringBuilder sb2 = new StringBuilder();
                    String data2="";
                             StringBuilder sb22 = new StringBuilder();
                             LiveWebMap l1 =new  LiveWebMap();
                             Map<Long, Double> data =l1.mtd();


                            for (Iterator iterator =data.keySet().iterator(); iterator.hasNext();)
                            {
                                Long timeInMillis = (Long)iterator.next();//key
                                   Double avgResp = (Double)data.get(timeInMillis);//val                                        //


                                         //   SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss.SSS");
                                         //   String timeInDateFormat = sdf.format(timeInMillis);
                                            sb22.append(avgResp+ ",");
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

									}, ]
						});
	});
</script>



</head>




<body>
	<div id="container"
		style="min-width: 310px; height: 400px; margin: 0 auto"></div>

</body>
</html>