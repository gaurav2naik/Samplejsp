<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.avekshaa.cis.premiumusers.*"%>
<%@page import="com.avekshaa.cis.premiumusers.GetBandwidthPremiumUser"%>
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
	background: green;
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
String link2_device = AveragePremiumResponseData.f;
StringBuilder link2_sb1 = new StringBuilder();
StringBuilder link2_sb2 = new StringBuilder();
StringBuilder link2_sb2_cpu = new StringBuilder();
StringBuilder link2_sb2_ram = new StringBuilder();
StringBuilder NetworkType = new StringBuilder();
DecimalFormat link2_df_cpu = new DecimalFormat("###.##");
DB link2_dbs = CommonDB.getBankConnection();
DBCollection link2_colls = link2_dbs.getCollection("IOSData");
BasicDBObject link2_andQuery = new BasicDBObject();
List<BasicDBObject> link2_obj = new ArrayList<BasicDBObject>();
link2_obj.add(new BasicDBObject("StartTime", Long.parseLong(AveragePremiumResponseData.b)));
link2_obj.add(new BasicDBObject("UUID", link2_device.trim()));
link2_andQuery.put("$and", link2_obj);
DBCursor link2_cursor = link2_colls.find(link2_andQuery);
link2_cursor.sort(new BasicDBObject("_id",-1)).limit(24);
DBCursor cursor2 = link2_colls.find(link2_andQuery);
double link2_temp_ram = 0l;


List<DBObject> link2_list = link2_cursor.toArray();
for(int i = link2_list.size()-1;i >= 0 ; i--)
{
	int networkCase;
	DBObject obj2 = link2_list.get(i);
	String link2_s = obj2.get("duration").toString();
	String link2_requestTime = new SimpleDateFormat("HH:mm:ss").format(obj2.get("request_time"));
	String link2_rt = link2_df_cpu.format(Double.parseDouble(obj2.get("cpu").toString())).toString();
	link2_temp_ram=(Double)obj2.get("ram");
	link2_temp_ram=link2_temp_ram/1024;
	link2_sb1.append(link2_s+",");
	link2_sb2.append("'"+link2_requestTime+"',");
	link2_sb2_cpu.append(link2_rt+",");
	link2_sb2_ram.append(link2_temp_ram+",");
	
	 String Network=obj2.get("NetworkType").toString();
     
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

long link2_total = 0l;

int link2_battery_life = 0;
/* int i=1; */
while(cursor2.hasNext()){
	//System.out.print(i++);
	DBObject obj1 = cursor2.next();
	link2_total += (Integer)obj1.get("duration");
	
	link2_battery_life += (Integer)obj1.get("battery_life");
	
	
}

GetBandwidthPremiumUser link2_bdp  = new GetBandwidthPremiumUser();
int i = GetBandwidthPremiumUser.GetCrashData(link2_device.trim(),AveragePremiumResponseData.b);
StringBuilder link2_sbx = link2_bdp.GetData(link2_device.trim(), AveragePremiumResponseData.b);
long average = (link2_total / cursor2.size());
long average_batterylife = (link2_battery_life/cursor2.size());

int count=GetBandwidthPremiumUser.GetBuffer_thrashold_count(link2_device.trim(),AveragePremiumResponseData.b); 

long thresholdvalue=GetBandwidthPremiumUser.getresponsethreshold();
%>

<script>
	$(function() {
		$('#responsetime2').highcharts({
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
				categories : [
<%=link2_sb2%>
	],
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
				data : [<%=link2_sb1%>],
				color : '#0441ff'

			},

			]
		});
	});

	$(function() {
		$('#memoryutilization2').highcharts({
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
				categories : [
<%=link2_sb2%>
	],
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
				data : [<%=link2_sb2_ram%>],
				color : '#0441ff'

			},

			]
		});
	});

	$(function() {

		$('#cpuutilization2').highcharts({
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
			    text: 'Source: W</div>

orldClimate.com',
			    x: -20
			}, */
			xAxis : {
				categories : [<%=link2_sb2%>],
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

				data : [<%=link2_sb2_cpu%>],

				color : '#0441ff'

			},

			]
		});
	});
	
	<%-- $(function () {
	    $('#bandwidth2').highcharts({
	        chart: {
	            type: 'scatter'
	        },
	        title: {
	            text: 'Buffering Details'
	        },
	        exporting : {
				enabled : false
			},
	        
	        credits : {
				enabled : false

			},
	      
	        xAxis: {
	            categories: [<%=link2_sb2%>],
	            
	            labels : {
					enabled : true
				},
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: 'KB/sec'
	            }
	        },
	        tooltip: {
	        	headerFormat: '<span style="font-size:10px;color:{series.color}">Time:</span><b>{point.key}</b><table>',
	            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	                '<td style="padding:0"><b>{point.y:.1f} </b></td></tr>',
	            footerFormat: '</table>',
	            shared: true,
	            useHTML: true
	        },
	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	        series: [{
	        	showInLegend : false,
	        	name : 'kb/sec',
				data : [<%=link2_sbx%>
	],
				color : ' #FFA500'
	        }]
	    });
	}); --%>
	
	//network details
	$(function() {
		var change = {
			0 : 'No Network',
			1 : '2G',
			2 : '3G',
			3 : '4G',
			4 : 'WIFI'
		};
		$('#bandwidth2')
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
<%=link2_sb2%>
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


<%-- <div id="circle" style="text-align: center;" ><p style = "text-aling : center; padding-top : 27px; color : white"><%=average%>  (ms)</p></div>
 --%>
<p style="margin-left: 44%; margin-top: -1%; color: #001966">
	<b>User Experience on <%out.println(new SimpleDateFormat("dd MMM yyyy").format(Long.parseLong(AveragePremiumResponseData.b))+" at "+new SimpleDateFormat("HH:mm").format(Long.parseLong(AveragePremiumResponseData.b)));%></b>
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

	<div id="responsetime2"
		style="height: 35%; width: 45%; background-color: white; color: black; margin-left: 1%; float: left; margin-top: 4%; /* border-style: solid; border-width: medium; border-color: red; */ position: absolute;"></div>
	<div id="memoryutilization2"
		style="height: 35%; width: 45%; background-color: white; color: black; margin-left: 1%; */ float: left; margin-top: 30%; position: absolute; /* border-style: solid; border-width: medium; border-color: red; */ float: left;"></div>
	<div id="cpuutilization2"
		style="height: 35%; width: 50%; background-color: white; color: black; margin-top: 4%; float: left; margin-left: 48%; /* border-style: solid; border-width: medium; border-color: red; */ position: absolute;"></div>
	<div id="bandwidth2"
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
			<td align="center">Life</td>
			
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

</div>