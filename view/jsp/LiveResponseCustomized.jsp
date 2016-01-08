<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Map"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="com.avekshaa.cis.database.CommonUtils"%>
<%@page import="com.avekshaa.cis.commonutil.Convertor"%>
<%@page import="com.avekshaa.cis.engine.Live"%>
<%@page import="com.avekshaa.cis.engine.LiveResponseCustomized"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>
<%
	String role = (String) session.getAttribute("Role");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Experience | Incident data graph</title>
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link href="../css/treemenu.css" rel="stylesheet" type="text/css" />
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<link href="../css/button.css" rel="stylesheet" type="text/css" />



<script type='text/javascript' src='../script/jquery.js'></script>
<script type='text/javascript' src='../script/getURL.js'></script>
<script type='text/javascript' src='../script/createtable.js'></script>
<script src="../script/jquery.min.js"></script>
<script src="../script/datetimepicker_css.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>
<script src="../script/formValidation.js"></script>
<style>
body {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
	position: relative;
	background: -moz-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* ff3.6+ */
	background: -webkit-gradient(linear, left bottom, right top, color-stop(0%, rgba(0,
		255, 128, 1)), color-stop(100%, rgba(0, 219, 219, 1)));
	/* safari4+,chrome */
	background: -webkit-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* safari5.1+,chrome10+ */
	background: -o-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* opera 11.10+ */
	background: -ms-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* ie10+ */
	background: linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* w3c */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00DBDB',
		endColorstr='#00ff80', GradientType=1); /* ie6-9 */
	background-repeat: no-repeat;
	background-size: 100%;
	background-repeat: repeat;
	/*background-size: 100%;  */
	/*  opacity: 0.4; */
	float: left;
}
</style>
<script>
	$(function() {
		$('#graph_live')
				.highcharts(
						{

							credits : {
								enabled : false
							},

							exporting : {
								enabled : false
							},

							chart : {
								type : 'spline',
								zoomType : 'xy',
								backgroundColor : 'white'
							},

							title : {
								text : 'Client Response Time',
								x : -20
							//center
							},
							subtitle : {

								x : -20
							},
							xAxis : {
								/* min: 0, 
								max: 100000, */

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
                                      StringBuilder xais = new StringBuilder();
                                       if(null != request.getParameter("cmd"))
                            {
                               String  startTime ="";
                                  String endTime="";
                                 startTime = request.getParameter("startTime");
                                endTime = request.getParameter("endTime");                             
                                LiveResponseCustomized live = new LiveResponseCustomized();                             
                                TreeMap<Long,String> data = live.getIPandURI(startTime,endTime);
                                 //////System.out.println("RESULT : "+data);
                                 for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
                                 {
                                     Long timeInMillis = (Long) iterator.next();
                                       String timeInDateFormat = Convertor.timeInDefaultFormat(timeInMillis);
                                                    xais.append("'"+timeInDateFormat+ "',");                                        
                                                    //////System.out.println(timeInDateFormat);
                               }
                        data2 = xais.toString();
                        out.println(data2);
                      ////System.out.println("x axis ["+data2+"]");
                   }  else
                            {
                	   			Live l =new Live();
                                  Map<Long,String> data = l.getResponseTimesForScatterGraph("","","","");
                                  ////System.out.println("AT 111"+data);
                               for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
                                 {
                                     Long timeInMillis = (Long) iterator.next();
                                        String IPURIRES = (String) data.get(timeInMillis);                                        //    //////System.out.println("Y VALUR RRT"+yValueRT);
                                               
                                                 String timeInDateFormat = Convertor.timeInDefaultFormat(timeInMillis);
                                                 xais.append("'"+timeInDateFormat+ "',");                                      }
                            }
                     data2 = xais.toString();
                     out.println(data2);
                   ////System.out.println("x axis ["+data2+"]");
                }
                           catch(Exception ex)
                           {
                               ex.printStackTrace();
                               
                        	   final Logger logger = Logger.getRootLogger();
                        	   logger.error("Unexpected error",ex);
                               }%>
	],
								lineWidth : 5

							},

							yAxis : {
								title : {
									text : 'Response Time(ms)'
								},
								min:0,
								plotLines : [ {

									value :
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
					                      
					                        out.println(res);%>
	,

									width : 1,
									//  color: '#808080',
									color : 'red',
									width : 2,

									label : {
										text : 'Threshold',
										x : 0,
										y : 15,

										style : {
											fontSize : '17px',
											//    fontFamily : 'Verdana, sans-serif'
											color : 'red'
										}

									},

									dashStyle : 'ShortDash'

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

								threshold :
<%out.println(res);
						              
						                
						        }
						    } catch (Exception e) {
						        e.printStackTrace();
						      
						    } finally {
						        alertData.close();
						    }%>
	,

								negativeColor : 'green',
								color : 'red',

								showInLegend : false,

								data : [
<%try{  
      		StringBuilder desktopdat = new StringBuilder();
                       String data2="";
                                StringBuilder mobiledat = new StringBuilder();
                              
                  
              
                  
                      if(null != request.getParameter("cmd"))
                      {
                         String  startTime ="";
                            String endTime="";
                           startTime = request.getParameter("startTime");
                          endTime = request.getParameter("endTime");
                     
                     
                     
                     
                    /// StringBuilder desktopdat = new StringBuilder();
                     // String data2="";
                               //StringBuilder mobiledat = new StringBuilder();
                            
                            //  Object[] values = null;
                              LiveResponseCustomized live = new LiveResponseCustomized();
                              
                                     
                             TreeMap<Long,String> data = live.getIPandURI(startTime,endTime);
                           //  ////System.out.println("RESULT : "+data);
                           //  ////System.out.println("RESULT Size : "+data.size());
                              for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
                              {
                                  Long timeInMillis = (Long) iterator.next();
                                     String IPURIRES = (String) data.get(timeInMillis);
                                     //////System.out.println("x axis="+timeInMillis);
                                    
                                
                                    
                            //       ////System.out.println("Y AXIS="+IPURIRES);
                                    
                                 String[] occurrences = IPURIRES.split("&&");
                            
                                 String IPURI=occurrences[0]+"_"+occurrences[1];
                                 String Response=occurrences[2];
                                 Double Res = Double.parseDouble(Response);
                           //  ////System.out.println(IPURI+"___"+Response);
                               //  ////System.out.println("Y AXIS  "+IPURI+Res);
                            
                                
                               
                                 mobiledat.append("{y:"+Res+",myData:'"+IPURI+"'},"); 

                              }
                  data2 = mobiledat.toString();
                  out.println(data2);
              //   ////System.out.println("yaxis ["+data2+"]");
                  }
    
                     
                      else
                      {
                     
                     
                      	  Live l =new Live();
                      	Map<Long,String> data = l.getResponseTimesForScatterGraph("","","","");
                //       ////System.out.println("at 231"+data);
                        for (Iterator iterator =   data.keySet().iterator(); iterator.hasNext();)
                  {
                        	   Long timeInMillis = (Long) iterator.next();
                        	   String IPURIRES = (String)data.get(timeInMillis);
                        	//	  ////System.out.println("xaxis="+timeInMillis);
							//		////System.out.println("YAXIS="+IPURIRES);
									String[] occurrences = IPURIRES.split("&&");
									 String IPURI=occurrences[0]+"_"+occurrences[1];
                        		     String Response=occurrences[2];
                        		    Integer Res = Integer.parseInt(Response);
                        		                            //
                        		//////System.out.println(IPURI+"___"+Response);
                        		                                //////System.out.println("Y AXIS  "+IPURI+Res);


                        		                                ;
                        		                            //    mobiledat.append(yValueRT+ ",");

                        		mobiledat.append("{y:"+Res+",myData:'"+IPURI+"'},");
                               //////System.out.println("x axis="+timeInMillis);
                              
                          
                              
                          //     ////System.out.println("Y AXIS="+IPURIRES);
                              
                                                 }

               data2 = mobiledat.toString();
               out.println(data2);
            //   ////System.out.println("x axis ["+data2+"]");
           }
     
     
                      
                  }
     catch(Exception ex)
             {
				ex.printStackTrace();
    	 final Logger logger = Logger.getRootLogger();
  	   logger.error("Unexpected error",ex);
			}%>
	],
								lineWidth : 3

							} ]
						});
	});
