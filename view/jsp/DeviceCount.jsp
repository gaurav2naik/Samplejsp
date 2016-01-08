<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta content="25" http-equiv="refresh"> -->
<title>Insert title here</title>


<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="java.util.List"%>

<script src="../script/jquery.min.js"></script>

<script>

function getDeviceCount() 
{
	setInterval
    (

		function() 
		{
	       var data = $.parseJSON($.ajax({
								url : '../../GetDeviceCount',
								dataType : "text",
								async : false
							}).responseText);
			$("#g6").html("<center><h2 style='color:#0A29B0;font-family:Arial,Calibri; '>Right now <br></h2><a style='color:#506FF6;font-size:60px'>"+data.WebUserCount+"</a><br><p style'font-size:10px;font-family:Arial,Calibri;'> Web active users on site</p></center>");
			 $("#g7").html("<center><a style='color:#506FF6;font-size:60px'>"+data.AppUserCount+"</a><br><p style'font-size:10px;font-family:Arial,Calibri;'>App active users on site</p></center>"); 
		});
	
	
	setInterval
	       (

			function() 
			{
		       var data = $.parseJSON($.ajax({
									url : '../../GetDeviceCount',
									dataType : "text",
									async : false
								}).responseText);
								
				$("#g6").html("<center><h2 style='color:#0A29B0;font-family:Arial,Calibri;'>Right now <br></h2><a style='color:#506FF6;font-size:60px'>"+data.WebUserCount+"</a><br><p style'font-size:10px;font-family:Arial,Calibri;'>active users on site</p></center>");
				 $("#g7").html("<center><a style='color:#506FF6;font-size:60px'>"+data.AppUserCount+"</a><br><p style'font-size:10px;font-family:Arial,Calibri;'>active Locations</p></center>");
			}, 30000);
	
	
};

</script>


</head>
<body onload="getDeviceCount()">

	<div id='g6'></div>
	 <br>
<div id='g7'></div>

</body>
</html>