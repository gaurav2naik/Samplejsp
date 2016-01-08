<%@page import="com.avekshaa.cis.engine.city_avg_data"%>
<%@page import="com.avekshaa.cis.engine.get_Fatal_data"%>
<%@page import="com.avekshaa.cis.engine.one_day_hits_data"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="com.avekshaa.cis.engine.top_city_resp"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Dashboard|CIS</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="../script/jquery.js"></script>
<script src="../script/jquery.min.js"></script>

<script src="../script//highcharts.js"></script>
<script src="../script/exporting.js"></script>
<script src="../script/in-all-disputed.js"></script>
<script src="../script/highmaps.js"></script>
<!-- <script src="https://code.highcharts.com/maps/modules/exporting.js"></script> -->

<script type="text/javascript">
	function loadGraph() {
		
		$('#container4').load('../Graph/AverageAndro.jsp');
		
	}
</script>
<script type="text/javascript">
$(function () {
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        exporting :
        {
            enabled:false
        },
        title: {
            text: 'Users Buffering %'
        },
       
         xAxis: {
            categories: [
  
    <%try {
                String data2 = "";
                StringBuilder xais = new StringBuilder();
                city_avg_data resp = new city_avg_data();
                TreeMap<Long, Integer> data = resp.buffer_perc_detail();
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
            max : 100,
            title: {
                text: 'User (%)'
            },
            stackLabels: {
                enabled: true,
                style: {
                    fontWeight: 'bold',
                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                }
            }
        },
       
        colors: [ "#FFA500"],
               
       
        credits: {
           
            enabled: false
           
        },
        
       
        tooltip: {
            headerFormat: 'Time:<b>{point.x}</b><br/>',
            pointFormat: 'Total: {point.stackTotal}'
        },
        plotOptions: {
            column: {
                stacking: 'normal',
                dataLabels: {
                    enabled: false,
                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
                    style: {
                        textShadow: '0 0 3px black'
                    }
                }
            }
        },
        series: [
                 {
                     
                  showInLegend: false,      
                  name: '',
                  data: [

      <%try {
                String data2 = "";
                StringBuilder xais = new StringBuilder();
                city_avg_data resp = new city_avg_data();
                TreeMap<Long, Integer> data = resp.buffer_perc_detail();
               // System.out.println("sata" + data);
                for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();) {
                   // String hrs = (String) iterator.next();
                    
                   Long hrs = (Long)iterator.next();//key
                                 //  String IPURIRES = (String)data.get(timeInMillis);//val                                        //


                                            SimpleDateFormat sdf = new SimpleDateFormat(" HH:mm");
                                            String timeInDateFormat = sdf.format(hrs);
                                            int count = data.get(hrs);
                    //System.out.println("key : " + hrs + "value" + data.get(hrs));
                    xais.append(count + ",");
                }
                data2 = xais.toString();
                out.println(data2);
            } catch (Exception e) {

            }%>
                         ]
              }]
               
             
    });
});



//------------------------------------------------------------------------------------------------

