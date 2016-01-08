<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.avekshaa.cis.database.*"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="java.util.List"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%
	String role = (String) session.getAttribute("Role");
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Customer Experience | Premium User</title>

<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>
<link rel="stylesheet" type="text/css" href="../css/index.css" />
<script type="text/javascript" src="../script/styleswitcher.js"></script>
<link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='../script/treeMenu.js'></script>

<link rel="stylesheet" type="text/css" href="../css/index.css" />
<script type="text/javascript" src="../script/styleswitcher.js"></script>

<link rel="stylesheet" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />



<style>
.body1 {
	height: 550px;
	width: 1100px;
	/* margin: 5%; */
	/* margin-top: 5%; */
	margin-left: 15%;
	background-image: url('../image/tablet_1.png');
	background-size: 1000px 500px;
	background-repeat: no-repeat;
}

#premiumUserSelect {
	margin-top: 20px;
	padding: 5px;
}
</style>

</head>

<%
	DB dbs1=CommonDB.getConnection();
 DBCollection colls1 = dbs1.getCollection("ThresholdDB");
 BasicDBObject objs1 = new BasicDBObject("_id",-1);
 
 DBCursor values1=colls1.find().sort(objs1).limit(1);
 DBCursor alertData =null;
 try {
 
 List<DBObject> dbObjss1 = values1.toArray();
 
     
 long threshold=0;
 
 for (int i = dbObjss1.size()-1; i >= 0; i--)
 {
     DBObject txnDataObject = dbObjss1.get(i);
    
     threshold=(Integer)txnDataObject.get("Android_thresholds");
    
    
 }
 
 String Device=request.getParameter("Device");
 System.out.print("Deviec name:"+Device);
 DB dbs=CommonDB.AndroidConnection();
 DBCollection colls = dbs.getCollection("Regular");
 
    BasicDBObject findObj1 = new BasicDBObject("UUID",Device.trim());
                //System.out.println(findObj1);
      alertData = colls.find(findObj1);
    	
      //System.out.println(alertData);
    alertData.sort(new BasicDBObject("_id", -1));
   alertData.limit(50);  //limiting to lasr 50 data only       
    
    List<DBObject> dbObjss = alertData.toArray();
   String MobileName=dbObjss.get(0).get("Mobilename").toString();
   
    StringBuilder startTime= new StringBuilder(); StringBuilder cpu=new StringBuilder(); StringBuilder ram= new StringBuilder(); StringBuilder req= new StringBuilder() ; StringBuilder res= new StringBuilder(); StringBuilder dur= new StringBuilder();
    long temp_ram ; String t1 ;  StringBuilder final_value=new StringBuilder() ; StringBuilder Info_device = new StringBuilder();StringBuilder Catagory_value = new StringBuilder();
    
    StringBuilder battery_percentage= new StringBuilder();
    StringBuilder battery_detail= new StringBuilder();
    StringBuilder battery_temperature= new StringBuilder();
    StringBuilder battery_temp_detail= new StringBuilder();
    
    StringBuilder cpu_temperature= new StringBuilder();
    StringBuilder cpu_temp_detail= new StringBuilder();
    
    String Smiley=null;
    
    DecimalFormat df = new DecimalFormat("###.##");
    DecimalFormat df1 = new DecimalFormat("###");
    int c=11;
    for (int i = dbObjss.size()-1; i >= 0; i--) 
    {
     
     DBObject txnDataObject = dbObjss.get(i);
   
     
     String info_mob=((String)txnDataObject.get("Mobilename")+", "+(String)txnDataObject.get("acitvity_name"));
     
     cpu.append( df.format(Double.parseDouble(txnDataObject.get("cpu").toString()))).append(",");
     
    
     
     //convert ram kilobytes in mb
     
     temp_ram=(Long)txnDataObject.get("ram");
     temp_ram=temp_ram/1024;
     ram.append(temp_ram +",");
     
     
     //convert in time format from long
     t1= new SimpleDateFormat("dd/MM/yyyy : HH:mm:ss").format(txnDataObject.get("request_time"));
     req.append("'" +t1+ ", " +info_mob+"',");
     
     
     if((Long)txnDataObject.get("battery_life")!=null)
     {
   	 battery_percentage.append((Long)txnDataObject.get("battery_life")+",");
   	 
   	 
   	 String t2=new SimpleDateFormat("dd/MM/yyyy : HH:mm:ss").format(txnDataObject.get("response_time"));
   	 battery_detail.append("'" +t2+ ", " +(String)txnDataObject.get("Mobilename")+"',");
   	 
   	 
   	 
     }
     
     //Added Cpu and battery Temp on 8th oct15
     Double BatteryTemp=0d;
     try{
      	 BatteryTemp=Double.parseDouble(txnDataObject.get("battery_temp").toString());
     }catch(ClassCastException ce){
 		System.out.println("Exception Caught while casting Battery Temp"+ce);
 	} 
      	if(BatteryTemp!=0d)
	      {
	    	/* int Battery_Temp=Integer.parseInt(txnDataObject.get("battery_temp").toString()); */
	    	
	    	  battery_temperature.append(df1.format(BatteryTemp)+",");
	    	 //already formatted battery temp to ### format , fromatting here cause previous data is not formatted. 
	    	
	    	  String t2=new SimpleDateFormat("dd/MM/yyyy : HH:mm:ss").format(txnDataObject.get("response_time"));
	    	  battery_temp_detail.append("'" +t2+ ", " +(String)txnDataObject.get("Mobilename")+"',");
	    	  
	    	  
	    	  
	      }
	      
	      
	      if((Long)txnDataObject.get("cpu_temp")!=null)
	      {
	    	 
	    	  cpu_temperature.append((Long)txnDataObject.get("cpu_temp")+",");
	    	 
	    	 
	    	  String t2=new SimpleDateFormat("dd/MM/yyyy : HH:mm:ss").format(txnDataObject.get("response_time"));
	    	  cpu_temp_detail.append("'" +t2+ ", " +(String)txnDataObject.get("Mobilename")+"',");
	    	  
	    	  
	      }
          
          dur.append((Long)txnDataObject.get("duration")+","); 
          
          
          
          
          Long dur_compare=Long.parseLong(txnDataObject.get("duration").toString());
          
        if(dur_compare>threshold)
        {
        c++;
        }
        
    }
    
    if(c<10)
    {
    	Smiley="../../smiley/smiley_green.jsp";
    }
   else if(c>=10 && c<20)
    {
    	Smiley="../../smiley/smiley_yellow.jsp";
    } 
    else if(c>=20)
    {
    	Smiley="../../smiley/smiley_red.jsp";
    }
%>


<%--  <%
 DataThread Dt= new DataThread();
    Dt.start();
 %> --%>


<script>
	$(function() {

		$('#container1').highcharts({
			exporting : {
				enabled : false
			},
			chart : {
				type : 'area',
				zoomType : 'x'
			},

			title : {
				text : 'CPU Usage %',
				x : -20
			//center
			},
			/* subtitle: {
			    text: 'Source: WorldClimate.com',
			    x: -20
			}, */
			xAxis : {
				categories : [
<%=req%>
	],
				labels : {
					enabled : false
				}
			},
			yAxis : {
				title : {
					text : 'CPU Usage (%)'
				},
				min : 0,
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#0000FF'
				} ]
			},
			tooltip : {
				valueSuffix : ' %'
			},
			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle',
				borderWidth : 0
			},

			credits : {
				enabled : false

			},

			series : [

			{

				showInLegend : false,

				name : 'CPU usage',

				data : [
<%=cpu%>
	],

				color : '#0000FF'

			},

			]
		});
	});

	$(function() {
		$('#container2').highcharts({
			exporting : {
				enabled : false
			},
			chart : {
				type : 'area',
				zoomType : 'x'
			},
			title : {
				text : 'RAM Usage (MB)',
				x : -20
			//center
			},
			/* subtitle: {
			    text: 'Source: WorldClimate.com',
			    x: -20
			}, */
			credits : {
				enabled : false

			},
			xAxis : {
				categories : [
<%=req%>
	],
				labels : {
					enabled : false
				},
			},
			yAxis : {
				title : {
					text : 'RAM Usage'
				},
				min : 0,
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#660033'
				} ]
			},
			tooltip : {
				valueSuffix : ' MB'
			},
			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle',
				borderWidth : 0
			},

			series : [

			{

				showInLegend : false,
				name : 'RAM usage',
				data : [
<%=ram%>
	],
				color : '#660033'

			},

			]
		});
	});

	$(function() {
		$('#container3').highcharts({
			exporting : {
				enabled : false
			},
			chart : {
				type : 'area',
				zoomType : 'x'
			},
			title : {
				text : 'Response (ms)',
				x : -20
			//center
			},
			/* subtitle: {
			    text: 'Source: WorldClimate.com',
			    x: -20
			}, */
			credits : {
				enabled : false

			},
			xAxis : {
				categories : [
<%=req%>
	],
				labels : {
					enabled : false
				},
			},
			yAxis : {
				title : {
					text : 'Response (ms)'
				},
				min : 0,
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#660033'
				} ]
			},
			tooltip : {
				valueSuffix : ' ms'
			},
			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle',
				borderWidth : 0
			},

			series : [

			{

				showInLegend : false,
				name : 'Response time',
				data : [
<%=dur%>
	],
				color : '#FF3300'

			},

			]
		});
	});

	$(function() {
		$('#container4').highcharts({
			exporting : {
				enabled : false
			},
			chart : {
				type : 'area',
				zoomType : 'x'
			},
			title : {
				text : 'Battery Percentage',
				x : -20
			//center
			},

			credits : {
				enabled : false
			},
			xAxis : {
				categories : [
<%=battery_detail%>
	],
				labels : {
					enabled : false
				}
			},
			yAxis : {
				title : {
					text : 'Battery %'
				},
				min : 0,
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#808080'
				} ]
			},
			tooltip : {
				valueSuffix : '%'
			},
			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle',
				borderWidth : 0
			},

			series : [

			{
				showInLegend : false,
				name : 'Battery %',
				data : [
<%=battery_percentage%>
	],
				color : '#164016'

			},

			]
		});
	});

	//////////////////
	$(function() {
		$('#container5').highcharts({
			exporting : {
				enabled : false
			},
			chart : {
				type : 'area',
				zoomType : 'x'
			},
			title : {
				text : 'Cpu Temperature',
				x : -20
			//center
			},

			credits : {
				enabled : false
			},
			xAxis : {
				categories : [
<%=cpu_temp_detail%>
	],
				labels : {
					enabled : false
				}
			},
			yAxis : {
				title : {
					text : 'Celsius'
				},
				min : 0,
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#808080'
				} ]
			},
			tooltip : {
				valueSuffix : ' C'
			},
			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle',
				borderWidth : 0
			},

			series : [

			{
				showInLegend : false,
				name : 'CPU Temperature (C)',
				data : [
<%=cpu_temperature%>
	],
				color : '#208120'

			},

			]
		});
	});

	$(function() {
		$('#container6').highcharts({
			exporting : {
				enabled : false
			},
			chart : {
				type : 'area',
				zoomType : 'x'
			},
			title : {
				text : 'Battery Temperature',
				x : -20
			//center
			},

			credits : {
				enabled : false
			},
			xAxis : {
				categories : [
<%=battery_temp_detail%>
	],
				labels : {
					enabled : false
				}
			},
			yAxis : {
				title : {
					text : 'Celsius'
				},
				min : 0,
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#808080'
				} ]
			},
			tooltip : {
				valueSuffix : ' C'
			},
			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle',
				borderWidth : 0
			},

			series : [

			{
				showInLegend : false,
				name : 'Battery Temperature (C)',
				data : [
<%=battery_temperature%>
	],
				color : '#A00000'

			},

			]
		});
	});
