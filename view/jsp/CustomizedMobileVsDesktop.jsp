<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Map"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="com.avekshaa.cis.database.CommonUtils"%>
<%@page import="com.avekshaa.cis.engine.MobvsDes"%>
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
<%-- <%String role ="CIO";	%> --%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Experience | Incident data graph</title>
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link href="../css/treeMenu.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="styles/treeMenu.css" />
<link href="../css/header.css" rel="stylesheet" type="text/css" />



<link rel="stylesheet" href="../css/button.css">


<script src="../script/datetimepicker_css.js"></script>
<script type='text/javascript' src='../script/treeMenu.js'></script>
<script type='text/javascript' src='../script/jquery.js'></script>
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
		$('#graph_mob')
				.highcharts(

						{

							exporting : {
								enabled : false
							},

							chart : {

								type : 'spline',
								zoomType : 'xy',
								backgroundColor : 'white'

							},
							credits : {
								enabled : false
							},

							title : {

								text : 'Desktop vs Mobile'
							},
							subtitle : {
								text : 'comparision-Web Based access'
							},
							xAxis : {

								labels : {
									style : {
										fontSize : '13px',
										fontFamily : 'Verdana, sans-serif'
									}
								},

								type : 'datetime',
								dateTimeLabelFormats : { // don't display the dummy year
									/* millisecond: '%H:%M:%S.%L',
									day: '%e. %b',
									month: '%e. %b',
									year: '%b' */
									second : '%Y-%m-%d<br/>%H:%M:%S',
									minute : '%Y-%m-%d<br/>%H:%M',
									hour : '%Y-%m-%d<br/>%H:%M',
									day : '%Y<br/>%m-%d',
									week : '%Y<br/>%m-%d',
									month : '%Y-%m',
									year : '%Y'
								},
								title : {

									style : {
										color : 'black',
										fontWeight : 'bold',
										fontSize : '16px'
									},

								}
							},
							yAxis : {
								/*  title: {
								     text: 'Error Percentage'
								 }, */
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
								headerFormat : '<b>{series.name}</b><br>',
								pointFormat : '{point.x:%Y-%m-%d<br/>%H:%M:%S}: <b>{point.y:.2f}<b> milisecs'
							},

							plotOptions : {

								series : {
									lineWidth : 3
								},

								spline : {
									marker : {
										enabled : true
									}
								}
							},
							series : [

									{
										threshold :
<%out.println(res);
								              
								                
								        }
								    } catch (Exception e) {
								        e.printStackTrace();
								      
								    } finally {
								        alertData.close();
								    }%>
	,

										negativeColor : '#0000FF',//dark blue
										color : '#FF69B4', //pink         

										name : 'Desktop',

										// Define the data points. All series have a dummy year
										// of 1970/71 in order to be compared on the same x axis. Note
										// that in JavaScript, months start at 0 for January, 1 for February etc.
										data :
<%try
        { 
            
            String data2="";
            StringBuilder mobiledat = new StringBuilder();
           
           
           
            if(null != request.getParameter("cmd"))
            {
                  
                String startTime = request.getParameter("startTime");
                String endTime = request.getParameter("endTime");
          
           
           
                MobvsDes mob = new MobvsDes();
       Map<Map,Map> data = mob.mobvsdeskCust(startTime,endTime,"","");
        //////System.out.println("data "+data);
       
        for(Map<Map,Map> key:data.keySet())
        {
            ////////System.out.println("iteration"+key  +" :: "+ data.get(key));
           Map Mobile = key;
           for (Iterator iterator = Mobile.keySet().iterator(); iterator.hasNext();)
           {
           final    String Time = (String) iterator.next();
            final double Response = (Double) Mobile.get(Time);
                mobiledat.append("[Date.UTC("+Time+ "),"+Response+"]"+",");

                
           }
              }
           data2 = mobiledat.toString();
           out.println("["+data2+"]");
           //////System.out.println("["+data2+"]");
           }
           
            else
            {
                  MobvsDes mob = new MobvsDes();
                  Map<Map,Map> data = mob.mobVsDesk("","","","");
                   //////System.out.println("data "+data);
                
                   for(Map<Map,Map> key:data.keySet())
                   {
                       ////////System.out.println("iteration"+key  +" :: "+ data.get(key));
                      Map Mobile = key;
                      for (Iterator iterator = Mobile.keySet().iterator(); iterator.hasNext();)
                      {
                      final    String Time = (String) iterator.next();
                       final double Response = (Double) Mobile.get(Time);
                           mobiledat.append("[Date.UTC("+Time+ "),"+Response+"]"+",");

                        
                        
                   }
                      }
                   data2 = mobiledat.toString();
                   out.println("["+data2+"]");
                   //////System.out.println("Desktop Data["+data2+"]");
          
              
            }
           
       
           
           
           
           
           
           
           
           
        }
           catch(Exception ex){
              // ex.printStackTrace(); 
        	   final Logger logger = Logger.getRootLogger();
        	   logger.error("Unexpected error",ex);
           
           }
       
        finally
        {//////System.out.println("");
            }%>
	},
									{
										negativeColor : ' 	#3CB371',
										color : '  	 	#8B0000	',
										name : 'Mobile',
										data :
<%try{
   
    StringBuilder desktopdat = new StringBuilder();
    String data1="";
   
   
   
    if(null != request.getParameter("cmd"))
       {
           
   String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
     
   

    MobvsDes mob = new MobvsDes();
Map<Map,Map> data = mob.mobvsdeskCust(startTime,endTime,"","");

//////System.out.println("data "+data);

for(Map<Map,Map> key:data.keySet())
{
    ////////System.out.println("iteration"+key  +" :: "+ data.get(key));
   Map Desktop = data.get(key);
   for (Iterator iterator = Desktop.keySet().iterator(); iterator.hasNext();) {
       final     String Time = (String) iterator.next();
       final    double Response = (Double) Desktop.get(Time);
        //////System.out.println("Desktop Response Time"+Response);
        //////System.out.println("Desktop exec Time"+Time);
        desktopdat.append("[Date.UTC("+Time+ "),"+Response+"]"+",");
       
       
}}
data1 = desktopdat.toString();
out.println("["+data1+"]");
//////System.out.println("["+data1+"]");
}
   
    else
    {
               
        MobvsDes mob = new MobvsDes();
        Map<Map,Map> data = mob.mobVsDesk("","","","");
        System.out.println("data "+data);

        for(Map<Map,Map> key:data.keySet())
        {
            ////////System.out.println("iteration"+key  +" :: "+ data.get(key));
           Map Desktop = data.get(key);
           for (Iterator iterator = Desktop.keySet().iterator(); iterator.hasNext();) {
               final     String Time = (String) iterator.next();
               final    double Response = (Double) Desktop.get(Time);
             //   //////System.out.println("Desktop Response Time"+Response);
             //   //////System.out.println("Desktop exec Time"+Time);
                desktopdat.append("[Date.UTC("+Time+ "),"+Response+"]"+",");
             
             
        }}
        data1 = desktopdat.toString();
        out.println("["+data1+"]");
        //////System.out.println("Mobile["+data1+"]");
           
    }
   
   
   
   
   
   
   
}
       

   catch(Exception ex){
      //  ex.printStackTrace();  
	   final Logger logger = Logger.getRootLogger();
	   logger.error("Unexpected error",ex);
      }

finally
{//////System.out.println("");
    }%>
	} ]
						});
	});
</script>

</head>
<body>
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
		                       
		            Boolean isOverviewLinkClicked=false;
	%>



	<%@include file="Header.jsp"%>

	<%@include file="menu.jsp"%>
	<br>
	<br>
	<div id="wrap">

		<div id="lmenu">
			<br>
			<center>
				<br> <br>
				<h1 id="custom_header">Customized Search</h1>
			</center>
			<br>

			<form id="form"
				action="CustomizedMobileVsDesktop.jsp?role=<%out.println(role);%>"
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
			<%--  Session: <%= session.getAttribute( "endTime" ) %>       --%>
		</div>



		<div id="graph_mob">Select Proper Range (No data to display)</div>
	</div>
	<%@include file="Footer.jsp"%>
	<script>
		
	</script>
</body>
</html>