</script>

</head>
<body id="lrc">
	<%
		//Thread.sleep(2000);
		//response.setIntHeader("Refresh", 5);
		String sessionId = request.getParameter("id");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");

		startTime = startTime == null ? "" : startTime;
		endTime = endTime == null ? "" : endTime;

		String sourceEndpoint = request.getParameter("sourceEndpoint");
		String targetEndpoint = request.getParameter("targetEndpoint");

		////////System.out.println("In EPMSearchResult "+ startTime);
		////////System.out.println("In EPMSearchResult " + endTime);

		Boolean isOverviewLinkClicked = false;
	%>

	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>
	<div id="wrap">
		<div id="lmenuLive">
			<br>
			<center>
				<h1 id="custom_header">Customized Search</h1>
			</center>
			<form name="form" id="form"
				action="LiveResponseCustomized.jsp?role=<%out.println(role);%>"
				method="POST">

				<br>

				<center>Maximum limit is 200 from last</center>
				<br> <br> <font color="blue"><b> Start Time</b></font><input
					size="12" type="Text" id="demo1" name="startTime"
					value="<%=startTime%>"
					onclick="javascript:NewCssCal ('demo1','ddMMyyyy','dropdown',true,'24',true)"
					style="cursor: pointer" /> <br /> <br /> <font color="blue"><b>
						End Time </b></font><input size="12" type="Text" name="endTime" id="demo2"
					value="<%=endTime%>"
					onclick="javascript:NewCssCal ('demo2','ddMMyyyy','dropdown',true,'24',true)" />

				<br> &nbsp;&nbsp;
				<div id="error"></div>
				&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;
				&nbsp;&nbsp;&nbsp; &nbsp;

				<button name='cmd' onclick="return IsEmpty();">Submit</button>
			</form>

			<br /> <br />


			<ul id="treeMenu" style="margin-left: 20px; margin-top: 20px"></ul>


			<center>
				<h1 id="custom_header">Recent 10 Responses</h1>
				<br>
			</center>



			<form action="LiveResponseCustomized.jsp?role=<%out.println(role);%>"
				method="post">
				<font color="blue"> <B>IP address</B>
				</font><select name='IP' id='IP' onclick="getURL()">

					<%
						List alertData1 = CommonUtils.getAllIPandURL();
						for (int i = 0; i < alertData1.size(); i++) {

							String IP = (String) alertData1.get(i);
							//////System.out.println("IPPPPPPPPPPPPPPP"+IP);
							//String endpointDesc = (String) alertData.get(IP);
					%>
					<option value="<%=IP%>"><%=IP%></option>
					<%
						}
					%>

				</select> <br> <br>
				<div id="URL">
					<font color="blue"><b>
							URL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font> <select
						name='URL' id='URL1'>
						<option value='-1'>Select URL</option>
					</select><br> <br />
				</div>
				<div id="incidentime"></div>

				&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;
				&nbsp;&nbsp;&nbsp; &nbsp; <input type="button" value="Submit"
					onclick="createtable()"> <br></br>
				<div id="tab125"></div>


			</form>
		</div>


		<div id="graph_live"></div>



	</div>
	<%@include file="Footer.jsp"%>
</body>
</html>
