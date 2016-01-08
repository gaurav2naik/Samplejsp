package com.avekshaa.cis.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.avekshaa.cis.login.UserMasterBean;
import com.avekshaa.cis.login.UserMasterDAO;

public class AddPremiumUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddPremiumUser() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String role = request.getParameter("role");

		UserMasterBean userMasterBean = new UserMasterBean();
		userMasterBean.setPremiumuser(request.getParameter("Device").replace(
				"\r\n", ""));

		userMasterBean = UserMasterDAO.createPremiumUser(userMasterBean);

		if (userMasterBean.isValid()) {

			request.setAttribute("PremiumUser", request.getParameter("Device"));

			response.sendRedirect("view/jsp/Configuration.jsp?value=Added SucessFully&role="
					+ role + "");
		}

		else {
			response.sendRedirect("view/jsp/Configuration.jsp?value=Already Added&role="
					+ role + "");
		}

	}

}