package com.learning.hospital;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.framework.entity.EntityQuery;

public class Change_Password extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Change_Password() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String sentOTP = request.getParameter("sentOtp");
		String partyMail = request.getParameter("partyEmail");
		System.out.println("sentOTP- "+sentOTP);
		
		String enteredOTP = request.getParameter("enteredOTP");
		System.out.println("enteredOTP- "+enteredOTP);
		
		
		String newpassword1 = request.getParameter("newPassword1");
		String newpassword2 = request.getParameter("newPassword2");
		
		if(sentOTP.equals(enteredOTP))
		{
			//Database Details
			String dburl ="jdbc:h2:tcp://localhost/~/test";
			String dbusrnm = "sa";
			String dbpwd = "sasa";
			
			try 
			{
				Class.forName("org.h2.Driver");
				Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd); 
				
				PreparedStatement preparedStatement2 = conn.prepareStatement("Update PARTY set PSWD = ?, CPSWD =?  where EMAIL = ?");
				preparedStatement2.setString(1, newpassword1);
				preparedStatement2.setString(2, newpassword2);
				preparedStatement2.setString(3, partyMail);
				
				preparedStatement2.executeUpdate();
				
			} 
			catch (ClassNotFoundException e) 
			{
				System.out.println("Error updating value in change password servlet"+e);
			} 
			catch (SQLException e) 
			{
				System.out.println("Error updating value in change password servlet"+e);
			}
			
			request.setAttribute("success_message", "Password Reset Successfully");
		  	RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
			dispatcher.forward(request, response);
		
		}	
		else
		{
			request.setAttribute("invalid_otp_err_msg", true);
		  	RequestDispatcher dispatcher = request.getRequestDispatcher("Change_Password.jsp");
			dispatcher.forward(request, response);
		}
		//doGet(request, response);
	}

}
