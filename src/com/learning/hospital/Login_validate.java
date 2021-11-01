package com.learning.hospital;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Login_validate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login_validate() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		//writer.print("hello from login validate servlet");
		
		//Taking the email and password from login_jsp
		String eml = request.getParameter("login_email");
		String pass = request.getParameter("login_password");
		String usernm = Utility.getUserFromEmail(eml);
		
		//If user's email and password is correct the start the user's session
		//Checking the user's email and password from (login_DAO class) If user gets successfully login then forward user to index page 
		// else to login.jsp with error
		if(Login_DAO.login_validate(eml, pass))
		{
			//Setting the session of the user using httpsession for getting Email-ID 
			//Starting the session of the user using httpsession for getting the username in header of website 
			
			HttpSession  session = request.getSession();
			session.setAttribute("customer", eml);
			
			
			//code for lastvisited page (getting productid from process_checkout) 
			//If productid is same when login then forward user to payment page
			//If the productid is same what is set in login.jsp then forward user to page(Single_product)
			if(request.getParameter("lastVisitedProductId")!=null) 
			{
				request.getRequestDispatcher("Single_product.jsp?ProductId="+request.getParameter("lastVisitedProductId")).include(request, response);
			}
			
			else 
			{
				request.setAttribute("success_message", "Logged In successfuly");
				request.getRequestDispatcher("index.jsp").include(request, response);
			}
		}
		
		
		
		//If username & password is not same then display errmsg
		else 
		{
			//request.setAttribute("usrnm_err_msg", true);
			request.setAttribute("error_message", "Wrong Username or password");
			RequestDispatcher rd=request.getRequestDispatcher("Login.jsp");
	        rd.include(request,response);
		}		
	}
}