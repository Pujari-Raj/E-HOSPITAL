package com.learning.hospital;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Logout_Invalidate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Logout_Invalidate() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		
		//Invalidating the useer session and send it to home page using remove attribute method
		HttpSession session = request.getSession();
		session.removeAttribute("customer");
		
		//After invalidating user forward user to index page
		request.getRequestDispatcher("index.jsp").forward(request, response);;
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
