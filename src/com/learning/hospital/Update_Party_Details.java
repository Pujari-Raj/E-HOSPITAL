package com.learning.hospital;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Update_Party_Details extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Update_Party_Details() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String partyID = request.getParameter("partyid");
		System.out.println("party name-"+partyID);
		
		String partyType = request.getParameter("partytype");
		System.out.println("party name-"+partyType);
		
		String partyFname = request.getParameter("fname");
		System.out.println("party name-"+partyFname);
		
		String partyMname = request.getParameter("mname");
		System.out.println("party name-"+partyFname);
		
		String partyLname = request.getParameter("lname");
		System.out.println("party name-"+partyFname);
		
		String partyDOB = request.getParameter("DOB");
		System.out.println("party name-"+partyFname);
		
		String partyMobile = request.getParameter("party_mobil_no");
		System.out.println("party name-"+partyMobile);
		
		String partyEmail = request.getParameter("party_email");
		System.out.println("party name-"+partyEmail);
		
		String partysaddr1 = request.getParameter("saddr1");
		System.out.println("party name-"+partyEmail);
		
		String partysaddr2 = request.getParameter("saddr2");
		System.out.println("party name-"+partyEmail);
		
		String partycity = request.getParameter("city");
		System.out.println("party name-"+partyEmail);
		
		String partystate = request.getParameter("state");
		System.out.println("party name-"+partyEmail);
		
		String partyzcode = request.getParameter("zcode");
		System.out.println("party name-"+partyEmail);
		
		String partyworkexp = request.getParameter("workexp");
		System.out.println("party name-"+partyEmail);
		
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
			PreparedStatement prepstatement = conn.prepareStatement("update PARTY set  PARTYTYPE = ?, FNAME = ?,  MNAME = ?,LNAME = ?,DOB=?, PHONENO = ?, EMAIL =?, SADDR1 = ?, SADDR2 = ?, CITY = ?, STATE = ?, ZCODE =?, WORKEXP= ? where PARTYID = ?");
			prepstatement.setString(1,partyType);
			prepstatement.setString(2, partyFname);
			prepstatement.setString(3,partyMname);
			prepstatement.setString(4, partyLname);
			prepstatement.setString(5, partyDOB);
			prepstatement.setString(6, partyMobile);
			prepstatement.setString(7, partyEmail);
			prepstatement.setString(8, partysaddr1);
			prepstatement.setString(9, partysaddr2);
			prepstatement.setString(10, partycity);
			prepstatement.setString(11, partystate);
			prepstatement.setString(12, partyzcode);
			prepstatement.setString(13, partyworkexp);
			
			prepstatement.setString(14, partyID);
			
			
			i = prepstatement.executeUpdate();
			//System.out.println("i val-"+i);
			// If all values gets insert into Dbase then forward user to (Login.jsp) else throw exception
			//to forward user from one page to another use RequestDispatcher/ sednRedirect
			if(i>0)
			{
				request.setAttribute("partyid", partyID);
				
				request.setAttribute("success_message", "Details Updated Successfully");
				RequestDispatcher dispatcher = request.getRequestDispatcher("Party_Details.jsp");
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

		doGet(request, response);
	}

}
