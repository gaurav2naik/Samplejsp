package com.avekshaa.cis.jio;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetPieChartData
 */
public class GetPieChartData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPieChartData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String responseTypeCase1 = "IOSApplicationResponse";
		String responseTypeCase2 = "IOSVerResponse";
		String responseTypeCase3 = "hitsCount";
		String responseTypeCase4 = "ApplicationResponse";
		String responseTypeCase5 = "AndroidResponse";
		String responseType = request.getParameter("type");
		if(responseType.equals(responseTypeCase1))
		{
			GetChartData pieData = new GetChartData();
			String chData = pieData.getIOSAppVerResponse();
			//System.out.println("Player buffer chdata "+chData);
			out.print(chData);
		}
		else if(responseType.equals(responseTypeCase2))
		{
			GetChartData pieData = new GetChartData();
			String chData = pieData.getIOSVersionResponse();
			//System.out.println("Android chdata "+chData);
			out.print(chData);
		}
		else if(responseType.equals(responseTypeCase3))
		{
			GetChartData pieData = new GetChartData();
			String chData = pieData.getPieChartData();
			out.print(chData);
		}
		else if (responseType.equals(responseTypeCase4)) {
			GetChartData chData = new GetChartData();
			String data = chData.getApplicationVersionResponse();
			out.print(data);
		}
		else if (responseType.equals(responseTypeCase5)) {
			GetChartData chDataForAndroid = new GetChartData();
			String data = chDataForAndroid.getAndroidVersionResponse();
			out.print(data);
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
