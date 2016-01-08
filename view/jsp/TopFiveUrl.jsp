<%@page import="com.avekshaa.cis.engine.GetChartDataForBranch"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Collection"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import=" com.mongodb.AggregationOutput"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <!-- <script src="../script/jquery.min.js"></script>
<script src="../script/jquery.js"></script>
<script src="../script/highcharts.js"></script>
<script src="../script/exporting.js"></script> -->

<style>
body {
	font-family: "Lucida Grande", "Lucida Sans Unicode", Arial, Helvetica,
		sans-serif;
}
</style>
</head>
<body>
	<%
	String data="";
	GetChartDataForBranch urlData=new GetChartDataForBranch();
	data=urlData.getTopFiveURL();

%>
	<script type="text/javascript">
$(function () {
    $('#network-container').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: 'TOP URLs AND PERFORMANCE',
            style:{
            	fontFamily: ' '
            }
        },
        exporting : {
			enabled : false
		},
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: [''],
            title: {
                text: ''
            },
            labels:{
            	enabled:false
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Avg Response Time (ms)',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip : {
        	formatter : function() {
				return 'URI: <b>' + this.point.extra
						+ '</b><br>Avg:<b>'
						+ this.y + ' ms </b>';
			},
			valueSuffix : 'ms',
			/* valueSuffix : ' ms', */
			/* headerFormat: '<span style="font-size:12px;color:{series.color}">URI:</span><b>{point.extra}</b><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f}ms </b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true */
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
            floating: true,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true,
          enabled:false
        },
        credits: {
            enabled: false
        },
        series: [{
           	name:'Avg',
            data: [<%=data%>]
        }]
    });
});

</script>
	<div id="network-container" style="width: 100%; height: 100%"></div>
</body>
</html>