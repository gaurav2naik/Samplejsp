package com.avekshaa.cis.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

/**
 * Servlet implementation class deleteservlet
 */
public class DeleteServlet extends HttpServlet {
	public static DB db;
	static {
		db = CommonDB.getConnection();

	}
	private static final long serialVersionUID = 1L;

	public DeleteServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		
		
		response.setContentType("text/html");
		String[] ans = request.getParameterValues("user");
		/*System.out.println("--->"+ans);
		out.println("here"+ans);
	*/
		
		
		
		
		DBCollection dbCollection = db.getCollection("first");
		
		BasicDBObject document = new BasicDBObject();
	
		for (String s : ans){			
	//	System.out.println("--000"+s);
			document.put("UserName", s);
			// DBCursor dbCursor = dbCollection.find(document);
			dbCollection.remove(document);
		
		}
		HttpSession session = request.getSession(true);
		
			//System.out.println("User Deleted Successfully...");
			session.setAttribute("userCreationStatus",
					"User Deleted Successfully...");
			response.sendRedirect("view/jsp/ExsistingUsers.jsp");
			out.close();
		}
		

	

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}