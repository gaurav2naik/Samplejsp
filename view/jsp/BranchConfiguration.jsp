<%@page import="com.mongodb.MongoClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.avekshaa.cis.database.CommonUtils"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="com.avekshaa.cis.engine.Live"%>
<%@page import="com.avekshaa.cis.engine.LiveResponseCustomized"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>
<html>
<head>
<script type='text/javascript' src='view/script/getState.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Branch Configuration Page</title>
<link rel="stylesheet" type="text/css" href="css/style1.css" />
<link href="../css/button.css" rel="stylesheet" type="text/css" />
<script src="../script/jquery.min.js"></script>
<style type="text/css">
table {
	color: #333;
	font-family: Helvetica, Arial, sans-serif;
	width: 640px;
	border-collapse: collapse;
	border-spacing: 0;
}

td, th {
	border: 1px solid transparent; /* No more visible border */
	height: 30px;
	transition: all 0.3s; /* Simple transition for hover effect */
}

th {
	background: #DFDFDF; /* Darken header a bit */
	font-weight: bold;
}

td {
	background: #FAFAFA;
	text-align: center;
}

/* Cells in even rows (2,4,6...) are one color */
tr:nth-child(even) td {
	background: #F1F1F1;
}

/* Cells in odd rows (1,3,5...) are another (excludes header cells)  */
tr:nth-child(odd) td {
	background: #FEFEFE;
}

tr td:hover {
	background: #666;
	color: #FFF;
} /* Hover cell effect! */
</style>
</head>
<body>
	<%@include file="Header.jsp"%>
	<%@include file="BranchMenu.jsp"%>
	<div style="text-align: center; font-size: 20px;">
		<h1>Configuration Page</h1>
	</div>
	<div id="box"
		style="width: 100%; position: relative; margin-top: 50px;"
		align="center">




		<%
			MongoClient mongo = new MongoClient("52.24.170.28", 27017);
			//MongoClient mongo = new MongoClient("127.0.0.1",27017);
			DB db = mongo.getDB("testdemo1");
			DBCollection colls1 = db.getCollection("XLsheet");
			BasicDBObject obj = new BasicDBObject();

			DBCursor value = colls1.find();
			System.out.println("cursor " + value.count());
			List<DBObject> dbObjss1 = value.toArray();
			System.out.println("List Size" + dbObjss1.size());
		%>
		<center>
			<form method="post" action="UploadServlet"
				enctype="multipart/form-data"
				style="padding-bottom: 2%; width: 100%;">
				Select file to upload: <input type="file" name="uploadFile" /><br />
				<br /> 
				 	<!-- <input type="hidden" value="edit" name="cmd"/> -->
  					<input type="submit" value="EditFileUpload"/>
  					
  				<!-- 	<input type="hidden" value="save" name="cmd"/>
 					<input type="submit" value="NewFile Upload"/> -->
				
			</form>
			<!-- <form method="post" action="NewFileupload" enctype="multipart/form-data"
				style="padding-bottom: 2%; width: 100%;">
			<input type="submit" value="NewFile Upload" />
			</form> -->
		</center>
		
		<!-- <form action="IbatisInsertServlet" method="POST">
  ...
  <input type="hidden" value="save" name="cmd"/>
  <input type="submit" value="Enter"/>
  ...
</form>

<form action="IbatisInsertServlet" method="POST">
  ...
  <input type="hidden" value="edit" name="cmd"/>
  <input type="submit" value="Edit"/>
  ...
