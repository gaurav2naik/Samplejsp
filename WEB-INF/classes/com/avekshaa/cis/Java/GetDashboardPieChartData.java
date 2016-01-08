package com.avekshaa.cis.Java;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet implementation class GetAndroidJsonData
 */
public class GetDashboardPieChartData extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetDashboardPieChartData() {
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
		PrintWriter out = response.getWriter();
		String responseTypeCase1 = "hitsCount";
		String responseTypeCase2 = "responseAcrossDevices";
		String responseType = request.getParameter("type");
		System.out.println("responseType: " + responseType);
		if (responseType.equals(responseTypeCase1)) {
			System.out.println("inside " + responseTypeCase1);
			OneHourWeb obj1 = new OneHourWeb();
			OneHourAndroid obj2 = new OneHourAndroid();

			double ans1 = obj1.mtd();
			double ans2 = obj2.mtd();
//			System.out.println("ans1 :" + ans1 + " ans2 :" + ans2);
			String r = "{\"y\":" + ans1 + ",\"x\":" + ans2 + "}";
			out.print(r);
		} else if (responseType.equals(responseTypeCase2)) {
			System.out.println("inside " + responseTypeCase2);
			try {
				CPU cc = new CPU();
				Map<String, Double> map1 = cc.mtd();
				JSONArray jsonArray = new JSONArray();

				for (Iterator iterator = map1.keySet().iterator(); iterator
						.hasNext();) // Iterate through key and value of map
				{
					String Device = (String) iterator.next(); // iterate thru
						Device=Device.trim();										// key
					Double avg = (Double) map1.get(Device); // iterate thru
					if(!Device.equals("NoData")){
					JSONObject obj = new JSONObject();
					obj.put("name", Device);
					obj.put("y", avg);

					jsonArray.put(obj);
					}
				}
				out.println(jsonArray);
				System.out.println(jsonArray);
			} catch (Exception ex) {
				ex.printStackTrace();
			}

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
