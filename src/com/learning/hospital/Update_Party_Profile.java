package com.learning.hospital;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class Update_Party_Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Update_Party_Profile() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String partyID = request.getParameter("partyid");
		System.out.println("party name-"+partyID);
		
		String partyname = request.getParameter("party_name");
		System.out.println("party name-"+partyname);
		
		String partyMname = request.getParameter("party_mname");
		System.out.println("party name-"+partyMname);
		
		String partyEmail = request.getParameter("party_email");
		System.out.println("party name-"+partyEmail);
		
		String partyMobile = request.getParameter("party_mobil_no");
		System.out.println("party name-"+partyMobile);
		
		String partyPassword = request.getParameter("party_pswd");
		System.out.println("party name-"+partyPassword);
		
		//System.out.println("hell");
		
		int i=0;
		//JDBC Connection 
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		
		//Updating party-details  
		try 
		{
			//System.out.println("in servlet");
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			PreparedStatement prepstatement = conn.prepareStatement("update PARTY set  FNAME = ?,  MNAME = ?, PHONENO = ?, EMAIL =?, PSWD = ? where PARTYID = ?");
			prepstatement.setString(1,partyname);
			prepstatement.setString(2, partyMname);
			prepstatement.setString(3,partyMobile);
			prepstatement.setString(4, partyEmail);
			prepstatement.setString(5,partyPassword);
			prepstatement.setString(6,partyID);
			
			
			i = prepstatement.executeUpdate();
			System.out.println("i val-"+i);
			// If all values gets insert into Dbase then forward user to (Login.jsp) else throw exception
			//to forward user from one page to another use RequestDispatcher/ sednRedirect
			if(i>0)
			{
				request.setAttribute("success_message", "Date Updated Successfully");
				RequestDispatcher dispatcher = request.getRequestDispatcher("Your_Profile.jsp");
				dispatcher.include(request, response);;
			}
		}
		catch (ClassNotFoundException e) 
		{
			System.out.println("Clas Not FOund Exception in Admin_Add_Party"+e.getMessage());
		} 
		catch (SQLException e) 
		{
			System.out.println("SQL Exception  in Admin_Add_Party"+e.getMessage());
		}
	}

}