$(function () {
    $('#container1').highcharts({
        chart: {																																											
            type: 'column'
        },
        title: {                                
            text: 'App Crash'
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
            enabled: false
        },
        tooltip: {
        	 headerFormat: 'Time:<b>{point.x}</b><br/>',
            pointFormat: 'Crash Count : <b>{point.y} </b>'
        },
        series: [{
            name: 'Time',
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


                                            SimpleDateFormat sdf = new SimpleDateFormat(" HH:mm");
                                            String timeInDateFormat = sdf.format(hrs);
			int count=data.get(hrs);
// 			System.out.println("key : "+hrs+"value"+data.get(hrs));
			//int crach =(Integer) iterator.next();
			//System.out.println(hrs+"   "+crach);
			//xais.append("'"+enter_value+ "',");
			xais.append(count+",");
			//System.out.println("xaxis"+xais);   			
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
	            type: 'line'
	        },
	        exporting :
	        {
	            enabled:false
	        },
	        title: {
	            text: 'Number Of Hits Per Hour (one day)'
	        },
	        subtitle: {
	            text:''
	        },
	        credits: { 
	        	
	        	enabled: false
	        	
	        },
	        tooltip: {
	        	 headerFormat: 'Time:<b>{point.x}</b><br/>',
	            pointFormat: 'Hits : <b>{point.y} </b>'
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
	        series: [ {
	        
	           
	         showInLegend: false,  
	         enabled : false,
	           data: [
<%try{
	
	
		String data2="";
      	StringBuilder xais = new StringBuilder();
		one_day_hits_data resp=new one_day_hits_data();	
 	    TreeMap<Long, Integer> data = resp.hits_detail();
//  	    System.out.println("sata"+data);
	  	for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
		{
	  		//System.out.println((Double)iterator.next()+"iterator");
			//String hrs = (String) iterator.next();
			Long hrs = (Long)iterator.next();//key
                                 //  String IPURIRES = (String)data.get(timeInMillis);//val                                        //


                                            SimpleDateFormat sdf = new SimpleDateFormat(" HH:mm");
                                            String timeInDateFormat = sdf.format(hrs);
			int count=data.get(hrs);
// 			System.out.println("key:"+hrs+"value"+data.get(hrs));
			//int crach =(Integer) iterator.next();
			//System.out.println(hrs+"   "+crach);
			//xais.append("'"+enter_value+ "',");
			xais.append("['"+timeInDateFormat+"',"+count+"],");
			//System.out.println("xaxis"+xais);   			
			}
	  	data2 = xais.toString();
// 	  	System.out.println("fsdgshssjsj"+data2);
	    out.println(data2);

    }
catch(Exception e){
    }%> 
		   	            ]
	        }]
	    });
	});
});
//------------------------------------------------------------------------------------------------
$(function () {
    $('#container5').highcharts({
        chart: {
            type: 'bar'
        },
        exporting :
        {
            enabled:false
        },
        
        
        title: {
            text: 'Top 5 Cities with Highest Response Time'
        },
        
 credits: { 
        	
        	enabled: false
        	
        },
                
        
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: [
						<%try{
							String data2="";
                          	StringBuilder xais = new StringBuilder();
							top_city_resp resp=new top_city_resp();	
                         	String data = resp.countryTopFivaMaxAvgResponse(1);
//                          	System.out.println("sata"+data);
						  	/* for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();)
                 			{
						  		//System.out.println((Double)iterator.next()+"iterator");
                     			String city_name = (String) iterator.next();                     		
//                      			System.out.println(city_name);                     			
                     			xais.append("'"+city_name+ "',");
                     			} */
						data2=xais.toString();
						out.println(data);
						}
						catch(Exception e){
							
						}%>
],
            title: {
                text: null
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Time (ms)',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
        	showInLegend: false, 
            valueSuffix: ' '
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 80,
            floating: false,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true,
            showInLegend: false, 
            enabled:false
        },
        credits: {
            enabled: false
        },
        series: [{
          
            name:'Avg Response ',
        	data: [

                   <%try{
    						String data2="";
                         	StringBuilder xais = new StringBuilder();
    						top_city_resp resp=new top_city_resp();	
                        	String data = resp.countryTopFivaMaxAvgResponse(1);
//                         	System.out.println("sata"+data);
    					  	/* for (Iterator iterator = data.values().iterator(); iterator.hasNext();)
                			{
    					  		//System.out.println((Double)iterator.next()+"iterator");
                    			Double city_value = (Double) iterator.next();
                    			int val=city_value.intValue();
                    			String enter_value=String.valueOf(val);
//                     			System.out.println(val);
                    			//xais.append("'"+enter_value+ "',");
                    			xais.append("{y:"+val+"},");
                    			//System.out.println("xaxis"+xais);   			
                    			} */
    					  	data2 = xais.toString();
//     					  	System.out.println("fsdgshssjsj"+data2);
    					out.println(data);
    				
                           }
                       catch(Exception e){
                           }%>
    ]
            }]
    });
});
</script>


<link rel="stylesheet" type="text/css" href="../css/index.css" />
<script type="text/javascript" src="../script/styleswitcher.js"></script>

<link rel="stylesheet" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />
</head>
<body id="md" onload="loadGraph()">

	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>
	<div style="width: 99%; color: red;">
		<br> <br>
		<div id="container3"
			style="min-width: 50%; height: 400px; margin: 0 auto; float: left; align: left">
		</div>
		<div id="container4"
			style="min-width: 45%; height: 400px; margin: 0 auto; float: left; align: left">
		</div>
		<br></br>
		<div id="container"
			style="align: left; padding-top: 15x; width: 50%; float: left;"></div>
		<div id="container1"
			style="align: left; width: 50%; float: left; padding-top: 0px;"></div>

	</div>

	<br>
	<br>

	<div id="container5"
		style="min-width: 50%; height: 400px; margin: 0 auto; float: left"
		align="left"></div>
	<iframe src="map.jsp" id="container6"
		style="width: 100%; border-style: solid; border-color: red; height: 470px; border: 0; min-width: 600px; max-width: 550px; margin: 0 auto; float: left;"></iframe>
	<%@include file="Footer.jsp"%>



</body>
</html>