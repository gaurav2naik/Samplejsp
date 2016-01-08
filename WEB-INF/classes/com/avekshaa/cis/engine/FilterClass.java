package com.avekshaa.cis.engine;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class FilterClass
 */
public class FilterClass implements Filter {

    /**
     * Default constructor. 
     */
    public FilterClass() {
        // TODO Auto-generated constructor stub
    }

/**
* @see Filter#destroy()
*/
public void destroy() {
// TODO Auto-generated method stub
}

/**
* @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
*/
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
// TODO Auto-generated method stub
// place your code here
//	//System.out.println("in side filter");
HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

HttpSession session = httpRequest.getSession(true);         
if (session == null || session.getAttribute("username") == null) {
//	      httpResponse.sendRedirect("index.jsp"); // No logged-in user found, so redirect to login page.
httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
   	httpResponse.setHeader("Pragma", "no-cache"); // HTTP 1.0.
   	httpResponse.setDateHeader("Expires", -1); 
//	httpResponse.sendRedirect("index.jsp");
chain.doFilter(httpRequest, httpResponse);
   } else {
   	
       chain.doFilter(httpRequest, httpResponse);  
   }
// pass the request along the filter chain
}

/**
* @see Filter#init(FilterConfig)
*/
public void init(FilterConfig fConfig) throws ServletException {
// TODO Auto-generated method stub
}

}

