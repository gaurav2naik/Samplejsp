package com.avekshaa.cis.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class GETABLE
 */
public class GetTableServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession session=request.getSession(false);
		CreateTableRecentTen cr = new CreateTableRecentTen();
	
			String id=request.getParameter("id");
			//System.out.println(id); 
			if(id.equals("recenttable"))
			{
		
				String IP = request.getParameter("IP");
				String URL = request.getParameter("URL");
				
				String table = cr.getTAble(IP, URL);
				PrintWriter pw = response.getWriter();
				pw.println(table);
				pw.close();

				}
			else if(id.equals("incidentCustomized"))
			{
				String startTime =request.getParameter("startTime");
				String EndTime = request.getParameter("endTime");
				String Incidenttable = cr.getIncident(startTime, EndTime);
				PrintWriter pw = response.getWriter();
				pw.println(Incidenttable);
				pw.close();
				
			}}}

