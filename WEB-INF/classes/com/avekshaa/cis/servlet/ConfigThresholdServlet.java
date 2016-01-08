package com.avekshaa.cis.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ConfigS
 */
public class ConfigThresholdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	public ConfigThresholdServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String role = request.getParameter("role");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		//System.out.println(request.getParameter("WebResponse"));
		//System.out.println("ROLEEE"+request.getParameter("role"));

		try {
			ConfigBean conf = new ConfigBean();
			
			// conf.setName(request.getParameter("name").concat(config));
			conf.setIncident(Integer.parseInt(request.getParameter("BufferThreshold")));
			conf.setResponse(Integer.parseInt(request.getParameter("AndroidResponseThreshold")));
			/*conf.setAlerts(Integer.parseInt(request.getParameter("Alerts")));*/
			//conf.setResponse(Integer.parseInt(request.getParameter("liveDur")));
			//conf.setResponse(Integer.parseInt(request.getParameter("inciDur")));
			
			conf = ConfigDAO.configMtd(conf);
			if (conf.isValid())
	        {  
				request.setAttribute("PremiumUser", request.getParameter("Device"));
						response.sendRedirect("view/jsp/ConfigThreshold.jsp?value=Added SucessFully&role="+role+"");
		
		}

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


}
