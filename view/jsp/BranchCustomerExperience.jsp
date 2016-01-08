<%@page import="com.avekshaa.cis.engine.GetChartDataForBranch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.avekshaa.cis.jio.GetChartData"%>
<%@page import="java.util.List"%>
<%@page import="com.avekshaa.cis.database.CommonUtils"%>


<%
	String role = (String) session.getAttribute("Role");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/button.css">
<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script>

<title>Customer Experience|CIS</title>
<style type="text/css">
#graph1 {
	height: 27%;
	width: 17%;
	background: white;
	color: white;
	margin-left: 5%;
	margin-top: 23%;
	float: left;
	/*  margin-right: 1%;
	border-style: solid;
	border-width: medium;
	 border-color: yellow; */
	background-color: white;
	position: absolute;
}

#graph2 {
	height: 27%;
	width: 17%;
	background: white;
	color: white;
	margin-left: 45%;
	margin-top: 23%;
	float: left;
	/* margin-right: 1%; 
	border-style: solid;
	border-width: medium;
	 border-color: yellow; */
	background-color: white;
	position: absolute;
}

#graph3 {
	height: 27%;
	width: 17%;
	background: white;
	color: white;
	margin-left: 54%;
	margin-top: 23%;
	float: left;
	/* margin-right: 1%; 
	border-style: solid;
	border-width: medium;
	 border-color: yellow; */
	background-color: white;
	position: absolute;
}

#graph4 {
	height: 27%;
	width: 17%;
	background: white;
	color: white;
	margin-left: 78%;
	margin-top: 23%;
	float: left;
	/* margin-right: 1%; 
	border-style: solid;
	border-width: medium;
	border-color: yellow; */
	background-color: white;
	position: absolute;
}

#graph5 {
	height: 34%;
	width: 42%;
	background: white;
	color: white;
	margin-left: 5%;
	margin-top: 4%;
	float: left;
	/* margin-right: 1%; 
	border-style: solid;
	border-width: medium;
	border-color: yellow; */
	background-color: white;
	position: absolute;
}

#graph6 {
	height: 34%;
	width: 42%;
	background: white;
	color: white;
	margin-left: 51%;
	margin-top: 4%;
	float: left;
	/* margin-right: 1%; 
	border-style: solid;
	border-width: medium;
	border-color: yellow; */
	background-color: white;
	position: absolute;
}
</style>
<script type="text/javascript">
	function loadGraph() {
		console.log("loadGraph is called");
		$('#graph5').load('../Graph/Branch/avgResponsePerMin.jsp');
		$('#graph6').load('TopFiveUrl.jsp');
		loadResponseAcrossApplicationVer();
		loadResponseAcrossAndroidVer()
		/* loadBufferAcrossApplicationVer();
		loadBufferAcrossAndroidVer(); */

		// 		loadHitsCount();
	}

	var data = setInterval(function() {
		$('#graph5').load('../Graph/Branch/avgResponsePerMin.jsp');
	}, 50000);
</script>
<script type="text/javascript">
	// for applicartion sersion response 
	function loadResponseAcrossApplicationVer() {
		var chart;
		console.log(" loadResponseAcrossAndroid is called");
		$(function() {
			setInterval(function() {
				data = $.parseJSON($.ajax({
					url : '../../GetPieChartDataForBranch?type=tfuwhr',
					dataType : "json",
					async : false
				}).responseText);
				//alert("response");
				chart.series[0].setData(data, true);

			}, 60000);
		});

		// Build the chart
		var chart = new Highcharts.Chart(
				{
					chart : {
						renderTo : 'graph1',
						plotBackgroundColor : null,
						plotBorderWidth : null,
						plotShadow : false,
						type : 'pie'
					},
					title : {
						text : 'Highest Response Time',
					/* style : {
						fontSize : '16px'
					} */

					},
					subtitle : {
						text : '(Top Five Users) <br>Last 1 Hour',
					/* style : {
						foutSize : '10px',
					} */
					},

					credits : {
						enabled : false
					},

					exporting : {
						enabled : false
					},

					tooltip : {
						pointFormat : ''
					},
					plotOptions : {
						pie : {
							allowPointSelect : true,
							cursor : 'pointer',
							size : 120,
							dataLabels : {
								enabled : false
							},
							showInLegend : false
						}
					/* ,
										 series : {
											cursor : 'pointer',
											point : {
												events : {
													click : function() {
														location.href = this.options.url;
													}
												}
											}
										}  */
					},
					series : [ {
						name : "Response Share",
						colorByPoint : true,
						dataLabels : {
							verticalAlign : 'top',
							enabled : true,
							color : '#000000',
							connectorWidth : 1,
							distance : -30,
							connectorColor : '#000000',
							formatter : function() {
								return Math.round(this.percentage) + ' %';
							}
						},
						data :
<%GetChartDataForBranch chData = new GetChartDataForBranch();
			out.print(chData.getTopFiveUsersWithHighestResponse());%>
	} ]
				});

	};

	// For android version response 
	function loadResponseAcrossAndroidVer() {

		var chart;
		console.log("loadResponseAcrossAndroidVer");
		$(function() {
			setInterval(function() {
				//var x = 100, // current time
				data = $.parseJSON($.ajax({
					url : '../../GetPieChartDataForBranch?type=tfuwhe',
					dataType : "json",
					async : false
				}).responseText);
				//alert("error");
				chart.series[0].setData(data, true);

			}, 60000);
		});

		// Build the chart
		var chart = new Highcharts.Chart(
				{
					chart : {
						renderTo : 'graph2',
						plotBackgroundColor : null,
						plotBorderWidth : null,
						plotShadow : false,
						type : 'pie'
					},
					title : {
						text : 'Highest Web Errors',

					/* style : {
						fontSize : '12px'
					} */

					},
					subtitle : {
						text : '(Top Five Users) <br>Last 1 Hour',
						style : {
							foutSize : '10px',
						}
					},

					credits : {
						enabled : false
					},

					exporting : {
						enabled : false
					},

					tooltip : {
						pointFormat : ''//{series.name}: <b>{point.percentage:.1f}%</b>
					},
					plotOptions : {
						pie : {
							allowPointSelect : true,
							cursor : 'pointer',
							size : 120,
							dataLabels : {
								enabled : false
							},
							showInLegend : false
						}
					/* ,
										 series : {
											//  cursor: 'pointer',
											point : {
												events : {
													click : function() {
														location.href = this.options.url;
													}
												}
											}
										}  */
					},
					series : [ {
						name : "Android Share",
						colorByPoint : true,
						dataLabels : {
							verticalAlign : 'top',
							enabled : true,
							color : '#000000',
							connectorWidth : 1,
							distance : -30,
							connectorColor : '#000000',
							formatter : function() {
								return Math.round(this.percentage) + ' %';
							}
						},
						data :
<%GetChartDataForBranch chDataForAndroid = new GetChartDataForBranch();
			out.print(chDataForAndroid.getTopFiveUsersWithHighestError());%>
	} ]
				});

	};
