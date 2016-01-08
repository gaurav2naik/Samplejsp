package com.avekshaa.cis.jio;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.avekshaa.cis.engine.GetChartDataForBranch;

/**
 * Servlet implementation class GetPieChartDataForBranch
 */
public class GetPieChartDataForBranch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetPieChartDataForBranch() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String responseTypeCase1 = "tfuwhr";
		String responseTypeCase2 = "tfuwhe";

		String responseType = request.getParameter("type");
		if (responseType.equals(responseTypeCase1)) {
			GetChartDataForBranch pieData = new GetChartDataForBranch();
			String chData = pieData.getTopFiveUsersWithHighestResponse();
			// System.out.println("Player buffer chdata "+chData);
			out.print(chData);
		} else if (responseType.equals(responseTypeCase2)) {
			GetChartDataForBranch pieData = new GetChartDataForBranch();
			String chData = pieData.getTopFiveUsersWithHighestError();
			// System.out.println("Android chdata "+chData);
			out.print(chData);
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
