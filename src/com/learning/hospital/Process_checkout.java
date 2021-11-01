package com.learning.hospital;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Process_checkout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Process_checkout() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Getting the value of productid from(Single_product) input type ='hidden's attribute name ='productid'
		//Getting the value of slotdate from(Bookservices) input type ='hidden's attribute name ='SDate'
		//Getting the value of slottime from(Booksercvices) input type ='hidden's attribute name ='STime'
		
		String pId = request.getParameter("productid");
		String slotdate = request.getParameter("slotDate");
		String slottime = request.getParameter("slotTime");
		
		String producttype = request.getParameter("producttype");
		System.out.println("prodcuttype- "+producttype);
		
		//Checking if user session is continued or not . If it is continued then forward to Bookservice page.
		//else forward user to login and book the service he needs.
		if(Utility.user_login_Validate(request)==true)
		{
			//checkoutMap.put("productId", pId);
			//Getting the user selected ProductId in request object
			//Getting SlotDate and Time in request object from Bookservices
			request.setAttribute("selectedPid", pId);
			request.setAttribute("slotDate", slotdate);
			request.setAttribute("slotTime", slottime);
			request.setAttribute("productType", producttype);
			
			request.getRequestDispatcher("Bookservices.jsp").forward(request, response);;
		}
		
		// If user is not logged in then get the product id of product which user want to use 
		//In line 56 setting the productid 
		else if(Utility.user_login_Validate(request)==false)
		{
			//Setting the value of productid which is coming from the singleproduct.jsp
			request.setAttribute("lastVisitedPage", pId);
			request.getRequestDispatcher("Login.jsp").forward(request, response);
		}
		//doGet(request, response);
	}
}