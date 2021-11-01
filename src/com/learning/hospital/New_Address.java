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

public class New_Address extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public New_Address() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String Partyid = request.getParameter("partyid");
		String Pfname = request.getParameter("pfname");
		String Addrs1 = request.getParameter("baddrs1");
		String Addrs2 = request.getParameter("baddrs2");
		String Pstate = request.getParameter("bstate");
		String Pzcode = request.getParameter("bzcode");
		
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		
		
		try {
			
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			
			PreparedStatement preparedStatement= conn.prepareStatement("Insert into  PARTYADDRESS (PARTYID,PFNAME,PADDRS1,PADDRS2,PSTATE,PZCODE) values(?,?,?,?,?,?)");
			preparedStatement.setString(1, Partyid);
			preparedStatement.setString(2, Pfname);
			preparedStatement.setString(3, Addrs1);
			preparedStatement.setString(4, Addrs2);
			preparedStatement.setString(5, Pstate);
			preparedStatement.setString(6, Pzcode);
			
			int i=0;
			i = preparedStatement.executeUpdate();		
			
			if(i>0)
			{
				request.setAttribute("success_message", "Address Added Successfully");
				RequestDispatcher dispatcher = request.getRequestDispatcher("Your_Address.jsp");
				dispatcher.include(request, response);;
			}
		}
		
		catch (ClassNotFoundException e) 
		{
			System.out.println("Clas Not FOund Exception in  New Address  "+e.getMessage());
		} 
		catch (SQLException e) 
		{
			System.out.println("SQL Exception  in New Address -"+e.getMessage());
		}
	}

}
