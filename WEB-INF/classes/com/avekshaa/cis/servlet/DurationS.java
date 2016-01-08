package com.avekshaa.cis.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.avekshaa.cis.quartzjob.TestTrigger;

/**
 * Servlet implementation class ConfigS
 */
public class DurationS extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	public DurationS() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		

		try {
			// String config="_config";

			ConfigQuartzBean conf = new ConfigQuartzBean();
			
			//System.out.println(Integer.parseInt(request.getParameter("avgalert"))+"  "+Integer.parseInt(request.getParameter("incident"))+"  "+Integer.parseInt(request.getParameter("usage")));
			

			
			conf.setLiveAlerts(Integer.parseInt(request.getParameter("avgalert")));
			conf.setIncident(Integer.parseInt(request.getParameter("incident")));
			conf.setUsagetime(Integer.parseInt(request.getParameter("usage")));
			
			conf = ConfigQuartzDAO.configMtd(conf);
			//TestTrigger tt = new TestTrigger();
			
			/*tt.stopQuartz();
			TestTrigger pp =new TestTrigger();
			*/
			
			out.println("stored in DB ConfigQuartz");
		}

		catch (Exception E) {
			E.printStackTrace();

		}
		finally{
			out.close();
		}

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
