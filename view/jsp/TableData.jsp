<%@page import="com.avekshaa.cis.commonutil.Convertor"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="com.mongodb.DB"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
th {
	background-color: gray;
	font-size: smaller;
}

td {
	text-align: center;
}
</style>
</head>
<body>
	<%
		int i = 1;
		DB db = CommonDB.JIOConnection();
		DBCollection coll = db.getCollection("PlayerBufferUsage");
		DBObject sort = new BasicDBObject("_id", -1);
		DBCursor cur = coll.find().sort(sort).limit(8);
		List<DBObject> list = cur.toArray();
	%>
	<table border="0" style="color: black; font-size: 15px;">
		<tr>
			<th>User ID</th>
			<th>Device ID</th>
			<th>Avg Buffering Time</th>
			<th>Average BandWidth(App)</th>
			<!--<th>Average BandWidth(MBPS)</th> -->
			<th>Location</th>
			<th>Android Version</th>
			<th>App Version</th>
		</tr>

		<%
			System.out.println("list size:" + list.size());
			if (list.size() > 0) {
				for (int i1 = list.size() - 1; i1 >= 0; i1--) {
					try {
						String convertedRate = "";
						DBObject obj = list.get(i1);
						String state = obj.get("state").toString();

						if (state.startsWith("GPS not")) {

							state = "Not Captured";
						}

						double bRate = Double.parseDouble(obj
								.get("avgByteRate").toString());
						if (bRate > (1024 * 1024)) {
							convertedRate = Convertor.converByteToMB(bRate)
									+ " MB/s";
							//System.out.println(mbRate);
						} else if (bRate > 1024) {
							convertedRate = Convertor.converByteToKB(bRate)
									+ " KB/s";
							//	System.out.println(kbRate);
						} else
							convertedRate = bRate + " Bytes/s";
		%>

		<tr>
			<td>User <%=i++%></td>
			<td><%=obj.get("UUID")%></td>
			<td><%=obj.get("avgBufferDuration")%></td>
			<td><%=convertedRate%></td>
			<!--<td>0.01</td> -->
			<td><%=state%></td>
			<td><%=obj.get("Android_ver")%></td>
			<td><%=obj.get("App_ver")%></td>
		</tr>
		<%
			} catch (NullPointerException nex) {

					}
				}
			} else {
		%>
		<tr>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
			<td>No Data</td>
		</tr>
		<%
			}
		%>
		<!-- <tr>
<td>User 2</td>
<td>Device2</td>
<td>10</td>
<td>2.1</td>
<td>0.02</td>
<td>Madhya Pradesh</td>
<td>4.4.2</td>
<td>1.1.0</td>
</tr>

<tr>
<td>User 3</td>
<td>Device 2</td>
<td>10</td>
<td>1.0</td>
<td>0.02</td>
<td>Gujarat</td>
<td>4.4.3</td>
<td>1.1.1</td>
</tr>

<tr>
<td>User 1</td>
<td>Device1</td>
<td>12</td>
<td>1.6</td>
<td>0.3</td>
<td>Meghalaya</td>
<td>4.4.1</td>
<td>1.0</td>
</tr>
<tr >
<td colspan="8"><br></td>
</tr>

<tr>
<td colspan="8" style="background-color:green;">Users Experience buffering with poor bandwidth</td>
</tr>

<tr>
<td>User 3</td>
<td>Device 2</td>
<td>07</td>
<td>0.01</td>
<td>0.02</td>
<td>Gujarat</td>
<td>4.4.3</td>
<td>1.1.1</td>
</tr>

<tr>
<td>User 2</td>
<td>Device2</td>
<td>05</td>
<td>0.02</td>
<td>0.02</td>
<td>Madhya Pradesh</td>
<td>4.4.2</td>
<td>1.1.0</td>
</tr>

<tr>
<td>User 1</td>
<td>Device1</td>
<td>06</td>
<td>0.3</td>
<td>0.01</td>
<td>Karnataka</td>
<td>4.4.1</td>
<td>1.0</td>
</tr>

<tr>
<td>User 3</td>
<td>Device 2</td>
<td>07</td>
<td>0.01</td>
<td>0.02</td>
<td>Meghalaya</td>
<td>4.4.3</td>
<td>1.1.1</td>
</tr> -->
	</table>
</body>
</html>