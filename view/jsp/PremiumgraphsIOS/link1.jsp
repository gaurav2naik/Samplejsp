<%@page import="com.avekshaa.cis.premiumusers.GetBandwidthPremiumUser"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.avekshaa.cis.premiumusers.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="java.util.*"%>
<%@page import="com.avekshaa.cis.database.*"%>
<%@page import="java.text.NumberFormat"%>

<style>
#averespcircle {
	width: 80px;
	height: 80px;
	border-radius: 80px;
	margin-left: 28%;
}

#appcrashcircle {
	width: 80px;
	height: 80px;
	border-radius: 80px;
	margin-left: 53%;
	margin-top: -7%;
}

#buffercircle {
	width: 80px;
	height: 80px;
	border-radius: 80px;
	margin-left: 79%;
	margin-top: -7%;
}

#extra {
	float-left: left;
	margin-top: 25%;
	width: 22%;
	height: 160px;
}

#circleText {
	padding-top: 40%;
}
</style>


<%
		
		String device = AveragePremiumResponseData.f;
		StringBuilder sb1 = new StringBuilder();
		StringBuilder sb2 = new StringBuilder();
		StringBuilder sb2_cpu = new StringBuilder();
		StringBuilder sb2_ram = new StringBuilder();
		 StringBuilder NetworkType= new StringBuilder();
		DecimalFormat df_cpu = new DecimalFormat("###.##");
		DB dbs = CommonDB.getBankConnection();
		try{
		DBCollection colls = dbs.getCollection("IOSData");
		BasicDBObject andQuery = new BasicDBObject();
		List<BasicDBObject> obj = new ArrayList<BasicDBObject>();
		obj.add(new BasicDBObject("StartTime", Long.parseLong(AveragePremiumResponseData.a)));
		obj.add(new BasicDBObject("UUID", device.trim()));
		andQuery.put("$and", obj);
		DBCursor cursor = colls.find(andQuery);
		long total = 0l;
		DBCursor cursorlimit = colls.find(andQuery);
		cursorlimit.sort(new BasicDBObject("_id",-1)).limit(24);
		double temp_ram = 0l;
		List<DBObject> link1_list = cursorlimit.toArray();
		for(int i = link1_list.size()-1;i >= 0 ; i--)
		{
			   int networkCase;
			DBObject obj1 = link1_list.get(i);
			String s = obj1.get("duration").toString();
			String requestTime = new SimpleDateFormat("HH:mm:ss").format(obj1.get("request_time"));
			String rt = df_cpu.format(Double.parseDouble(obj1.get("cpu").toString())).toString();
			temp_ram=(Double)obj1.get("ram");
			temp_ram=temp_ram/1024;
			sb1.append(s+",");
			sb2.append("'"+requestTime+"',");
			sb2_cpu.append(rt+",");
			sb2_ram.append(temp_ram+",");
			 String Network=obj1.get("NetworkType").toString();
	         
   			switch (Network) {
case "Unknown":
	networkCase = 0;
	break;
case "2G":
	networkCase = 1;
	break;
case "3G":
	networkCase = 2;
	break;
case "4G":
	networkCase = 3;
	break;
case "WIFI":
	networkCase = 4;
	break;
default:
	networkCase = 0;
}
NetworkType.append(networkCase+ ",");
		}
		long cpu_temp = 0l;
		long battery_life = 0l;
		String stemp = null;
		double battery_temp = 0l;
		while(cursor.hasNext()){
			DBObject obj1 = cursor.next();
			total += (Integer)obj1.get("duration");
			
			battery_life += (Integer)obj1.get("battery_life");
			
			
		}
		GetBandwidthPremiumUser bdp  = new GetBandwidthPremiumUser();
		int i = GetBandwidthPremiumUser.GetCrashData(device.trim(),AveragePremiumResponseData.a);
		StringBuilder link1_sbx = bdp.GetData(device.trim(), AveragePremiumResponseData.a);
		long average = (total / cursor.size());
		long average_batterylife = (battery_life/cursor.size());
		long average_cputemp = (cpu_temp/cursor.size());
		
	    int count=GetBandwidthPremiumUser.GetBuffer_thrashold_count(device.trim(),AveragePremiumResponseData.a); 
	    
	    long thresholdvalue=GetBandwidthPremiumUser.getresponsethreshold();
		
%>


<script>
	$(function() {
		$('#responsetime').highcharts({
			exporting : {
				enabled : false
			},
			chart : {
				type : 'line',
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
				categories : [<%=sb2%>],
				labels : {
					enabled : true
				},
			},
			yAxis : {
				title : {
					text : 'Response (ms)'
				},
				min : 0,
				plotLines : [ {

					value : <%=thresholdvalue%>,

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
				/* valueSuffix : ' ms', */
				headerFormat: '<span style="font-size:10px;color:{series.color}">Time:</span><b>{point.key}</b><table>',
	            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	                '<td style="padding:0"><b>{point.y:.1f}ms </b></td></tr>',
	            footerFormat: '</table>',
	            shared: true,
	            useHTML: true
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
				<%=sb1%>
],
				color : '#0441ff'

			},

			]
		});
	});

	$(function() {
		$('#memoryutilization').highcharts({
			exporting : {
				enabled : false
			},
			chart : {
				type : 'line',
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
				categories : [<%=sb2%>],
				labels : {
					enabled : true
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
					color : '#0441ff'
				} ]
			},
			tooltip : {
				/* valueSuffix : ' MB', */
				headerFormat: '<span style="font-size:10px;color:{series.color}">Time:</span><b>{point.key}</b><table>',
	            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	                '<td style="padding:0"><b>{point.y:.1f}MB </b></td></tr>',
	            footerFormat: '</table>',
	            shared: true,
	            useHTML: true
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
				data : [ <%=sb2_ram%>],
				color : '#0441ff'

			},

			]
		});
	});

	$(function() {

		$('#cpuutilization').highcharts({
			exporting : {
				enabled : false
			},
			chart : {
				type : 'line',
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
				categories : [<%=sb2%>],
				labels : {
					enabled : true
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
					color : '#0441ff'
				} ]
			},
			tooltip : {
				/* valueSuffix : ' %', */
				headerFormat: '<span style="font-size:10px;color:{series.color}">Time:</span><b>{point.key}</b><table>',
	            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	                '<td style="padding:0"><b>{point.y:.1f}% </b></td></tr>',
	            footerFormat: '</table>',
	            shared: true,
	            useHTML: true
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

				data : [<%=sb2_cpu%>],

				color : '#0441ff'
				
			},

			]
		});
	});
	
	
	//network details
	$(function() {
		var change = {
			0 : 'No Network',
			1 : '2G',
			2 : '3G',
			3 : '4G',
			4 : 'WIFI'
		};
		$('#bandwidth')
				.highcharts(
						{
							exporting : {
								enabled : false
							},
							chart : {
								type : 'area'
							},
							title : {
								text : 'Network Details',
								x : -20
							//center
							},

							credits : {
								enabled : false
							},
							xAxis : {
								categories : [
<%=sb2%>
]
							},
							yAxis : {
								title : {
									text : 'Network Type'
								},
								labels : {
									formatter : function() {
										var value = change[this.value];
										return value !== 'undefined' ? value
												: this.value;
									}
								},
								tickInterval : 1,

							},
							tooltip : {
								formatter : function() {
									return this.x + '<br>' + '<b>'
											+ this.series.name + '</b>:'
											+ change[this.y];
								},

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
										name : 'Network Type',
										data : [
<%=NetworkType%>
],
										labels : {
											formatter : function() {
												var value = change[this.value];
												return value !== 'undefined' ? value
														: this.value;
											}
										},

										color : '#FF3300'

									},

							]
						});
	});
	
 $('.cssload-container').hide();
  
