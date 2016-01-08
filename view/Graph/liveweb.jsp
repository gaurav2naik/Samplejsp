<%@page import="com.avekshaa.cis.commonutil.Convertor"%>
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
<%@page import="com.avekshaa.cis.Java.Live"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta content="10" http-equiv="refresh">
<head>
<title>Insert title here</title>
<!--  <script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>
<link href="../css/header.css" rel="stylesheet" type="text/css" />  -->
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

/* html {
    height: 100%;
    width: 100%;
    margin: 0;
    padding: 0;
} */
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
                            text : 'Web  Response',
                            x : -20
                        //center
                        },
                       /*  subtitle : {
                            text : 'Last 1 hour',
                            x : -20
                        }, */

                        credits : {
                            enabled : false
                        },

                        xAxis : {
                            labels : {
                                enabled:true,
                                rotation : -45,
                                style : {
                                   
                                    fontFamily : 'Verdana, sans-serif'
                                }
                            },

                            categories : [
<%try{

                        StringBuilder desktopdat = new StringBuilder();
                        String data2="";
                                 StringBuilder mobiledat = new StringBuilder();
                                 Live l =new Live();
                                 Map<Long,String> data =
     l.getResponseTimesForScatterGraph("","","","");
                                  for (Iterator iterator =
     data.keySet().iterator(); iterator.hasNext();)
                                {
                                    Long resp = (Long)iterator.next();   //key
                                       String execAct = (String)data.get(resp);   //value                                     //
                       SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
                                                String timeInDateFormat = sdf.format(resp); 
                                               // String timeInDateFormat = Convertor.timeInDefaultFormat(resp);
                                                mobiledat.append("'"+timeInDateFormat+ "',");
          }


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
                     
                        }%>
]

                        },
                        yAxis : {
                            title : {
                                text : 'Response Time(ms)'
                            },
                            min:0,
                            plotLines: [{
                              
                                color: '#FF0000',
                                dashStyle: 'ShortDash',
                                width: 2,
                                value:
                                    //500000,
                                    <%DBCursor alertData = null;
         
            try {
            
                /* Mongo m=new Mongo("127.0.0.1",27017);
            
            
                //2.connect to your DB
                DB db=m.getDB("CIS"); */
                DB db=CommonDB.getConnection();
                ////System.out.println("DB Name:"+db.getName());
            
                //3.select the collection
                DBCollection coll=db.getCollection("ThresholdDB");
                ////System.out.println("IN threshold DAO"+coll.getName());
            
            
            
        //fetch name
                BasicDBObject findObj = new BasicDBObject();
                alertData = coll.find(findObj);
                alertData.sort(new BasicDBObject("_id", -1));
            
                alertData.limit(1);
                List<DBObject> dbObjs = alertData.toArray();

                for (int i = dbObjs.size() - 1; i >= 0; i--)

                {
                    DBObject txnDataObject = dbObjs.get(i);
                    Integer res = (Integer) txnDataObject.get("Web_threshold");
                 
                    ////System.out.println("THRES:"+res);
                
                    out.println(res);
                
              %>
                ,
      
                                  
                           
                                //LINE
                                zIndex: 0,
                                label : {
                                    text : 'Threshold',
                                  
                                  

                                        style : {
                                            //fontSize : '13px',
                                            //    fontFamily : 'Verdana, sans-serif'
                                            color : 'red'
                                        }
                                  
                                }
                            }, ]
                          
                       
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
                        
                        
                        //---------------------------------------------------------------------------------
							series : [ {

								showInLegend : false,

								tooltip : {
									valueDecimals : 2
								},
								
								
								  showInLegend : false,
						           threshold :

						                          //  3300,   //MIN THRESHOLD-yellow
						                            <%

						        Double perc=0.9;  //70%
						        Integer yellow1=res;
						        
						        Double yellow2=perc*yellow1;
						      
						        
						        ////System.out.println("monishaaa"+yellow2);
						        out.println(yellow2); 
						       
						        %>,
						                           negativeColor : 'green',
						                            color : 'orange',
								
								
								
								
								
								
								
								
								

								data : [
<%try{

                   StringBuilder desktopdat = new StringBuilder();
                   String data2="";
                            StringBuilder mobiledat = new StringBuilder();
                            Live l =new Live();
                            Map<Long,String> data =
l.getResponseTimesForScatterGraph("","","","");
                             for (Iterator iterator =
data.keySet().iterator(); iterator.hasNext();)
                             {
                                 Long timeInMillis = (Long) iterator.next();
                                    String IPURIRES = (String)data.get(timeInMillis);
                                    //////System.out.println("xaxis="+timeInMillis);



                                    ////////System.out.println("YAXIS="+IPURIRES);

                                String[] occurrences = IPURIRES.split("&&");

                                String IPURI=occurrences[0]+"_"+occurrences[1];
                                String Response=occurrences[2];
                                Integer Res = Integer.parseInt(Response);
                            //
//////System.out.println(IPURI+"___"+Response);
                                //////System.out.println("Y AXIS  "+IPURI+Res);


                                SimpleDateFormat sdf = new
SimpleDateFormat("HH:mm:ss");
                                String timeInDateFormat = sdf.format(Res);
                            //    mobiledat.append(yValueRT+ ",");

mobiledat.append("{y:"+Res+",myData:'"+IPURI+"'},");



                        }

               data2 = mobiledat.toString();
               out.println(data2);
               //////System.out.println("Y axis ["+data2+"]");
               }
                  catch(Exception ex)
                  {
                      ex.printStackTrace();
                      }

               finally
               {
                   //////System.out.println("");
                   }%>
	]
							},
							
					//222222222222222222222222222222222222
							 {
								
								 threshold : <% out.println(res);
				              
			                
						        }
						    } catch (Exception e) {
						        e.printStackTrace();
						      
						    } finally {
						        alertData.close();
						    }               %>,

						                            //MAX THRESHOLD-RED

						       
						                            negativeColor : 'transparent',
						                            color : 'red',
						            					
								
								
								
			

									showInLegend : false,

									tooltip : {
										valueDecimals : 2
									},

									data : [
	<%try{

	                   StringBuilder desktopdat = new StringBuilder();
	                   String data2="";
	                            StringBuilder mobiledat = new StringBuilder();
	                            Live l =new Live();
	                            Map<Long,String> data =
	l.getResponseTimesForScatterGraph("","","","");
	                             for (Iterator iterator =
	data.keySet().iterator(); iterator.hasNext();)
	                             {
	                                 Long timeInMillis = (Long) iterator.next();
	                                    String IPURIRES = (String)data.get(timeInMillis);
	                                    //////System.out.println("xaxis="+timeInMillis);



	                                    ////////System.out.println("YAXIS="+IPURIRES);

	                                String[] occurrences = IPURIRES.split("&&");

	                                String IPURI=occurrences[0]+"_"+occurrences[1];
	                                String Response=occurrences[2];
	                                Integer Res = Integer.parseInt(Response);
	                            //
	//////System.out.println(IPURI+"___"+Response);
	                                //////System.out.println("Y AXIS  "+IPURI+Res);


	                                SimpleDateFormat sdf = new
	SimpleDateFormat("HH:mm:ss");
	                                String timeInDateFormat = sdf.format(Res);
	                            //    mobiledat.append(yValueRT+ ",");

	mobiledat.append("{y:"+Res+",myData:'"+IPURI+"'},");



	                        }

	               data2 = mobiledat.toString();
	               out.println(data2);
	               //////System.out.println("Y axis ["+data2+"]");
	               }
	                  catch(Exception ex)
	                  {
	                      ex.printStackTrace();
	                      }

	               finally
	               {
	                   //////System.out.println("");
	                   }%>
		]
								}

							
							
				
							]
						});
	});
</script>
</head>
<body>


	<div id="container1" style="width: 100%; height: 100%;"></div>

</body>
</body>
</html>