</script>


<body id="pu">
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>

	<div id="premiumUserSelect" align="center">
		<form action="Hotuser.jsp?role=<%out.println(role);%>" method="post">
			Premium user : <select name='Device' id='Device'>

				<%
					List Devicename = CommonUtils.getPremiumdevice();
						////System.out.println("Premium device"+Devicename);
						for (int i = 0; i < Devicename.size(); i++) {

							String IP = Devicename.get(i).toString().trim();

							String DeviceRequested = request.getParameter("Device")
									.trim();
							//System.out.println(IP.length()+" "+DeviceRequested.length());
							//////System.out.println("IPPPPPPPPPPPPPPP"+IP);
							//String endpointDesc = (String) alertData.get(IP);
							//System.out.println("Request Object:"+request.getParameter("Device"));
				%>
				<option value="<%out.println(IP);%>"
					<%if (!request.getParameter("Device").equals(null)) {
						if (IP.equals(DeviceRequested)) {
							out.print("selected");
						}
					}%>>
					<%
						out.println(IP);
					%>
				</option>
				<%
					}
				%>

			</select>
			<button name='cmd' onclick="return IsEmpty();">Submit</button>
		</form>
	</div>
	<br>
	<div id="header-left" style="display: inline-block; margin-left: 20%"
		align="left"><jsp:include page="<%=Smiley%>" /></div>
	<div id="header-right" style="display: inline-block; margin-left: 8%"
		align="center">
		<h1>
			Device Name : <font color="Red"> <%
 	out.println(MobileName);
 %>
			</font>
		</h1>
	</div>
	<%--  <div id="Header" align="right" ><h1>Device Name : <font color="Red" > <%
  out.println(request.getParameter("Device"));
 %> </font></h1></div> --%>
	<div class="body1">

		<div
			style="margin-left: 90px; /* margin-top: 10px; */ position: relative;">

			<div id="container1"
				style="padding: 5px; height: 115px; width: 398px; margin-top: 58px; display: inline-block; position: relative;"></div>
			<div id="container2"
				style="padding: 5px; height: 115px; width: 398px; display: inline-block; position: relative;"></div>
		</div>

		<div style="position: relative; margin-left: 90px;">

			<div id="container3"
				style="padding: 5px; height: 115px; width: 398px; margin-top: 0px; display: inline-block; position: relative;"></div>
			<div id="container4"
				style="padding: 5px; height: 115px; width: 398px; display: inline-block; position: relative;"></div>
		</div>

		<div style="position: relative; margin-left: 90px;">

			<div id="container5"
				style="padding: 5px; height: 115px; width: 398px; margin-top: 0px; display: inline-block; position: relative;"></div>

			<div id="container6"
				style="padding: 5px; height: 115px; width: 398px; margin-top: 0px; display: inline-block; position: relative;"></div>

		</div>


	</div>

	<%@include file="Footer.jsp"%>
</body>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		values1.close();
		alertData.close();
	}
%>



</html>