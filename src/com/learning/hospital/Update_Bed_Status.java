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

/**
 * Servlet implementation class Update_Bed_Status
 */
public class Update_Bed_Status extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Update_Bed_Status() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String orderId =  request.getParameter("orderid");
		System.out.println(orderId);
		String bedStatus = request.getParameter("bed_status");
		System.out.println("bed status -"+bedStatus);
		
		
		int i=0;
		//JDBC Connection 
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		//String Query = "insert into PARTY (Partytype,Fname,Mname,Lname,DOB,Gender,Phoneno,email,pswd,cpswd,addstrt1,addstrt2,city,state,zpcode) values ("+Partyname+","+Fnm+","+Mnm+","+Lnm+","+DOB+","+Gender+","+Phnm+","+eml+","+pswrd+","+cpswrd+","+sadd1+","+sad2+","+cty+","+state+","+zcode+")";
		
		try 
		{
			//System.out.println("in servlet");
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			PreparedStatement prepstatement = conn.prepareStatement("update ORDERDETAIL set BEDSTATUS = ? where ORDERID = ?");
			prepstatement.setString(1, bedStatus);
			prepstatement.setString(2, orderId);
			
			i = prepstatement.executeUpdate();
			System.out.println("i val-"+i);
			// If all values gets insert into Dbase then forward user to (Login.jsp) else throw exception
			//to forward user from one page to another use RequestDispatcher/ sednRedirect
			if(i>0)
			{
				RequestDispatcher dispatcher = request.getRequestDispatcher("Doctor_Order_Details.jsp");
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