</script>

<p style="margin-left: 44%; margin-top: -1%; color: #001966">
	<b>User Experience on <%out.println(new SimpleDateFormat("dd MMM yyyy").format(Long.parseLong(AveragePremiumResponseData.a))+" at "+new SimpleDateFormat("HH:mm").format(Long.parseLong(AveragePremiumResponseData.a)));%></b>
</p>
<%String clr_av="green"; if (average>=thresholdvalue){clr_av="red"; }%>
<div id="averespcircle"
	style="text-align: center; background: <%=clr_av%>;">
	<p style="text-aling: center; padding-top: 40%; color: white"><%=average%>
		(ms)
	</p>
	<p id="circleText">Average Response Time</p>
</div>

<%String clr_c="green"; if (i>=1){clr_c="red"; }%>
<div id="appcrashcircle"
	style="text-align: center;  background: <%=clr_c%>;">
	<p style="text-aling: center; padding-top: 40%; color: white"><%=i%></p>
	<p id="circleText">Application Crash</p>
</div>

<%String clr="green"; if (count>=5){clr="red"; }%>
<%-- <div id="buffercircle"
	style="text-align: center;  background: <%=clr%>; ">
	<p style="text-aling: center; padding-top: 40%; color: white"><%=count%>
	</p>
	<p id="circleText">Buffering Instances</p>
</div> --%>


<div
	style="height: 68%; width: 73%; background-color: white; color: black; margin-left: 25%; float: left; margin-top: 6%; position: absolute; padding-bottom: 6%">

	<div id="responsetime"
		style="height: 35%; width: 45%; background-color: white; color: black; margin-left: 1%; float: left; margin-top: 4%; /* border-style: solid; border-width: medium; border-color: red ;*/ position: absolute;"></div>
	<div id="memoryutilization"
		style="height: 35%; width: 45%; background-color: white; color: black; margin-left: 1%; */ float: left; margin-top: 30%; position: absolute; /* border-style: solid; border-width: medium; border-color: red; */ float: left;"></div>
	<div id="cpuutilization"
		style="height: 35%; width: 50%; background-color: white; color: black; margin-top: 4%; float: left; margin-left: 48%; /* border-style: solid; border-width: medium; border-color: red; */ position: absolute;"></div>
	<div id="bandwidth"
		style="height: 35%; width: 50%; background-color: white; color: black; margin-left: 48%; float: left; margin-top: 30%; /* border-style: solid; border-width: medium; border-color: red; */ position: absolute;"></div>
</div>


<div id="extra">
	<table>

		<tr>
			<th style="color: #001966">Battery</th>
			<th></th>
		</tr>

		<tr>
			<td></td>
			<td></td>
		</tr>

		<tr>
			<td><img src="../image/battery.png"
				style="width: 80px; height: 80px;"></td>
			
		</tr>

		<tr>
			<td><center><%=average_batterylife %>
					%
				</center></td>
			
		</tr>
	</table>
	<%}catch(Exception e){
		e.printStackTrace();
	System.out.println("Exception Caught inside link1.jsp");
} %>
</div>
