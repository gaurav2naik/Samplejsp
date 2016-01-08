<%@page import="com.avekshaa.cis.engine.ExceptionDataCalculate"%>
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
<title>App Crash Report |CIS</title>

<%
	String day=request.getParameter("day");
	long dateOnly=ExceptionDataCalculate.CalculateDay(day);
	DB db = CommonDB.getBankConnection();
	DBObject findObj=new BasicDBObject("StartTime",new BasicDBObject("$gt",dateOnly));
	DBCollection colls1 = db.getCollection("Error");
	BasicDBObject sortobj = new BasicDBObject("_id", -1);

	DBCursor value = colls1.find(findObj).sort(sortobj);
	System.out.println("cursor " + value.count());
	List<DBObject> dbObjss1 = value.toArray();
	System.out.println("List Size" + dbObjss1.size());
%>


<!-- <link rel="stylesheet" type="text/css"
	href="../css/table_css/normalize.css" />  -->
<!-- <link rel="stylesheet" type="text/css" href="../css/table_css/demo.css" /> -->
<!--  <link rel="stylesheet" type="text/css"
	href="../css/table_css/component.css" /> -->
<link rel="stylesheet" type="text/css"
	href="../css/table_css/pop-up.css" />

<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<!-- <link href="../css/treemenu.css" rel="stylesheet" type="text/css" /> -->
<!-- <link href="../css/header.css" rel="stylesheet" type="text/css" /> -->
<link rel="stylesheet" href="../css/button.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- <script type="text/javascript" src="../script/jquery-1.11.3.min.js"></script> -->
<script type="text/javascript" src="../script/jquery.dataTables.min.js"></script>
<link href="../css/jquery.dataTables.min.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript">
	$(document).ready(function() {
		$('#myTable').DataTable({"aaSorting": [[ 1, 'desc' ]],/* "paging":false,"scrollY":"350px","scrollCollapse":true, */});
		 
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
				<!-- <thead>
					<tr>
						<th colspan="7"><h1>Crash Report</h1></th>

					</tr>
				</thead>

				<br> -->

				<thead>
					<tr>
						<th><h3>UUID</h3></th>
						<th><h3>Time</h3></th>
						<th><h3>File</h3></th>
						<th><h3>class</h3></th>
						<th><h3>LineNumber</h3></th>
						<th><h3>Method</h3></th>
						<th><h3>Exception</h3></th>
						<th></th>

					</tr>
				</thead>


				<tbody>
					<%
						for (int i = 0; i <dbObjss1.size()  ; i++) {
							DBObject txnDataObject = dbObjss1.get(i);
							String stackTrace=txnDataObject.get("stackTrace").toString();
							//System.out.println("time :"+txnDataObject.get("Time"));
							
							StringBuffer sb= new StringBuffer();
							String split[]=stackTrace.split("\n");
																																																																							  
							String space="_ ";

							for(int k=0;k<split.length;k++)
								{
																		
								for(int j=0;j<=k;j++)
									{
									 sb.append(space);
									}
									sb.append(split[k]);
							        sb.append("<br>");
									}
																																																						 
							String stackString=sb.toString();
									
					%>

					<tr>
						<td><%=txnDataObject.get("UUID")%></td>
						<td><%=txnDataObject.get("Time")%></td>
						<td class="short"><%=(String) txnDataObject.get("File")%></td>
						<td class="short"><%=(String) txnDataObject.get("class")%></td>
						<td><%=(String) txnDataObject.get("LineNumber")%></td>
						<td class="short"><%=(String) txnDataObject.get("Method")%></td>
						<td class="long"><%=(String) txnDataObject.get("Exception")%></td>
						<td><button type="button" class="btn btn-info btn-lg"
								data-toggle="modal" data-target="#myModal<%=i%>">more</button>
							<div class="modal fade" id="myModal<%=i %>" role="dialog">
								<div class="modal-dialog">

									<!-- Modal content-->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">Detail Report</h4>
										</div>
										<div class="modal-body">
											<p>
												<%=stackString %></p>
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


	<!-- <script type="text/javascript" src="../../Script/jquery.min.js"></script> -->
	<!-- <script>
		$(function() {

			var appendthis = ("<div class='modal-overlay js-modal-close'></div>");

			$('a[data-modal-id]').click(function(e) {
				e.preventDefault();
				$("body").append(appendthis);
				$(".modal-overlay").fadeTo(500, 0.7);
				$(".js-modalbox").fadeIn(500);
				var modalBox = $(this).attr('data-modal-id');
				$('#' + modalBox).fadeIn($(this).data());
			});

			$(".js-modal-close, .modal-overlay").click(function() {
				$(".modal-box, .modal-overlay").fadeOut(500, function() {
					$(".modal-overlay").remove();
				});

			});

			$(window).resize(
					function() {
						$(".modal-box").css(
								{
									top :  ($(window).height() - $(".modal-box")
											.outerHeight()) / 2 ,
									left :  ($(window).width() - $(".modal-box")
											.outerWidth()) / 2 
								});
					});

			$(window).resize();

		});
	</script> -->


	<div id="footer-bottom">Copyright © avekshaa.com</div>
</body>
</html>