</form> -->
		
		
		
		<hr>
		
		<center>
			<form method="post" action="selectState" style="padding-top: 5%;">


				<table id="myTable">


					<thead>
						<tr>
						<th>Identification Code</th>
							<th>Branch Name</th>
							

							<th>Branch Ip Address</th>
							<th>Enable/disable monitoring</th>
						</tr>
					</thead>
					<tbody>
						<%
							// List alertData1 = CommonUtils.getState();
							for (int j = 0; j < dbObjss1.size(); j++) {
								DBObject txnDataObject = dbObjss1.get(j);

								StringBuffer sb = new StringBuffer();
						%>

						<tr>
							<td align="left"><%=txnDataObject.get("Branch_Name")%></td>
							<td align="left"><%=txnDataObject.get("Identification_code")%></td>
							<td align="left"><%=txnDataObject.get("IP_address")%></td>
							<td align="left"><input type="checkbox" name="checkbox"
								value="<%=txnDataObject.get("IP_address")%>" id="checkbox<%=j%>"></td>

						</tr>


						<%
							}
						%>

					</tbody>
					<!-- <input type="button" value="submittttttttttt"> -->

				</table>
		</center>






		<%-- <br><font color="#3399FF" size="5px"> <B>IP Address</B></font>
				<select name='State' multiple="multiple" id='State'>
					<option value='-1'><B>Select IP</B></option>
					<%
					List alertData1 = CommonUtils.getState();
					for (int i = 0; i < alertData1.size(); i++) 
					{
						String IP = (String) alertData1.get(i);
						%> 
						<option value="<%=IP%>"><%=IP%></option>
						<%
					}
					%>
		 		</select>
		 		<br><br> --%>
		<input type="submit" name="Submit" value="Submit"
			style="border-radius: 5px; width: 70px; right: 750px; position: absolute;" />
		</form>
		<form action="index.jsp">
			<button name="Back"
				style="border-radius: 5px; width: 70px; display: inline-block;">Back</button>
		</form>
		<br>
		<br>
		<!-- <form action="index.jsp">
       			<button name="Home" style="border-radius:5px;width:100px;display:inline-block;">Home</button>
       		</form> -->

	</div>



	<%-- <div id="lmenuLive" style="display: inline-block;">	
					<!-- <button id="button" onclick="my()" style="top:60px;right:0; position:absolute; "><B>Client Response Time</B></button> -->
						
					<form name="form" id="form" action="index.jsp" method="POST">
						<font color="#3399FF" size="15px"><B> Start Time</B></font>
						<input size="12" type="Text" id="demo1" name="startTime" value="<%=startTime%>" onclick="javascript:NewCssCal ('demo1','ddMMyyyy','dropdown',true,'24',true)"style="cursor: pointer;width:100px;" />  
						<font color="#3399FF" size="25px"><B>End Time </B></font>
						<input size="12" type="Text" name="endTime" id="demo2" value="<%=endTime%>" onclick="javascript:NewCssCal ('demo2','ddMMyyyy','dropdown',true,'24',true)" style="width:100px;"/>
			        	<br><font color="#3399FF" size="15px"> <B>IP address</B></font>
		    	   		<select name='IP' id='IP' onclick="getURL()" style="">
							<option value='-1'>Select IP</option>
							<%
							List alertData1 = CommonUtils.getAllIPandURL();
							for (int i = 0; i < alertData1.size(); i++) {
								String IP = (String) alertData1.get(i);
								//////System.out.println("IPPPPPPPPPPPPPPP"+IP);
								//String endpointDesc = (String) alertData.get(IP);
								%> 
								<option value="<%=IP%>"><%=IP%></option>
								<%
							}
							%>
 						</select>
						<div id="URL" style="top:50px;position:absolute;" > 
							<font color="#3399FF"><b>URL</b></font>
							<select name='URL' id='URL1' style="position:absolute;display:inline-block;right:100px;width:100px;top:0;max-width:200px">
								<option value='-1'>Select URL</option>
							</select>
						</div>   
						<button name='cmd' style="width: 100px; position:absolute;right:0; top:30px;" onclick="return IsEmpty();"  ><B>Submit</B></button> 
					</form>
				</div>  --%>




	<%@include file="Footer.jsp"%>

	<!-- <footer>
    		<p>Copyright &copy; Page Insight | <a href="http://www.avekshaa.com/">Avekshaa Technologies Private Limited</a> </p>
		</footer> -->
</body>
</html>