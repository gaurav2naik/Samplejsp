<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.avekshaa.cis.database.CommonUtils"%>
<%@page import="java.util.*"%>

<%@page import="com.avekshaa.cis.database.*"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="java.util.List"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>

<%
	String role = (String) session.getAttribute("Role");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/index.css" />
<script type="text/javascript" src="../script/styleswitcher.js"></script>
<script type="text/javascript" src="../script/jquery-1.11.3.min.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />
<link rel="icon" href="../image/title.png" type="image/png">
<link href="../css/treeMenu.css" rel="stylesheet" type="text/css" /> -->
<link rel="stylesheet" href="../css/button.css">
<link href="../css/header.css" rel="stylesheet" type="text/css" />
<!-- <script type='text/javascript' src='../script/treeMenu.js'></script> -->
<title>Customer Experience | Configuration</title>
</head>
<body id="cg">
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>

	<center>
		<h1>Configuration</h1>
	</center>
	<div id="Control">
		<div id="AddPremiumUser"
			style="display: inline; width: 30%; float: left; padding-left: 10%">
			<form action="../../AddPremiumUser?role=<%out.println(role);%>"
				method="post" name="addPremiumUser">
				Select Device to add: <br> <select name='Device' id='Device'>


					<%
						Collection<String> Devicenam = CommonUtils.getdevice();
									//	System.out.println("DEVICE");
									Iterator iterator1 = Devicenam.iterator();
									if (!iterator1.hasNext()) {
										//System.out.println("Inside if");
					%>
					<option value="noDevice" selected="selected">No new
						Devices</option>
					<%
						} else {
					%>
					<option value="select" selected="selected">Select</option>
					<%
						//System.out.println("inside Else");
									// check values
									while (iterator1.hasNext()) {
									String Device = iterator1.next().toString();
					%>
					<option value="<%out.println(Device);%>">
						<%
							out.println(Device);
						%>
					</option>
					<%
						}
																											}
					%>

				</select> <input type="submit" value="Submit" id="submit"
					onclick=" return checkStatusForUserTobeAdded();" />
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
			<br> <br> <a
				href="ConfigThreshold.jsp?role=<%out.println(role);%>">
				Threshold Configuration </a><br> <a
				href="updateProfile.jsp?role=<%out.println(role);%>"> Edit
				Profile </a> <br> 
				<a href='javascript: submitformConfig()'><span>Branch
					Configuration</span></a>

		</div>

		<!-- Delete user form by Ashish-->

		<div id="deletePremiumUser"
			style="display: inline; width: 30%; float: right; padding-right: 10%">
			<form action="../../DeletePremiumUser?role=<%out.println(role);%>"
				method="post" name="deletePremiumUser">
				Select Device to Remove: <br> <select name='Device' id='Device'>


					<%
						Collection<String> premiumDeviceName = CommonUtils.getPremiumDevices();
						//	System.out.println("DEVICE");
						Iterator iterator = premiumDeviceName.iterator();
						if (!iterator.hasNext()) {
						//System.out.println("Inside if");
					%>
					<option value="noDevice" selected="selected">No new
						Devices</option>
					<%
						} else {
					%>
					<option value="select" selected="selected">Select</option>
					<%
						//System.out.println("inside Else");
																												// check values
																												while (iterator.hasNext()) {
																													String Device1 = iterator.next().toString();
					%>
					<option value="<%out.println(Device1);%>">
						<%
							out.println(Device1);
						%>
					</option>
					<%
						}
																											}
					%>

				</select> <input type="submit" value="Submit" id="submit"
					onclick=" return checkStatusForUserTobeDeleted();" />
			</form>

			<p>
				<%
					if (request.getParameter("status") != null) {
				%>
			
			<div style="color: red">
				<label><%=request.getParameter("status")%></label>
			</div>
			<%
				}
			%>
			</p>
		</div>
	</div>

	</div>
	<form name='ConfigForm' target="" action='http://52.25.239.131/default.jsp' method='post'>
<input type="hidden" name="Role" value="CIO"/>
<input type="hidden" name="UN" value="<%out.print(session.getAttribute("UN"));%>"/>
</form>

	<script type="text/javascript">
		function submitformConfig() {
			
			if (document.ConfigForm.onsubmit && !document.ConfigForm.onsubmit()) {
				alert("hi");
				return;
			}
			document.ConfigForm.submit();
		}
	</script>
	<script>
		function checkStatusForUserTobeAdded() {

			var status = document.addPremiumUser.Device.value;

			if (status == "noDevice") {
				alert("No new Devices to Add!!!")
				return false;
			} else if (status == "select") {
				alert("Please Select Some Device!!!");
				return false;
			} else {
				return true;
			}
		}

		function checkStatusForUserTobeDeleted() {

			var status = document.deletePremiumUser.Device.value;

			if (status == "noDevice") {
				alert("No new Devices to Add!!!")
				return false;
			} else if (status == "select") {
				alert("Please Select Some Device!!!");
				return false;
			} else {
				return true;
			}
		}
	</script>
	<div id="footer-bottom">Copyright © avekshaa.com</div>
</body>
</html>