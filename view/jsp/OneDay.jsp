<%@page import="com.avekshaa.cis.commonutil.Convertor"%>
<%@page import="com.avekshaa.cis.jio.GetChartData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.avekshaa.cis.engine.city_avg_data"%>
<%@page import="com.avekshaa.cis.engine.get_Fatal_data"%>
<%@page import="com.avekshaa.cis.engine.one_day_hits_data"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="com.avekshaa.cis.engine.top_city_resp"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>One Day</title>
<!--  <script src="../script/jquery.js"></script>
<script src="../script/jquery.min.js"></script>

<script src="../script//highcharts.js"></script>
<script src="../script/exporting.js"></script>
<script src="../script/in-all-disputed.js"></script>
<script src="../script/highmaps.js"></script>
 --><script type="text/javascript">
	function loadGraph() {
	//	alert("ffffff");
		//$('#container4').load('../Graph/AverageAndro.jsp');
		
	}
</script>

<script type="text/javascript">
$(function () {
	$('#container4').load('../dashboardgraph/AverageAndroForDashBoard.jsp');
	
});

//------------------------------------------------------------------------------------------------

$(function () {
    $('#container1').highcharts({
        chart: {																																											
            type: 'column'
        },
        title: {                                
            text: 'Critical Incidents',
            style: {
                fontSize: '14px',
              /*   fontWeight : 'bold', */
                fontFamily: 'Verdana, sans-serif'
            }
        },
        subtitle: {
            text: ''
           <%-- text: '<a href = "http://avekshaa.com">1 Day Data</a>' --%>
            	},
        exporting :  {
              enabled:false
              
               },
               
               credits: { 
               	
               	enabled: false
               	
               },
                    
                  	
            	xAxis: {
            		 categories: [
            		              
            		              <%try {
            		                          String data2 = "";
            		                          StringBuilder xais = new StringBuilder();
            		                          get_Fatal_data resp = new get_Fatal_data();
            		                          TreeMap<Long, Integer> data = resp.Fatal_Detail_current();
            		                         // System.out.println("sata" + data);
            		                          for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();) {
            		                              //System.out.println((Double)iterator.next()+"iterator");
            		                              Long hrs = (Long) iterator.next();
            		                              SimpleDateFormat sdf = new SimpleDateFormat(" HH:mm");
            		                              String timeInDateFormat = sdf.format(hrs);
            		                              int count = data.get(hrs);
            		                              // System.out.println(city_name);
            		                              xais.append("'" + timeInDateFormat + "',");
            		                          }
            		                          data2 = xais.toString();
            		                          out.println(data2);
            		                      } catch (Exception e) {

            		                      }%>
            		                                 
            		                                   ],
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
        	/*  headerFormat: 'Time:<b>{point.x}</b><br/>',
            pointFormat: 'Crash Count : <b>{point.y} </b>' */
        	formatter : function() {
				return 'Time: <b>' + this.point.extra
						+ '</b><br>Crash Count :<b>'
						+ this.y + '</b>';
			},
			valueSuffix : ''
            
        },
        series: [
                 {
                	 name: 'Web',
                	 data:[
                	       <%GetChartData crashChartData = new GetChartData();
                	       String webCrashData = crashChartData.getWebCrashData(1); 
                	       out.print(webCrashData);
                	       %>
                	       ]
                 },
                 
                 
                 {
            name: 'App',
            data: [
<%try{
	
	
		String data2="";
  	StringBuilder xais = new StringBuilder();
		get_Fatal_data resp=new get_Fatal_data();	
 	TreeMap<Long, Integer> data = resp.Fatal_Detail_current();
//  	System.out.println("sata"+data);
	  	for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
		{
	  		//System.out.println((Double)iterator.next()+"iterator");
			//String hrs = (String) iterator.next();
			Long hrs = (Long)iterator.next();//key
                                 //  String IPURIRES = (String)data.get(timeInMillis);//val                                        //


                                            //SimpleDateFormat sdf = new SimpleDateFormat(" HH:mm");
                                            String timeInDateFormat = Convertor.timeInDefaultFormat(hrs);
			int count=data.get(hrs);
// 			System.out.println("key : "+hrs+"value"+data.get(hrs));
			//int crach =(Integer) iterator.next();
			//System.out.println(hrs+"   "+crach);
			//xais.append("'"+enter_value+ "',");
			xais.append("{y:"+count+",extra:'"+timeInDateFormat+"'},");
	//	System.out.println("xaxis"+xais);   			
			}
	  	data2 = xais.toString();
// 	  	System.out.println("app crash report graph"+data2);
	out.println(data2);

    }
catch(Exception e){
    }%> 
                ],
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
        }]
    });
});
//-----------------------------------------------------------------------------------------------
$(function(){
	$(function () {
	    $('#container3').highcharts({
	        chart: {
	            type: 'line',
	            zoomType: 'x'
	        },
	        
	        exporting :
	        {
	            enabled:false
	        },
	        title: {
	            text: 'Number Of Hits Per Hour (one day)',
	            style: {
                    fontSize: '14px',
                  /*   fontWeight : 'bold', */
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
	        	/*  headerFormat: 'Time:<b>{point.x}</b><br/>',
	            pointFormat: 'Hits : <b>{point.y} </b>' */
	            
	            	formatter : function() {
						return 'Time: <b>' + this.point.extra
								+ '</b><br>Hits :<b>'
								+ this.y + '</b>';
					},
					valueSuffix : ''
	        },
	        	        
	        xAxis: {
	        	
	           categories: [
   <%try{
	
	
		String data2="";
  	StringBuilder xais = new StringBuilder();
		one_day_hits_data resp=new one_day_hits_data();	
 	TreeMap<Long, Integer> data = resp.hits_detail();
//  	System.out.println("sata"+data);
	 	for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
		{
	 		//System.out.println((Double)iterator.next()+"iterator");
			//String hrs = (String) iterator.next();
			Long hrs = (Long)iterator.next();//key
                                 //  String IPURIRES = (String)data.get(timeInMillis);//val                                        //


                                            SimpleDateFormat sdf = new SimpleDateFormat(" HH:mm");
                                            String timeInDateFormat = sdf.format(hrs);
			int count=data.get(hrs);
			//DateFormat format = new SimpleDateFormat("dd/MM");
			//String formatted = format.format(hrs);
            
// 			System.out.println("key : "+hrs+"value"+data.get(hrs));
			//int crach =(Integer) iterator.next();
			//System.out.println(hrs+"   "+crach);
			//xais.append("'"+enter_value+ "',");
			xais.append("'"+timeInDateFormat+ "',");
			//System.out.println("x-axis "+timeInDateFormat);   			
			}
	 	data2 = xais.toString();
	 	//System.out.println("fsdgshssjsj"+data2);
	out.println(data2);

    }
catch(Exception e){
    }%> 
	                          
	      ],labels: {
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
	     		           
	     		         //showInLegend: false,  
	     		         enabled : false,
	     		           data: [<%GetChartData hitsChartData = new GetChartData();
	     		           String hitsData = hitsChartData.getWebHitsData(1);
	     		           out.print(hitsData);%>]
	     	    },
	                 {
			name:'App Hits',	           
	         showInLegend: true,  
	         enabled : false,
	           data: [
<%try{
	
	
		String data2="";
      	StringBuilder xais = new StringBuilder();
		one_day_hits_data resp=new one_day_hits_data();	
 	    TreeMap<Long, Integer> data = resp.hits_detail();
	  	for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
		{
			Long hrs = (Long)iterator.next();//key
          //  String IPURIRES = (String)data.get(timeInMillis);//val                                        //
          //     SimpleDateFormat sdf = new SimpleDateFormat(" HH:mm");
            String timeInDateFormat = Convertor.timeInDefaultFormat(hrs);
			int count=data.get(hrs);
// 			System.out.println("key:"+hrs+"value"+data.get(hrs));
			//int crach =(Integer) iterator.next();
			//System.out.println(hrs+"   "+crach);
			//xais.append("'"+enter_value+ "',");
			/* xais.append("['"+timeInDateFormat+"',"+count+"],"); */
			xais.append("{y:"+count+",extra:'"+timeInDateFormat+"'},");
			}
	  	data2 = xais.toString();
	    out.println(data2);
    }
catch(Exception e){
    }%> 
		   	            ]
	        }
	        ]
	    });
	});
});
//------------------------------------------------------------------------------------------------
 $(function () {
    // Age categories
    
    $(document).ready(function () {
        $('#container5').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Top 5 Cities with Highest Response Time',
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
                     	name:'Web Respone',
                     	showInLegend: true,
                     	data:[<%top_city_resp t = new top_city_resp();
                     	String cityData = t.getWebTopCities(1);
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
                      
                      {
               
                 name:'App Response ',
             	data: [

                        <%try{
         						
         						top_city_resp resp=new top_city_resp();	
                             
                             	String data = resp.countryTopFivaMaxAvgResponse(1);
                              
         					out.println(data);
         				
                                }
                            catch(Exception e){
                                }%>
         ],
      	dataLabels:{
     		enabled:true,
     		align:'right',
     		format:'{point.extra}',
     		color:'black',
     		/* style:{
     			fontSize:'10px',
     		} */
     		
     		
     	},
                 }]
        });
    });

});
 $('.cssload-container').hide();
</script>
</head>
<body onload="loadGraph()">
	<div style="width: 99%; color: red;">
		<!-- 		<br> -->
		<br>
		<div id="container3"
			style="width: 50%; margin-right : 2.5%;  height: 250px; margin-left : 2.5%; float: left; align: left">
		</div>
		<div id="container4"
			style="width: 45%; height: 250px; margin: 0 auto; float: left; align: left">
		</div>
		<br></br>
		<!-- 	<div id="container"
			style="align: left; padding-top: 15x; width: 50%; float: left;"></div> -->
		<div id="container1"
			style="align: left; width: 50%; float: left; padding-top: 0px;margin-right : 2.5%;  height: 260px; margin-left : 2.5%;"></div>
		 <div id="container5"
		style="max-width: 50%; height: 260px; margin: 0 auto; float: left"
		align="left"></div> 
		<iframe src="map.jsp" id="container6"
			style="width: 100%; border-style: solid; border-color: red; height: 470px; border: 0; min-width: 600px; max-width: 550px; margin: 0 auto; float: left;"></iframe>

	</div>
</body>
</html>