package com.avekshaa.cis.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LiveReportserv
 */
public class LiveReportserv extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LiveReportserv() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String IP1 = request.getParameter("IP");
		// //System.out.println("IPPPPPPPPPPPPPPPPPPPPPPPPPp"+IP1);
		IPDAO ipd = new IPDAO();
		String URL = ipd.getURL(IP1);
		// //System.out.println("URRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRL"+URL);
		PrintWriter pw = response.getWriter();
		pw.println(URL);
		pw.close();
	}

}
