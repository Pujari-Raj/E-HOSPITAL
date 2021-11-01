package com.learning.hospital;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Register_User extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public Register_User() {
		super();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Taking values from the User 
		//In request.getParameter we take the value specified from name attribute of input field 
		String Partyname = request.getParameter("Partytype");
		String Fnm = request.getParameter("firstname");
		String Mnm = request.getParameter("middlename");
		String Lnm = request.getParameter("lastname");
		String date = request.getParameter("date");
		String Gender = request.getParameter("gender");
		String Phnm = request.getParameter("phone");
		String eml = request.getParameter("email");
		String pswrd = request.getParameter("pswd");
		String cpswrd = request.getParameter("cnfrmpswd");
		String sadd1 = request.getParameter("saddrs1");
		String sad2 = request.getParameter("saddrs2");
		String cty = request.getParameter("city");
		String state = request.getParameter("state");
		String zcode = request.getParameter("zcode");
		
		
		Date date2 = Date.valueOf(date);
		
		int i=0;
		//JDBC Connection 
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		//String Query = "insert into PARTY (Partytype,Fname,Mname,Lname,DOB,Gender,Phoneno,email,pswd,cpswd,addstrt1,addstrt2,city,state,zpcode) values ("+Partyname+","+Fnm+","+Mnm+","+Lnm+","+DOB+","+Gender+","+Phnm+","+eml+","+pswrd+","+cpswrd+","+sadd1+","+sad2+","+cty+","+state+","+zcode+")";
		
		try {
			//System.out.println("in servlet");
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			PreparedStatement prepstatement = conn.prepareStatement("insert into party (partytype,fname,mname,lname,dob,gender,phoneno,email,pswd,cpswd,saddr1,saddr2,city,state,zcode)  values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
 			prepstatement.setString(1, Partyname);
			prepstatement.setString(2, Fnm);
			prepstatement.setString(3, Mnm);
			prepstatement.setString(4, Lnm);
			prepstatement.setDate(5, date2);
 			prepstatement.setString(6, Gender);
			prepstatement.setString(7, Phnm);
			prepstatement.setString(8, eml);
			prepstatement.setString(9, pswrd);
			prepstatement.setString(10, cpswrd);
			prepstatement.setString(11, sadd1);
 			prepstatement.setString(12, sad2);
			prepstatement.setString(13, cty);
			prepstatement.setString(14, state);
			prepstatement.setString(15, zcode);
			i = prepstatement.executeUpdate();
			
			// If all values gets insert into Dbase then forward user to (Login.jsp) else throw exception
			//to forward user from one page to another use RequestDispatcher/ sednRedirect
			if(i>0)
			{
				request.setAttribute("success_message", "User Registered Successfully");
				RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
				dispatcher.include(request, response);;
			}
		} 
		catch (ClassNotFoundException e) {
			System.out.println("Clas Not FOund Exception in Register_patient "+e.getMessage());
		} 
		catch (SQLException e) {
			System.out.println("SQL Exception  in Register_patient -"+e.getMessage());
		}
		
		//doGet(request, response);
	}

}
