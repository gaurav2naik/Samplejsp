<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--    <%
	if(session.getAttribute("currentSessionUser")==null||session.getAttribute("currentSessionUser").equals(""))
{
	response.sendRedirect("../../index.jsp?err=You are not Logged In !!!");
}
%>  --%>
<%@page import="com.avekshaa.cis.Java.TotalHits48hrs"%>
<%@page import="com.avekshaa.cis.Java.EXMP"%>

<%@page import="com.avekshaa.cis.Java.EX"%>
<%@page import="java.util.Map"%>

<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>

<%@page import="com.avekshaa.cis.Java.OneHourWeb"%>
<%@page import="com.avekshaa.cis.Java.OneHourAndroid"%>

<%@page import="com.avekshaa.cis.Java.AndroidLive"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Experience</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="icon" href="../image/title.png" type="image/png"> 
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script> -->
<style>
html {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
}
</style>


<script>

 $(function () {
        $('#graph2')
                .highcharts(
                        {
                            chart : {
                                type : 'bar',
                                backgroundColor:'transparent'
                            },

                            exporting : {
                                enabled : false
                            },

                            title : {
                                text : 'Customer Response Index'
                            },
                            /* subtitle : {
                            text: 'Total Request vs SLA Breach <br> Perr'
                            }, */
                            
                            
                            subtitle : {
                                text:
                                    <% EX objP = new EX();
                           
                              
                              
                                String dataPer =null;
                                StringBuilder stringB = new StringBuilder();
                              
                                    double ans8 = objP.mtd();
                                  
                                  
                                    stringB.append("'"+"Total Request vs SLA Breach(48 Hours) <br> "+"Percentage:"+ans8+"%"+"'"); 
                                    dataPer = stringB.toString();  //string built is stored in data2
                                    out.println(dataPer);
                                  
                                 //////System.out.println("PERCENT" + dataPer);
                               
                               
                                 %>,
                                 style: {
                                     color: 'red',
                                     font: 'bold 13px "Trebuchet MS", Verdana, sans-serif'
                                  }
                                   
                                   
                                },
                            
                            
                            
                            xAxis : {
                                categories : [ 'Users' ],
                                title : {
                                    text : null
                                }
                            },
                            yAxis : {
                               
                               
                                min : 0,
                                title : {
                                    text : 'users',
                                    align : 'high'
                                },
                                labels : {
                                    overflow : 'justify',
                                    enabled:false
                                }
                            },
                            tooltip : {
                                valueSuffix : ' Users'
                            },
                            plotOptions : {
                                bar : {
                                    dataLabels : {
                                        enabled : true
                                    }
                                }
                            },
                            legend : {
                                layout : 'horizontal',
                                align : 'right',
                                verticalAlign : 'bottom',
                                floating : true,
                                backgroundColor : '#FFFFFF',

                            },
                            credits : {
                                enabled : false
                            },
                            series : [
                                    {

                                        //showInLegend:false,
                                        color : 'Red',
                                        name : 'Incidents & SLA Breach',
                                        data :
                                        //[2]

                                        [
<%EXMP ic = new EXMP();
            double inci = ic.mtd();
            out.println(inci);
            //////System.out.println("icidts" + inci);%>
    ]

                                    },
                                    {

                                        showInLegend : true,
                                        name : 'Total Hit',
                                        color : 'blue',
                                        data :

                                        //[10]
                                        [
<%
           
TotalHits48hrs th = new TotalHits48hrs();
            double tHits = th.mtd();
            out.println(tHits);
            //////System.out.println("total:" + tHits);%>
    ]

                                    } ]
                        });
    });

        
</script>
</head>
<body>

	<div id="graph2">graph2</div>
	</a>


</body>
</html>