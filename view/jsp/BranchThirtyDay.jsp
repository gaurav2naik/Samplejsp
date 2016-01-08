<%@page import="com.avekshaa.cis.database.CommonThreshold"%>
<%@page import="com.avekshaa.cis.jio.GetChartData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.avekshaa.cis.engine.city_avg_data"%>
<%@page import="com.avekshaa.cis.engine.get_Fatal_data"%>
<%@page import="com.avekshaa.cis.engine.one_day_hits_data"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.avekshaa.cis.engine.top_city_resp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.avekshaa.cis.Java.AndroidMap"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script src="../script/jquery.js"></script>
<script src="../script/jquery.min.js"></script>

<script src="../script//highcharts.js"></script>
<script src="../script/exporting.js"></script>
<script src="../script/in-all-disputed.js"></script>
<script src="../script/highmaps.js"></script> -->
<title>Branch ThirtyDay</title>
<script type="text/javascript">

//--------------Avg Response chart----------------------------------------
$(function () {
	<%GetChartData responceCh = new GetChartData();
			String appResponceData = responceCh.getAppDataForResponce(30);
			String webResponseData  = responceCh.getWebResposeData(30);
			%>
	$('#container4').highcharts(
			{
				 chart: {
			            type: 'column'
			        },
				title : {
					text : 'Avg Response (1 Month)',
					 style: {
			                fontSize: '14px',
			                /* fontWeight : 'bold', */
			                fontFamily: 'Verdana, sans-serif'
			            }
				//center
				},
				subtitle : {
					text : '',
					x : -20
				},
				exporting : {
					enabled : false
				},
				xAxis : {
					labels : {
						enabled : true
					},
					categories : [<%out.print(GetChartData.ThirtyDayCategoryData);%>
],
					labels : {
						rotation : -45,
					/* style: {
					    fontSize: '13px',
					    fontFamily: 'Verdana, sans-serif'
					} */
					}
				},
				yAxis : {
					title : {
						text : 'Avg response<b>(ms)</b>per Day'
					},
					min : 0,
					plotLines:[{
                        value:<%=CommonThreshold.getWebThreshold()%>,
                        color: 'red',
                        width:2,
                        zIndex:4,
                        label:{
                            text:'Web Threshold',
                            style : {
                            fontSize : '10px',
                            color : 'red'
                        }
                    },
                        dashStyle : 'ShortDash'
                    }]

				},
				tooltip : {
					formatter : function() {
						return 'Time: <b>' + this.point.extra
								+ '</b><br>Response Time : <b>'
								+ this.y + '</b> ms';
					},
					valueSuffix : ''
				},
				legend : {
				//	layout : 'vertical',
					//align : 'right',
					//verticalAlign : 'middle',
					//borderWidth : 0
				},
				credits : {

					enabled : false
				},
				series : [
				          {
				        	  name:'Web Response',
								showInLegend : false,
								data:[<%out.print(webResponseData);%>]
				          },
				]
			});
});
	

//----------------------App Crash-----------------------------
 
