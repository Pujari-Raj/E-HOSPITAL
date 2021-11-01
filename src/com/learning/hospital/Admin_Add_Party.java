package com.learning.hospital;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Admin_Add_Party extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Admin_Add_Party() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.getWriter().append("Served at Admin_addparty: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Taking values from the User 
		//In request.getParameter we take the value specified from name attribute of input field 
		
		String partyId = request.getParameter("party_id");
		String partyName = request.getParameter("party_type");
		String fName = request.getParameter("firstname");
		String mName = request.getParameter("middlename");
		String lName = request.getParameter("lastname");
		String date = request.getParameter("date");
		String gender = request.getParameter("gender");	
		String phnm = request.getParameter("phone");
		String eml = request.getParameter("email");
		String pswrd = request.getParameter("pswd");
		String cpswrd = request.getParameter("cnfrmpswd");
		String sAdd1 = request.getParameter("saddrs1");
		String sAdd2 = request.getParameter("saddrs2");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zCode = request.getParameter("zcode");

		Date date2 = Date.valueOf(date);
		
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
			PreparedStatement prepstatement = conn.prepareStatement("insert into party (partyid,partytype,fname,mname,lname,dob,gender,phoneno,email,pswd,cpswd,saddr1,saddr2,city,state,zcode)  values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
 			
			prepstatement.setString(1, partyId);
			prepstatement.setString(2, partyName);
			prepstatement.setString(3, fName);
			prepstatement.setString(4, mName);
			prepstatement.setString(5, lName);
 			prepstatement.setDate(6, date2);
			prepstatement.setString(7, gender);
			prepstatement.setString(8, phnm);
			prepstatement.setString(9, eml);
			prepstatement.setString(10, pswrd);
			prepstatement.setString(11, cpswrd);
 			prepstatement.setString(12, sAdd1);
			prepstatement.setString(13, sAdd2);
			prepstatement.setString(14, city);
			prepstatement.setString(15, state);
			prepstatement.setString(16, zCode);
			
			i = prepstatement.executeUpdate();
			
			// If all values gets insert into Dbase then forward user to (Login.jsp) else throw exception
			//to forward user from one page to another use RequestDispatcher/ sednRedirect
			if(i>0)
			{
				RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
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
		
		//doGet(request, response);
	}

}