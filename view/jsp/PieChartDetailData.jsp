<%@page import="com.avekshaa.cis.commonutil.Convertor"%>
<%@page import="com.avekshaa.cis.servlet.CreateTableRecentTen"%>
<%@page import="com.mongodb.DBObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String role = (String) session.getAttribute("Role");
	//String role = "cio";
%>
<%@page import="java.util.*"%>
<%@page import="com.avekshaa.cis.login.ExistingUsers"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Experience | Existing User</title>
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link href="../css/jquery.dataTables.min.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="../css/button.css">
<script type="text/javascript" src="../script/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="../script/jquery.dataTables.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#myTable').DataTable();
	});
</script>
<style>
#footer {
	background-color: black;
	color: white;
	clear: both;
	position: relative;
	z-index: 10;
	height: 2em;
	margin-top: 0em;
}

#footer-bottom {
	background-color: black;
	color: white;
	clear: both;
	text-align: center;
	padding-top: 5px;
	bottom: 0;
	left: 0;
	position: fixed;
}
</style>
</head>

<body id="ce">
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>

	<%
	
		String device = request.getParameter("device");
	
		String type = request.getParameter("type");
		String version = request.getParameter("version");
		if (type != null && version != null) {
			if (device.equals("android")) {
	%>
	<h1 align="center" style="font-size: 20px">Details</h1>
	<%
		//	out.println("Application version " + version);
				@SuppressWarnings("unchecked")
				List<DBObject> list = CreateTableRecentTen
						.getAndroidTableData(type,version);
				System.out.println(list.size());
				if (list != null) {
					//out.println("list size "+list.size());
	%>
	<table id="myTable" align="center" class="display" cellspacing="0"
		style="width: 100%; font-size: 12px;">
		<thead>
			<tr>
				<th>UUID</th>
				<th>Response(ms)</th>
				<th>Application Version</th>
				<th>Android Version</th>
				<th>Network Type</th>
			<!-- 	<th>BandWidth</th>-->
				<th>Request Time</th> 
				<th>State</th>
				<th>City</th>
			</tr>
		</thead>

		<tbody>
			<%
				for (int i = 0; i < list.size(); i++) {

								DBObject obj = list.get(i);
								String state = obj.get("state").toString();
								String city = obj.get("city").toString();
								if (state.startsWith("GPS not")) {
									state = "Not Captured";
									city = "Not Captured";
								}
								/* long BytesDownloaded = Long.parseLong(obj.get(
										"BytesDownloaded").toString());
								long BufferDuration = Long.parseLong(obj.get(
										"BufferDuration").toString());
								double bandWidth = BytesDownloaded / BufferDuration;

								String StringBandWidth = Convertor
										.converByte(bandWidth); */
			%>
			<tr>
				<td><%=obj.get("UUID")%></td>
				<td><%=obj.get("duration")%></td>
				<td><%=obj.get("App_ver")%></td>
				<td><%=obj.get("Android_ver")%></td>
				<td><%=obj.get("NetworkType")%></td>
				<%-- <td><%=StringBandWidth%></td> --%>
				<td><%=Convertor.timeInDefaultFormat(Long
									.parseLong(obj.get("request_time")
											.toString()))%></td>
				<td><%=state%></td>
				<td><%=city%></td>
			</tr>


			<%
				}
			%>
		</tbody>
	</table>
	<%
		} else {
	%>
	<table id="myTable" align="center" class="display" cellspacing="0"
		style="width: 100%; font-size: 12px;">
		
			<tr>
				<th>UUID</th>
				<th>Response(ms)</th>
				<th>Application Version</th>
				<th>Android Version</th>
				<th>Network Type</th>
			<!-- 	<th>BandWidth</th>-->
				<th>Request Time</th> 
				<th>State</th>
				<th>City</th>
			</tr>
		

		<tr>
			<th>No Data</th>
			<th>No Data</th>
			<th>No Data</th>
			<th>No Data</th>
			<th>No Data</th>
			<th>No Data</th>
			<th>No Data</th>
			<th>No Data</th>
			
		</tr>
	</table>
	<%
		}
			} else if (device.equals("ios")) {
				//out.println("Android version " + version);
	%>
	<h1 align="center" style="font-size: 20px">Buffering Details</h1>
	<%
		@SuppressWarnings("unchecked")
				List<DBObject> list = CreateTableRecentTen
						.getIOSTableData(type,version);
				if (list != null) {
	%>
	<table id="myTable" align="center" class="display" cellspacing="0"
		style="width: 100%; font-size: 12px;">
		<thead>
			<tr>
				<th>UUID</th>
				<th>Response(ms)</th>
				<th>Application Version</th>
				<th>IOS Version</th>
				<th>Network Type</th>
				<!-- <th>BandWidth</th> -->
				<th>Request Time</th> 
				<th>State</th>
				<th>City</th>
			</tr>
		</thead>
		<tbody>
			<%
				for (int i = 0; i < list.size(); i++) {
								DBObject obj = list.get(i);
								String state = obj.get("state").toString();
								String city = obj.get("city").toString();
								if (state.startsWith("GPS not")) {
									state = "Not Captured";
									city = "Not Captured";
								}
							/* 	long BytesDownloaded = Long.parseLong(obj.get(
										"BytesDownloaded").toString());
								long BufferDuration = Long.parseLong(obj.get(
										"BufferDuration").toString());
								double bandWidth = BytesDownloaded / BufferDuration;

								String StringBandWidth = Convertor
										.converByte(bandWidth); */
			%>

			<tr>
				<td><%=obj.get("UUID")%></td>
				<td><%=obj.get("duration")%></td>
				<td><%=obj.get("App_ver")%></td>
				<td><%=obj.get("os_version")%></td>
				<td><%=obj.get("NetworkType")%></td>
			<%-- 	<td><%=StringBandWidth%></td> --%>
				<td><%=Convertor.timeInDefaultFormat(Long
									.parseLong(obj.get("request_time")
											.toString()))%></td>
				<td><%=state%></td>
				<td><%=city%></td>
			</tr>


			<%
				}
			%>
		</tbody>
	</table>
	<%
		} else {
	%>
	<table id="myTable" align="center" class="display" cellspacing="0"
		style="width: 99%; font-size: 12px;">
		<tr>
			<tr>
				<th>UUID</th>
				<th>Response(ms)</th>
				<th>Application Version</th>
				<th>IOS Version</th>
				<th>Network Type</th>
				<!-- <th>BandWidth</th> -->
				<th>Request Time</th> 
				<th>State</th>
				<th>City</th>
			</tr>
		</tr>

		<tr>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
			
		</tr>
	</table>
	<%
		}

			}
		}
	%>
	<br>
	<%-- <%@include file="Footer.jsp"%> --%>
	<div id="footer-bottom">Copyright © avekshaa.com</div>


</body>
</html>