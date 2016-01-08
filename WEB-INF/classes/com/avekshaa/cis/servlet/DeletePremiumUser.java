package com.avekshaa.cis.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.avekshaa.cis.login.UserMasterBean;
import com.avekshaa.cis.login.UserMasterDAO;

/**
 * Servlet implementation class DeletePremiumUser
 */
public class DeletePremiumUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeletePremiumUser() {
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String role = request.getParameter("role");
		String Device = request.getParameter("Device");

		UserMasterBean userMasterBean = new UserMasterBean();
		userMasterBean.setPremiumuser(Device);

		userMasterBean = UserMasterDAO.deletePremiumUser(userMasterBean);

		if (userMasterBean.isValid()) {

			request.setAttribute("PremiumUser", request.getParameter("Device"));

			response.sendRedirect("view/jsp/Configuration.jsp?status=Removed SucessFully&role="
					+ role + "");
		}

		else {
			response.sendRedirect("view/jsp/Configuration.jsp?status=Already Removed&role="
					+ role + "");
		}

	}

}
