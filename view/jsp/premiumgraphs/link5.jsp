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
	background: green;
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

String link5_device=AveragePremiumResponseData.f;

StringBuilder link5_sb1 = new StringBuilder();
StringBuilder link5_sb2 = new StringBuilder();
StringBuilder link5_sb2_cpu = new StringBuilder();
StringBuilder link5_sb2_ram = new StringBuilder();
StringBuilder NetworkType = new StringBuilder();
DecimalFormat link5_df_cpu = new DecimalFormat("###.##");
DB link5_dbs = CommonDB.getBankConnection();
DBCollection link5_colls = link5_dbs.getCollection("Regular");
BasicDBObject link5_andQuery = new BasicDBObject();
List<BasicDBObject> link5_obj = new ArrayList<BasicDBObject>();
link5_obj.add(new BasicDBObject("StartTime", Long.parseLong(AveragePremiumResponseData.e)));

link5_obj.add(new BasicDBObject("UUID", link5_device.trim()));
link5_andQuery.put("$and", link5_obj);
DBCursor link5_cursor = link5_colls.find(link5_andQuery);
link5_cursor.sort(new BasicDBObject("_id",-1)).limit(24);
long link5_temp_ram = 0l;
DBCursor cursor5 = link5_colls.find(link5_andQuery);
List<DBObject> link5_list = link5_cursor.toArray();
for(int i = link5_list.size()-1;i >= 0 ; i--)
{
	int networkCase;
	DBObject obj2 = link5_list.get(i);
	String link5_s = obj2.get("duration").toString();
	String link5_requestTime = new SimpleDateFormat("HH:mm:ss").format(obj2.get("request_time"));
	String link5_rt = link5_df_cpu.format(Double.parseDouble(obj2.get("cpu").toString())).toString();
	link5_temp_ram=(Long)obj2.get("ram");
	link5_temp_ram=link5_temp_ram/1024;
	link5_sb1.append(link5_s+",");
	link5_sb2.append("'"+link5_requestTime+"',");
	link5_sb2_cpu.append(link5_rt+",");
	link5_sb2_ram.append(link5_temp_ram+",");
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
long link5_total = 0l;
long link5_cpu_temp = 0l;
long link5_battery_life = 0l;
String link5_stemp = null;
double link5_battery_temp = 0l;
while(cursor5.hasNext()){
	DBObject obj1 = cursor5.next();
	link5_total += (Long)obj1.get("duration");
	link5_cpu_temp += (Long)obj1.get("cpu_temp");
	link5_battery_life += (Long)obj1.get("battery_life");
	link5_stemp = obj1.get("battery_temp").toString();
	link5_battery_temp += Double.parseDouble(link5_stemp);
}

GetBandwidthPremiumUser link5_bdp  = new GetBandwidthPremiumUser();
int i =GetBandwidthPremiumUser.GetCrashData(link5_device.trim(),AveragePremiumResponseData.e);
StringBuilder link5_sbx = link5_bdp.GetData(link5_device.trim(), AveragePremiumResponseData.e);
long average = (link5_total / cursor5.size());
long average_batterylife = (link5_battery_life/cursor5.size());
long average_cputemp = (link5_cpu_temp/cursor5.size());
double average_batterytemp = (link5_battery_temp/cursor5.size());
System.out.println("---------------------------------"+average_batterylife+"  "+average_cputemp+"  "+average_batterytemp);
String average_batterytemptostring =  new DecimalFormat("#0.00").format(average_batterytemp);

int count=GetBandwidthPremiumUser.GetBuffer_thrashold_count(link5_device.trim(),AveragePremiumResponseData.e); 

long thresholdvalue=GetBandwidthPremiumUser.getresponsethreshold();

%>



<script>
	$(function() {
		$('#responsetime5').highcharts({
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
 <%=link5_sb2%>
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
				data : [<%=link5_sb1%>],
				color : '#0441ff'

			},

			]
		});
	});

	$(function() {
		$('#memoryutilization5').highcharts({
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
 <%=link5_sb2%>
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
				data : [<%=link5_sb2_ram
				       
				%>],
				color : '#0441ff'

			},

			]
		});
	});

	$(function() {

		$('#cpuutilization5').highcharts({
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
				categories : [
<%=link5_sb2%>
	],
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

				data : [<%=link5_sb2_cpu	
				%>],
				color : '#0441ff'

			},

			]
		});
	});
	
	<%-- $(function () {
	    $('#bandwidth5').highcharts({
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
	            categories: [<%=link5_sb2%>],
	            
	            labels : {
					enabled : true
				},
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: 'kb/sec'
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
	        	name : 'KB/sec',
				data : [<%=link5_sbx%>
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
		$('#bandwidth5')
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
<%=link5_sb2%>
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
	<b>User Experience on <%out.println(new SimpleDateFormat("dd MMM yyyy").format(Long.parseLong(AveragePremiumResponseData.e))+" at "+new SimpleDateFormat("HH:mm").format(Long.parseLong(AveragePremiumResponseData.e)));%></b>
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

<%String clr_b="green"; if (count>=5){clr_b="red"; }%>
<%-- <div id="buffercircle"
	style="text-align: center;  background: <%=clr_b%>; ">
	<p style="text-aling: center; padding-top: 40%; color: white"><%=count%>
	</p>
	<p id="circleText">Buffering Instances</p>
</div> --%>


<div
	style="height: 68%; width: 73%; background-color: white; color: black; margin-left: 25%; float: left; margin-top: 6%; position: absolute; padding-bottom: 6%">
	<div id="responsetime5"
		style="height: 35%; width: 45%; background-color: white; color: black; margin-left: 1%; float: left; margin-top: 4%; /* border-style: solid; border-width: medium; border-color: red; */ position: absolute;"></div>
	<div id="memoryutilization5"
		style="height: 35%; width: 45%; background-color: white; color: black; margin-left: 1%; */ float: left; margin-top: 30%; position: absolute; /* border-style: solid; border-width: medium; border-color: red; */ float: left;"></div>
	<div id="cpuutilization5"
		style="height: 35%; width: 50%; background-color: white; color: black; margin-top: 4%; float: left; margin-left: 48%; /* border-style: solid; border-width: medium; border-color: red; */ position: absolute;"></div>
	<div id="bandwidth5"
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
			<td>Temperature</td>
		</tr>

		<tr>
			<td><img src="../image/battery.png"
				style="width: 80px; height: 80px;"></td>
			<td><img src="../image/temp.png"
				style="width: 80px; height: 80px;"></td>
		</tr>

		<tr>
			<td><center><%=average_batterylife %>
					%
				</center></td>
			<td><center><%=average_batterytemptostring %>
					C
				</center></td>
		</tr>
	</table>

</div>