$(function () {
	<%GetChartData crashChartData = new GetChartData();
			String appCrashData = crashChartData.getDataForCrash(30);
			String webCrashData = crashChartData.getWebCrashData(30);
			%>
    $('#container1').highcharts({
        chart: {																																											
            type: 'column'
        },
        title: {                                
            text: 'Critical Incidents',
            style: {
                fontSize: '14px',
                /* fontWeight : 'bold', */
                fontFamily: 'Verdana, sans-serif'
            }
        },
        subtitle: {
            text: ''
            	},
        exporting :  {
              enabled:false
               },
               credits: { 
               	enabled: false
               },
            	xAxis: {
            		 categories: [<%out.print(GetChartData.ThirtyDayCategoryData);%>],
             type: 'category',
            labels: {
                rotation: -45,
                /* style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                } */
            } 
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Crash Count'
            }
        },
        legend: {
            enabled: true
        },
        tooltip: {
        	 /* headerFormat: 'Time:<b>{point.x}</b><br/>',
            pointFormat: 'Crash Count : <b>{point.y} </b>' */
            
            	formatter : function() {
					return 'Time: <b>' + this.point.extra
							+ '</b><br>Crach count :<b>'
							+ this.y + '</b>';
				},
				valueSuffix : ''
        },
        series: [
                 {
        	name:'Web',
        	  showInLegend: false,
        	data:[<%out.print(webCrashData);%>],
        	  dataLabels: {
                  enabled: false,
                  rotation: -90,
                  color: '#FFFFFF',
                  align: 'right',
                  format: '{point.y}', // one decimal
                  y: 10, // 10 pixels down from the top
                  style: {
                      fontSize: '13px',
                      fontFamily: 'Verdana, sans-serif'
                  }
              }
        },
                 ]
    });
});
//---------------------Hits Chart--------------------
$(function(){
	<%GetChartData ch = new GetChartData();
			String appHitsData = ch.getDataForHits(30);
			String webHitsData = ch.getWebHitsData(30);
			%>
	$(function () {
	    $('#container3').highcharts({
	        chart: {
	            type: 'column'
	        },
	        exporting :
	        {
	            enabled:false
	        },
	        title: {
	            text: 'Number Of Hits (1 Month)',
	            	 style: {
	                     fontSize: '14px',
	                     /* fontWeight : 'bold', */
	                     fontFamily: 'Verdana, sans-serif'
	                 }
	        },
	        subtitle: {
	            text:''
	        },
	        credits: { 
	        	
	        	enabled: false
	        	
	        },
	        tooltip: {
/* 	        	 headerFormat: 'Time:<b>{point.aa}</b><br/>',
	            pointFormat: 'Hits : <b>{point.y} </b>' */
	        	formatter : function() {
					return 'Time: <b>' + this.point.extra
							+ '</b><br>Hits :<b>'
							+ this.y + '</b>';
				},
				valueSuffix : ''
	        },
	        	        
	        xAxis: {
	            categories: [<%out.print(GetChartData.ThirtyDayCategoryData);%>           
	      ], labels: {
              rotation: -45,
              /* style: {
                  fontSize: '13px',
                  fontFamily: 'Verdana, sans-serif'
              } */
          } 
	        },
	        yAxis: {
	            title: {
	                text:''
	            },
	            min:0
	        
	        },
	        plotOptions: {
	            line: {
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: true
	            }
	        },
	        series: [ 
	                  {
	                	  name:'Web Hits',
	                	  showInLegend: false,
	                	  data:[<%out.print(webHitsData);%>]
	                  },
	                 ]
	    });
	});
}); 
//-----------------------Top 5 Cities Chart--------------------
$(function () {
    // Age categories
    
    $(document).ready(function () {
        $('#container5').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Top 10 Branch with Highest Response Time',
                style: {
                    fontSize: '14px',
                  /*   fontWeight : 'bold', */
                    fontFamily: 'Verdana, sans-serif'
                }
            },
            exporting :
            {
                enabled:false
            },
            credits: { 
            	
            	enabled: false
            	
            },
            xAxis: [{
               
                reversed: false,
                labels: {
                    step: 1,
                    enabled:false
                }
            }, { // mirror axis on right side
                opposite: true,
                reversed: false,
             
                linkedTo: 0,
                labels: {
                    step: 1,
                    enabled:false
                }
            }],
            yAxis: {
                title: {
                    text: null
                },
                labels: {
                    formatter: function () {
                        return Math.abs(this.value) + 'ms';
                    }
                }
            },

            plotOptions: {
                series: {
                    stacking: 'normal'
                },
               /*  series:
            	{
            	pointWidth:20
            	} */
            },

            tooltip: {
            	formatter : function() {
    				return 'City: <b>' + this.point.extra
    						+ '</b><br>Response :<b>'
    						+ Math.abs(this.y) + '</b>';
    			},
            },

            series: [
                     {
                     	name:'Web Response',
                     	showInLegend: false,
                     	data:[<%top_city_resp t = new top_city_resp();
                     	String cityData = t.getWebTopTenCities(7);
                     	out.print(cityData);
                     	%>],
                     	dataLabels:{
                     		enabled:true,
                     		align:'right',
                     		format:'{point.extra}',
                     		color:'black',
                     		/* style:{
                     			fontSize:'10px',
                     		} */
                     		
                     		
                     	},
                      },
                      
                      ]
        });
    });

});
$('.cssload-container').hide();
</script>
</head>
<body>
	<div style="width: 99%; color: red;">
		<!-- 		<br> -->
		<br>
		 <div id="container3"
			style="width: 45%; margin-right : 2.5%; margin-left : 2.5%; height: 225px; float: left; align: left">
		</div>
		<div id="container4"
			style="width: 50%;  height: 225px; margin: 0 auto; float: left; align: left">
		</div>
		<br></br>
		<!-- 		<div id="container"
			style="align: left; padding-top: 15x; width: 50%; float: left;"></div>
 -->
		 <div id="container1"
			style="align: left;width: 45%; margin-right : 2.5%; margin-left : 2.5%; height: 225px; float: left; padding-top: 0px;"></div> 
 	<div id="container5"
			style="width: 50%;  height: 225px; margin: 0 auto; float: left"
			align="left"></div> 
		<!--  <iframe src="sevenDayMap.jsp" id="container6"
			style="width: 100%; border-style: solid; border-color: red; height: 470px; border: 0; min-width: 600px; max-width: 550px; margin: 0 auto; float: left;"></iframe> -->

	</div>
</body>
</html>