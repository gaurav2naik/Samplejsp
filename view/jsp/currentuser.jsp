<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.avekshaa.cis.database.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	current user :
	<%
	DBCursor alertData = null;

	try {

		/* Mongo m=new Mongo("127.0.0.1",27017);
		
		
		//2.connect to your DB
		DB db=m.getDB("CIS"); */
		DB db = CommonDB.getConnection();
		////System.out.println("DB Name:"+db.getName());

		//3.select the collection
		DBCollection coll = db.getCollection("CISResponse");
		////System.out.println("IN threshold DAO"+coll.getName());

		//fetch name
		int currentuser = coll.distinct(
				"IP_Address",
				new BasicDBObject("exectime", new BasicDBObject("$lt",
						System.currentTimeMillis()).append("$gt",
						System.currentTimeMillis() - 172800000)))
				.size();
		out.println(currentuser);
		////System.out.println(currentuser);

	} catch (Exception e) {
		e.printStackTrace();

	} finally {

	}
%>

</body>
</html>