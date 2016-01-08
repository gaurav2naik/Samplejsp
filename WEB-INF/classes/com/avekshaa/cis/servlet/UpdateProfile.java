package com.avekshaa.cis.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.avekshaa.cis.login.UserMasterBean;
import com.avekshaa.cis.login.UserMasterDAO;

/**
 * Servlet implementation class UpdateProfile
 */
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String role = request.getParameter("role");
		//System.out.println(role);
		try {
			UserMasterBean userMasterBean = new UserMasterBean();
			userMasterBean.setUserName(request.getParameter("userName"));
			userMasterBean.setEmail(request.getParameter("email"));
			userMasterBean.setMobile(request.getParameter("mobile"));
			userMasterBean = UserMasterDAO.modifyUser(userMasterBean);
			response.sendRedirect("view/jsp/updateProfile.jsp?value=Added SucessFully&role="+role+"");
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
