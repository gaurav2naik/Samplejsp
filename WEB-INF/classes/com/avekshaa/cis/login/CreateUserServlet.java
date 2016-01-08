package com.avekshaa.cis.login;

import java.util.UUID;
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

import org.apache.log4j.Logger;

import com.avekshaa.cis.commonutil.Configuration;
import com.avekshaa.cis.commonutil.ConfigurationVo;

/**
 * Servlet implementation class dupservlat
 */
public class CreateUserServlet extends HttpServlet {
	static final Logger logger = Logger.getRootLogger();
	private static final long serialVersionUID = 1L;
	  static ConfigurationVo vo = null;
	    static {
	        try
	          {
	            vo = Configuration.configure();
	       
	           }
	         catch (IOException e)
	              {
	              // e.printStackTrace();
	               logger.error("Unexpected error",e);
	              }
	           }
	public CreateUserServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String mail = request.getParameter("mail");
		String name = request.getParameter("name");
		String pass = request.getParameter("pwd");
		String mobile = request.getParameter("mobile");
		try {
			String uniqueID = UUID.randomUUID().toString();// unique id --UUID
															// class is used
			UserMasterBean userMasterBean = new UserMasterBean();
			userMasterBean.setUserName(request.getParameter("name"));
			userMasterBean.setPassword(request.getParameter("pwd"));
			userMasterBean.setUserId(uniqueID);
			userMasterBean.setMobile(mobile);
			userMasterBean.setEmail(mail);
			userMasterBean =UserMasterDAO.createUser(userMasterBean);
			 if (userMasterBean.isValid())
	            {                            
	                try{
	                    Properties props = new Properties();
	                    props.put("mail.smtp.host", "smtp.gmail.com"); // for gmail use smtp.gmail.com
	                    props.put("mail.smtp.auth", "true");
	                    props.put("mail.debug", "true");
	                    props.put("mail.smtp.starttls.enable", "true");
	                    props.put("mail.smtp.port", "465");
	                    props.put("mail.smtp.socketFactory.port", "465");
	                    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	                    props.put("mail.smtp.socketFactory.fallback", "false");
	                    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {

	                        protected PasswordAuthentication getPasswordAuthentication() {
	                            return new PasswordAuthentication(vo.getEmail(), vo.getPassword());
	                        }
	                    });
	                    mailSession.setDebug(true); // Enable the debug mode
	                    Message msg = new MimeMessage( mailSession );
	                    msg.setFrom( new InternetAddress(vo.getEmail()));
	                    msg.setRecipients( Message.RecipientType.TO,InternetAddress.parse(mail) );
	                    msg.setSentDate( new Date());
	                    msg.setSubject( "LOGIN DETAILS" );

					String ans1 = name;
					String ans2 = pass;

					msg.setText("Name=" + ans1 + "---Password=" + ans2);
					Transport.send(msg);

				} catch (Exception E) {
					//E.printStackTrace();
					logger.error("Unexpected error",E);
				}

				request.setAttribute("name", request.getParameter("name"));
				request.setAttribute("pass", request.getParameter("pwd"));
				request.setAttribute("UID", uniqueID);
				request.setAttribute("False", "NEW User created");
				RequestDispatcher rd = request
						.getRequestDispatcher("view/jsp/UserListing.jsp");
				rd.forward(request, response);
			}

			else {
				request.setAttribute("False",
						"USER ALRADY EXIT TRY Another USER ID");
				request.setAttribute("name", request.getParameter("name"));
				request.setAttribute("pass", request.getParameter("pwd"));
				RequestDispatcher rd = request
						.getRequestDispatcher("view/jsp/UserListing.jsp");
				rd.forward(request, response);
			}

		}

		catch (Exception E) {
			//E.printStackTrace();
			logger.error("Unexpected error",E);
		}

	}

}