
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.avekshaa.cis.database.CommonDB"%>
<%@page import="com.avekshaa.cis.login.UserBean"%>
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
<%--  <%String role =(request.getParameter("role")).toString();    %> --%>
<%
	String role = (String) session.getAttribute("Role");
	UserBean currUser = (UserBean) session
			.getAttribute("currentSessionUser");
%>
<title>Update Profile |CIS</title>
</head>
<body id="cg">
	<%@include file="Header.jsp"%>
	<%@include file="menu.jsp"%>

	<br>
	<div id="listing"
		style="margin-left: 25%; margin-right: 25%; margin-top: 5%; margin-bottom: 10%;">
		<form action="../../UpdateProfile?role=<%out.println(role);%>"
			method="get">


			<%
				//PREVIOUS THRESHOLD

				String userName = null;
				String email = null;
				String mobile = null;
				DBCursor cursor = null;

				try {
					//1.connect to mongo// host+port
					/*   Mongo m=new Mongo("192.168.0.25",27017);
					 */
					//2.connect to your DB
					DB db = CommonDB.getConnection();
					//System.out.println("DB Name:"+db.getName());

					//3.selcet the collection
					DBCollection coll = db.getCollection("first");
					System.out.println("collection name:" + coll.getName());

					System.out.println("collection user:" + currUser.getUsername());
					BasicDBObject findObj = new BasicDBObject("UserName",
							currUser.getUsername());
					cursor = coll.find(findObj);
					//cursor.sort(new BasicDBObject("_id", -1));

					cursor.limit(1);
					List<DBObject> dbObjs = cursor.toArray();

					for (int i = dbObjs.size() - 1; i >= 0; i--)

					{
						DBObject txnDataObject = dbObjs.get(i);
						userName = (String) txnDataObject.get("UserName");
						email = (String) txnDataObject.get("Email");
						mobile = (String) txnDataObject.get("Mobile");

					}
					System.out.println(userName + " " + email + " " + mobile);
				}

				catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (cursor != null)
						cursor.close();
				}
			%>

			<h1>Profile Update</h1>

			<label>User Name :</label><input placeholder="<%=userName%>"
				type="text" name="userName" value="<%=userName%>"
				readonly="readonly"> <label>Email :</label> <input
				placeholder="<%=email%>" type="text" name="email" value="<%=email%>">
			<label>Mobile :</label> <input placeholder="<%=mobile%>" type="text"
				name="mobile" value="<%=mobile%>">
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