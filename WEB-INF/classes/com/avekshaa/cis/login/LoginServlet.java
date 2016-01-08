package com.avekshaa.cis.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class LoginServlet extends HttpServlet {
	static final Logger logger = Logger.getRootLogger();
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, java.io.IOException {
		response.setContentType("text/html");
		// System.out.println("Login Servlet");
		String role = request.getParameter("role");
		String userName = request.getParameter("userName");
		String pass = request.getParameter("password");
		// String[] ans = request.getParameterValues("role");
		try {
			AdminBean admin = new AdminBean();
			admin.setUserName(userName);
			admin.setPassword(pass);
			admin = AdminDAO.login(admin);
			// System.out.println(request.getParameter("userName")+"  "+request.getParameter("password")+"  "+role+"  "+ans);
			UserBean user = new UserBean();
			user.setUserName(userName);
			user.setPassword(pass);
			// user.setRole(role);
			user = UserDAO.login(user);

			// 1.Validation of ADMIN--->AdminBean--->AdminDAO

			if (admin.isValid()) {

				// System.out.println("Valid ADMIN..................");
				// response.sendRedirect("view/jsp/ExsistingUsers.jsp");
				HttpSession session = request.getSession(true);
				session.setAttribute("currentSessionUser", admin);
				session.setAttribute("UN", userName);
				session.setAttribute("Role", role);
				response.sendRedirect("view/jsp/ExsistingUsers.jsp");
				// rd.include(request, response);

			}

			else

			if (user.isValid()) {

				HttpSession session = request.getSession(true);

				if (role.equals("Combined")) {
					session.setAttribute("currentSessionUser", user);
					session.setAttribute("UN", userName);
					session.setAttribute("Role", role);
					response.sendRedirect("view/jsp/NewWebAndAppDashbord.jsp?role="
							+ role);
					System.out.println("Valid CIO User..................");

					// Configuration.changeDBName(us1);;//Rohit

					/* response.sendRedirect("view/jsp/newdashboard.jsp"); */
					// rd.include(request, response);
				} else if (role.equals("Branch")) {
					session.setAttribute("currentSessionUser", user);
					session.setAttribute("UN", userName);
					session.setAttribute("Role", role);
					System.out.println("Valid IT ADMIN User..................");

					// Configuration.changeDBName(us1);;//Rohit

					response.sendRedirect("view/jsp/BranchDashboard.jsp?role="
							+ role);
				}
			}

			else {
				// //System.out.println("Invalid User..................");
				response.sendRedirect("index.jsp?err=Wrong Password");

			}

		}

		catch (Throwable theException) {
			// //System.out.println(theException);
			logger.error("Unexpected error", theException);
		}
	}
}
