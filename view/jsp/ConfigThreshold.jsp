
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/admin.css" />
<link rel="stylesheet" type="text/css" href="../css/index.css" />

<link rel="icon" href="../image/title.png" type="image/png">

<link rel="stylesheet" href="../css/button.css">
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='../script/treeMenu.js'></script>
<script src="../script/getURL.js"></script>

<%
	String role = (String) session.getAttribute("Role");
%>
<title>Threshold Configuration|CIS</title>
</head>
<body id="cg">
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>
	<br>
	<div id="listing"
		style="margin-left: 25%; margin-right: 25%; margin-top: 5%; margin-bottom: 10%;">
		<form
			action="../../ConfigThresholdServlet?role=<%out.println(role);%>"
			method="post">


			<%
				//PREVIOUS THRESHOLD

				Integer res1 = null;
				Integer res2 = null;
				Integer res3 = null;
				DBCursor cursor = null;

				try {
					//1.connect to mongo// host+port
					/*   Mongo m=new Mongo("192.168.0.25",27017);
					 */
					//2.connect to your DB
					DB db = CommonDB.getBankConnection();
					System.out.println("DB Name:" + db.getName());

					//3.selcet the collection
					DBCollection coll = db.getCollection("ThresholdDB");
					System.out.println("collection name:" + coll.getName());

					BasicDBObject findObj = new BasicDBObject();
					cursor = coll.find(findObj);
					cursor.sort(new BasicDBObject("_id", -1));

					cursor.limit(1);
					List<DBObject> dbObjs = cursor.toArray();

					for (int i = dbObjs.size() - 1; i >= 0; i--)

					{
						DBObject txnDataObject = dbObjs.get(i);
						res1 = (Integer) txnDataObject.get("Web_threshold");
						res2 = (Integer) txnDataObject.get("Android_threshold");
					/* 	res3 = (Integer) txnDataObject.get("Alerts"); */

					}

				}

				catch (Exception e) {
					e.printStackTrace();
				} finally {
					cursor.close();
				}
			%>

			<h1>Configuration of Threshold</h1>
			<label>Threshold for Web Response Time&nbsp;(ms)</label> <input
				placeholder="<%=res1%>" type="text" name="BufferThreshold"
				value="<%=res1%>"> <label>Threshold for Android
				Response Time&nbsp;(ms)</label> <input placeholder="<%=res2%>" type="text"
				name="AndroidResponseThreshold" value="<%=res2%>">

			<center>
				<button type="submit" value="submit">SUBMIT</button>
			</center>

		</form>

		<p>
			<%
				if (request.getParameter("value") != null) {
			%>
		
		<div style="color: red">
			<label><%=request.getParameter("value")%></label>
		</div>
		<%
			}
		%>
		</p>
	</div>
	<%@include file="Footer.jsp"%>
</body>
</html>