package com.avekshaa.cis.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

/**
 * Servlet implementation class exsist
 */
public class ExistingUsers extends HttpServlet{
	static final Logger logger = Logger.getRootLogger();
	public static DB m;
	static {
		m = CommonDB.getConnection();
	}
	private static final long serialVersionUID = 1L;

	public ExistingUsers() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		out.println("<h1><center>Existing Users</center></h1>");
		DBCursor alertData=null;
		try {

			// //System.out.println("DB Name:"+m.getName());

			DBCollection coll = m.getCollection("first");

			BasicDBObject findObj = new BasicDBObject();
			// //System.out.println("collection name:"+coll.getName());

			 alertData = coll.find(findObj);

			List<DBObject> dbObjs = alertData.toArray();
			// //System.out.println("dbObj  size :"+dbObjs.size());

			String name[] = new String[dbObjs.size()];
			for (int i = dbObjs.size() - 1; i >= dbObjs.size() - 50; i--) {
				DBObject txnDataObject = dbObjs.get(i);
				String nam = (String) txnDataObject.get("UserName");
				// String uaid = (String) txnDataObject.get("UserId");
				name[i] = nam;

				// NAME---
				request.setAttribute("name", name);

			}

			RequestDispatcher rd = request
					.getRequestDispatcher("/ExsistingUsers.jsp");
			rd.include(request, response);

		} catch (Exception e) {
			// e.printStackTrace();
			logger.error("Unexpected error",e);
		}
		finally{
			alertData.close();
		}

		out.println("<br>");

		out.println("<center><a href='DeletionForm.jsp'><h2>Delete User</h2> </a>");
		out.println("<center><a href='AdminForm.jsp'><h2>Create User</h2></a>");
		out.close();
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	}

	public static ArrayList<String> name() {
		ArrayList<String> list = new ArrayList<String>();
		DBCursor alertData=null;
		try{
		DBCollection coll = m.getCollection("first");
		BasicDBObject findObj = new BasicDBObject();
		 alertData = coll.find(findObj);
		List<DBObject> dbObjs = alertData.toArray();
		for (int i = 0; i < dbObjs.size(); i++) {
			DBObject txnDataObject = dbObjs.get(i);
			String nam = (String) txnDataObject.get("UserName");
			list.add(nam);
		}}
		catch (Exception e) {
			// e.printStackTrace();
			logger.error("Unexpected error",e);
		}
		finally{
			alertData.close();
		}

		return list;
	}
}
