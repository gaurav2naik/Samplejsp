<%@page import="com.avekshaa.cis.engine.ExceptionDataCalculate"%>
<%@page import="com.avekshaa.cis.servlet.CreateTableRecentTen"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="java.util.List"%>
<%@page import="com.mongodb.DBObject"%>
<%
	String role = (String) session.getAttribute("Role");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Web Incident Report |CIS</title>

<%
String day=request.getParameter("day");
long dateOnly=ExceptionDataCalculate.CalculateDay(day);
	String Error_Detail="No more Details Available";
	DB db=CommonDB.getConnection();
	List<DBObject> dbObjss1 = CreateTableRecentTen.getIncidentTableData(dateOnly);
	System.out.println("List Size" + dbObjss1.size());
%>
<link rel="stylesheet" type="text/css"
	href="../css/table_css/pop-up.css" />
<link href="../css/jquery.dataTables.min.css" rel="stylesheet"
	type="text/css" />
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/button.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../script/jquery.dataTables.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#myTable').DataTable({
			"aaSorting" : [ [ 1, 'desc' ] ],/* "paging":false,"scrollY":"350px","scrollCollapse":true, */
		});

	});
</script>
<style type="text/css">
html {
	position: relative;
	min-height: 100%;
}
</style>
</head>

<body id="eg">
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>
	<center>
		<div class="component">

			<table id="myTable" align="center" class="display" cellspacing="0"
				style="width: 100%; font-size: 12px;">
				<thead>
					<tr>
						<th><h3>Time</h3></th>
						<th><h3>IP Address</h3></th>
						<th><h3>URI</h3></th>
						<th><h3>Device</h3></th>
						<th><h3>Browser</h3></th>
						<th><h3>OS</h3></th>
						<th><h3>Status Code</h3></th>
						<th></th>
					</tr>
				</thead>


				<tbody>
					<%
						for (int i = 0; i < dbObjss1.size(); i++) {
							DBObject txnDataObject = dbObjss1.get(i);

							double status = Double.parseDouble(txnDataObject.get(
									"status_Code").toString());
							int responseTime = (int) status;
							String errorstatus = Integer.toString(responseTime);
							DBCollection errorlist = db.getCollection("Errorlist");
							BasicDBObject err = new BasicDBObject();
							DBCursor dd = errorlist.find(err);
							List<DBObject> dbObjs1 = dd.toArray();
							// //System.out.println("error detail"+dbObjs1);
							for (int j = dbObjs1.size() - 1; j > dbObjs1.size() - 2; j--) {
								try {

									DBObject txnDataOb = dbObjs1.get(j);
									Error_Detail = (String) txnDataOb.get(errorstatus);
									// //System.out.println(Error_Detail+"  "+errorstatur);

								} catch (Exception e) {
									e.printStackTrace();
								}
							}
					%>

					<tr>
						<td><%=txnDataObject.get("Date")%></td>
						<td><%=txnDataObject.get("IP_Address")%></td>
						<td class="short"><%=txnDataObject.get("URI")%></td>
						<td class="short"><%=txnDataObject.get("Device")%></td>
						<td><%=txnDataObject.get("Browser")%></td>
						<td class="long"><%=txnDataObject.get("OS")%></td>
						<td class="short"><%=txnDataObject.get("status_Code")%></td>

						<td><button type="button" class="btn btn-info btn-lg"
								data-toggle="modal" data-target="#myModal<%=i%>">more</button>
							<div class="modal fade" id="myModal<%=i%>" role="dialog">
								<div class="modal-dialog">

									<!-- Modal content-->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">Detail Report</h4>
										</div>
										<div class="modal-body">
											<p>
												<%=Error_Detail%></p>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">Close</button>
										</div>
									</div>

								</div>
							</div></td>


					</tr>

					<%
						}
					%>

				</tbody>

			</table>
		</div>

	</center>

	<div id="footer-bottom">Copyright © avekshaa.com</div>
</body>
</html>