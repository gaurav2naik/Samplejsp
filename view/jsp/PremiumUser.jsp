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
<title>Customer Experience | Premium user</title>
<link rel="stylesheet" type="text/css" href="../css/index.css" />
<script type="text/javascript" src="../script/styleswitcher.js"></script>

<link rel="stylesheet" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/treeMenu.css" />
</head>
<body id="pu">
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>

	<div id="" align="center" style="padding: 5px">
		<form action="Hotuser.jsp?role=<%out.println(role);%>" method="post">
			Select Premium user : <select name='Device' id='Device'>

				<%
					List Devicename = CommonUtils.getPremiumdevice();
					//System.out.println("Premium device"+Devicename);
					for (int i = 0; i < Devicename.size(); i++) {

						String IP = (String) Devicename.get(i);
						////System.out.println("IPPPPPPPPPPPPPPP"+IP);
						//String endpointDesc = (String) alertData.get(IP);
				%>
				<option value="<%out.println(IP);%>">
					<%
						out.println(IP);
					%>
				</option>
				<%
					}
				%>

			</select>
			<button name='cmd'>Submit</button>
		</form>
	</div>
	<div id="footer-bottom">Copyright © avekshaa.com</div>
</body>
</html>