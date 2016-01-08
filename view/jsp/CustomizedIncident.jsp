<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@page import="com.avekshaa.cis.database.CommonUtils"%>
<%@page import="com.avekshaa.cis.engine.CustomizedIncident"%>
<%@page import="com.avekshaa.cis.engine.Incident"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Experience | Incident data graph</title>
<link rel="icon" href="../image/title.png" type="image/png">
<link rel="stylesheet" type="text/css" href="styles/treeMenu.css" />
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link href="../css/treeMenu.css" rel="stylesheet" type="text/css" />
<link href="../css/header.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="../css/button.css">
<%
	String role = (String) session.getAttribute("Role");
%>

<script src="../script/datetimepicker_css.js"></script>
<script type='text/javascript' src='../script/treeMenu.js'></script>
<script type='text/javascript' src='../script/CISloadgraph.js'></script>
<script type='text/javascript' src='../script/jquery.js'></script>
<script type='text/javascript' src='../script/ajaxcalls.js'></script>
<script type='text/javascript' src='../script/createtable.js'></script>
<script src="../script/jquery.min.js"></script>
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
		$('#graph_incident')
				.highcharts(
						{

							exporting : {
								enabled : false
							},
							chart : {
								type : 'line',
								zoomType : 'xy',
								backgroundColor : 'white'
							},

							credits : {
								enabled : false
							},
							title : {
								text : 'Incident Graph',
								x : -20
							//center
							},
							subtitle : {
								text : 'Page hit',
								x : -20
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
<%try
                { 
                	String startTime = request.getParameter("startTime");
                    String endTime = request.getParameter("endTime");
                	String data2="";
                    StringBuilder mobiledat = new StringBuilder();
                    if(null != request.getParameter("cmd"))
                    {
                CustomizedIncident incident = new CustomizedIncident();
               Map<Long,Double> data = incident.incident(startTime , endTime);
                //////System.out.println("data "+data);
               
              
                   for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
                   {
                   final    Long Time = (Long) iterator.next();
                    final double Response = (double) data.get(Time);
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
            		String DtimeInDateFormat = sdf.format(Time);
                        mobiledat.append("'"+DtimeInDateFormat+ "',");

                       
                       
                }
                data2 = mobiledat.toString();
                out.println(data2);
                //////System.out.println("x axis"+data2);
                }
                    else {
                    	 Incident incident = new Incident();
                         Map<Long,Double> data = incident.incident();
                          //////System.out.println("data "+data);
                         
                        
                             for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
                             {
                             final    Long Time = (Long) iterator.next();
                              final double Response = (double) data.get(Time);
                              SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
                      		String DtimeInDateFormat = sdf.format(Time);
                                  mobiledat.append("'"+DtimeInDateFormat+ "',");

                                 
                                 
                          }
                          data2 = mobiledat.toString();
                          out.println(data2);
                          //////System.out.println("x axis"+data2);
                         }
                    
                    }
               
                   catch(Exception ex){
                      // ex.printStackTrace();
                	   final Logger logger = Logger.getRootLogger();
                	   logger.error("Unexpected error",ex);
                      }%>
	]
							},

							//here
							yAxis : {
								min : 0,
								max : 100,
								title : {
									text : 'Error Percentage'
								},

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
									return 'Time  : <b>' + this.x
											+ '</b><br>% Response error : <b>'
											+ this.y + '</b> %';
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

								data : [
<%try
        {    	String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
    	String data2="";
    	 StringBuilder mobiledat = new StringBuilder();
    	if(null != request.getParameter("cmd"))
        {
       
        CustomizedIncident incident = new CustomizedIncident();
   Map<Long,Double> data = incident.incident(startTime , endTime);
        //////System.out.println("data "+data);
           for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
           {
           final    Long Time = (Long) iterator.next();
            final double Response = (double) data.get(Time);
                mobiledat.append(+Response+",");
        }
        data2 = mobiledat.toString();
        out.println(data2);
        //////System.out.println("yaxis"+data2);
        }
    	else{
    		Incident incident = new Incident();
        Map<Long,Double> data = incident.incident();
        //////System.out.println("data "+data);
           for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
           {
           final    Long Time = (Long) iterator.next();
            final double Response = (double) data.get(Time);
                mobiledat.append(+Response+",");
        }
        data2 = mobiledat.toString();
        out.println(data2);
        //////System.out.println("yaxis"+data2);
    		
    	}
    	}
       
           catch(Exception ex){
               //ex.printStackTrace(); 
        	   final Logger logger = Logger.getRootLogger();
        	   logger.error("Unexpected error",ex);
               }
       
        finally
        {//////System.out.println("");
            }%>
	]
							} ]
						});
	});
</script>

</head>
<body id="ci">
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

		<div id="lmenu">

			<center>
				<br> <br>
				<h5 id="custom_header">Customized Search</h5>
			</center>

			<div id="incident_form" style="margin-left: 5%; margin-right: 2.5%">
				<form name="form"
					action="CustomizedIncident.jsp?role=<%out.println(role);%>"
					method="POST">

					<font color="blue"><b> Start Time</b></font><input size="12"
						type="Text" id="demo1" name="startTime" value="<%=startTime%>"
						onclick="javascript:NewCssCal ('demo1','ddMMyyyy','dropdown',true,'24',true)"
						style="cursor: pointer" /> <br /> <br /> <font color="blue"><b>
							End Time </b></font><input size="12" type="Text" name="endTime" id="demo2"
						value="<%=endTime%>"
						onclick="javascript:NewCssCal ('demo2','ddMMyyyy','dropdown',true,'24',true)" />

					<br> &nbsp;&nbsp;
					<div id="error"></div>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button name='cmd' onclick="return IsEmpty();">Submit</button>
				</form>
				<!--  SESSION-TESTING -->
				<%--  Session: <%= session.getAttribute( "startTime" ) %><br> --%>
				<%--  Session: <%= session.getAttribute( "endTime" ) %> --%>







			</div>
		</div>



		<div id="graph_incident"></div>
	</div>
	<%@include file="Footer.jsp"%>
</body>
</html>
