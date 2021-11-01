package com.learning.hospital;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Book_Bed extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Book_Bed() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String bed_number = request.getParameter("bed_number");// Getting the bed value from input field 
		System.out.println("bed num-"+bed_number);
		
		String[] bed_array = bed_number.split(",");// spliting the value of(bed_number) to get into matrix and storing into string array
		//System.out.println(bed_array.toString());
		
		int bed_row = Integer.parseInt(bed_array[0]);// storing string array value into int to get row value
		int bed_col = Integer.parseInt(bed_array[1]);// storing string array value into int to get column value
		System.out.println("bed -row- "+bed_row+"bed-col-"+bed_col);
			
		String productid = "21";
		System.out.println("product id-"+productid);
		request.setAttribute("selectedPid", productid);
		
		String dateFormat = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		System.out.println("Date-"+dateFormat);
		request.setAttribute("slotDate", dateFormat);
		
		String bookingtime = new SimpleDateFormat("HH:mm:ss").format(new Date());
		request.setAttribute("slotTime", bookingtime);
		
		String producttype = "bed";
		request.setAttribute("productType", producttype);
	
		String bedid = "";
		
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
			PreparedStatement prepstatement = conn.prepareStatement("select * from BEDRECORD where BEDROW=? and BEDCOLUMN  = ?");
			prepstatement.setInt(1, bed_row);
			prepstatement.setInt(2, bed_col);
			
			ResultSet rs = prepstatement.executeQuery();
		//	System.out.println("i val-"+rs);
			// If all values gets insert into Dbase then forward user to (Login.jsp) else throw exception
			//to forward user from one page to another use RequestDispatcher/ sednRedirect
			if(rs.next())
			{
				bedid = rs.getString("BEDID");
				request.setAttribute("bedId", bedid);
				//System.out.println(bedid);
				RequestDispatcher dispatcher = request.getRequestDispatcher("Bookservices.jsp");
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
