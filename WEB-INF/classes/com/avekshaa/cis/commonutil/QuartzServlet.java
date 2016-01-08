package com.avekshaa.cis.commonutil;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import com.avekshaa.cis.quartzjob.TestTrigger;

/**
 * Servlet implementation class QuartzServlet
 */
public class QuartzServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String DBName=null;
	public void setDBName1 (String NAme){
		DBName=NAme;
	}
	public String getDBName1 (){
		return DBName;
	}

	public void init() throws ServletException {
		
			
		try {
		//	System.out.println("Quartz scheduler called");

 TestTrigger tt = new TestTrigger();
			
		
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	}
	