</script>
</head>
<body onload="loadGraph()" id="bce">
	<%@include file="Header.jsp"%>
	<%@include file="BranchMenu.jsp"%>
	<div id="container">
		<%
			GetChartDataForBranch getApdexScore = new GetChartDataForBranch();
			double apdexScore = getApdexScore.getApdexScore();
		%>


		<form action="Hotuser.jsp" method="post" onsubmit="SetData()"
			style="float: right; padding-right: 10px; padding-top: 5px;"
			name="CustexpDeviceSelectionForm">
			Select Premium user : <select name='Device' id='Device'
				onclick="javascript:$('#err').html('');">

				<%
					List Devicename = CommonUtils.getPremiumdevice();
					//System.out.println("Premium device"+Devicename);
					if (Devicename.size() < 1) {
				%>
				<option value="noDevice" selected="selected">No Device</option>
				<%
					} else {
				%>
				<option value="select" selected="selected">Select</option>
				<%
					}
					for (int i = 0; i < Devicename.size(); i++) {

						String IP = (String) Devicename.get(i);
						////System.out.println("IPPPPPPPPPPPPPPP"+IP);
						//String endpointDesc = (String) alertData.get(IP);
				%>
				<option value="<%out.println(IP);%>">
					<%
						out.println(IP);
					%>
				</option>
				<%
					}
				%>

			</select> <input type="submit" value="Submit" id="submit"
				onclick=" return checkFormSubmitData(); " />

			<div id="err" style="color: red; text-align: right; padding: 2px;"></div>
		</form>

		<div id="container">

			<div id="graph1"></div>
			<div id="graph2"></div>
			<!-- <div id="graph3">graph3</div>-->
			<div id="graph4" >
				<div id="topHeaderName"
					style="width: 80%; height: 30%; background-color: white; margin-left: 10%; margin-bottom: 5%;text-align: center;">
					<span
						style="color: #333; font-size: 18px; fill: #333;">Apdex
						Score</span>
				</div>
				<div id="mainContent"
					style="width: 80%; height: 55%; background-color: green; margin-left: 10%;border-style: solid;border-color: darkgreen;border-radius:10%;font-size: 50px;">
					<span style = "  position: absolute; margin: 10% 0% 0% 25% " ><%=apdexScore%></span>
				</div>
			</div>
			<div id="graph5"></div>
			<div id="graph6"></div>

		</div>
	</div>
	<%@include file="Footer.jsp"%>
	<script>
		function checkFormSubmitData() {
			//alert("hello");
			var status = document.CustexpDeviceSelectionForm.Device.value;

			if (status == "noDevice") {
				$("#err").html(
						"<h6 style='color:#0A29B0'>No Device Selected</h6>");
				//alert("No new Devices to Add!!!")
				return false;
			} else if (status == "select") {
				$("#err")
						.html(
								"<h5 style='color:red;margin-top:0'>Please Select Some Device</h5>");
				//alert("Please Select Some Device!!!");
				return false;
			} else {
				return true;
			}
		}
		function SetData() {
			//	alert("hello")
			var select = document.getElementById('Device');
			var uuid = select.options[select.selectedIndex].value;
			document.CustexpDeviceSelectionForm.action = "Hotuser.jsp?Device="
					+ uuid;
			myform.submit();
		}
	</script>
</body>
</html>