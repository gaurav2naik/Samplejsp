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

DB db=CommonDB.getBankConnection();
long time=System.currentTimeMillis();
long beforetime=time-(60*60*1000);
DBCollection coll=db.getCollection("Regular");
BasicDBObject duration = new BasicDBObject();
duration.put("request_time",
		new BasicDBObject("$gt", beforetime));
BasicDBObject groupFields = new BasicDBObject("_id", "$NetworkType");
groupFields.put("NetworkTypeCount", new BasicDBObject("$sum",1));

DBObject group = new BasicDBObject("$group", groupFields);
DBObject project = new BasicDBObject("$match", duration);

AggregationOutput output = coll.aggregate(group);
// StringBuilder sb1 = new StringBuilder();
int countArr[]={0,0,0,0};
String data="";
for (DBObject results : output.results()) {
	String network=results.get("_id").toString();
	int count=Integer.parseInt(results.get("NetworkTypeCount").toString());
	if(network.equals("null")||network.equals("Unknown")){
		
	}else{
		//System.out.println("result:"+results.get("_id")+" "+count);	
		if(network.equals("2G")){
			countArr[0]=count;	
		}
		else if(network.equals("3G")){
			countArr[1]=count;	
		}
		else if(network.equals("4G")){
			countArr[2]=count;	
		}
		else if(network.equals("WIFI")){
			countArr[3]=count;
		}
	}
	 data=countArr[0]+","+countArr[1]+","+countArr[2]+","+countArr[3];
	 System.out.print("data: "+data);

}

%>
	<script type="text/javascript">
$(function () {
    $('#network-container').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Network Type Distribution',
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
            categories: ['2G', '3G', '4G', 'WIFI'],
            title: {
                text: 'Network'
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: '',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
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
           	name:'Counts',
            data: [<%=data%>]
        }]
    });
});

</script>
	<div id="network-container" style="width: 100%; height: 100%"></div>
</body>
</html>