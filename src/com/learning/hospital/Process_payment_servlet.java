package com.learning.hospital;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.framework.entity.EntityQuery;

public class Process_payment_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Process_payment_servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Getting the Slot date& time of Booking Service
		//Getting payment mode&partyaddrsid from Bookservices
		String slotdate =  request.getParameter("SDate");
		String slottime =  request.getParameter("STime");	
		String paymentType = request.getParameter("paymentOptn");
		System.out.println("Ptype->"+paymentType);
		
		String partyaddrsid = request.getParameter("partyaddrsid");
		
		//Getting the selected product's ID from (Bookservices.jsp)
		String productID = request.getParameter("orderproductid");
		
		String producttype = request.getParameter("producttype");
		System.out.println("product type-"+producttype);
		
		String bedId = request.getParameter("bedID");
		System.out.println("bed id in servlet -"+bedId);
		
		//setting value of sdate&time so we can use it in next page
		
		//Map to add address details of user
		Map<String, Object> orderDetailMap = new HashMap<String, Object>();
		orderDetailMap.put("productid", productID);
		orderDetailMap.put("ptype",paymentType);
		orderDetailMap.put("slotDate", slotdate);
		orderDetailMap.put("slotTime", slottime);
		orderDetailMap.put("paymentoptn", paymentType);
		orderDetailMap.put("productType", producttype);
		orderDetailMap.put("bedId", bedId);
		
		//Getting session value of user
		HttpSession session = request.getSession();
		//Getting the PARTYID using session value by getting session value from (login_validate) and storing it in string to get the value to value from table  
		
		String emlID = (String)session.getAttribute("customer");
		
		//Code for Use Address if user want to use previous entered address   
		//if partyaddrsid is !null then fetch the previous address
		if(partyaddrsid!=null)
		{	
			System.out.println("\n In fif block "+partyaddrsid);
			orderDetailMap.put("partyaddrsid",partyaddrsid);
		}
		
		
		//If user want to insert new adddress & send to product_review page
		else
		{
		
			System.out.println("\n In else block");
		//Calling the EntityQuery Class to get the value of the (PARTYID) from predefined method
		Map<String, Object> partyRecord = EntityQuery.queryOne("PARTY", "EMAIL='"+emlID+"'");
		
		//insertion code
		String PID = (String) partyRecord.get("PARTYID");
		String partyfname = request.getParameter("pfname");
		String Baddrs1 = request.getParameter("baddrs1");
		String Baddrs2 = request.getParameter("baddrs2");
		String Bstate = request.getParameter("bstate");
		String Bzcode = request.getParameter("bzcode");
		
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		
		
		try {
			
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			
			PreparedStatement preparedStatement= conn.prepareStatement("Insert into  PARTYADDRESS (PARTYID,PFNAME,PADDRS1,PADDRS2,PSTATE,PZCODE) values(?,?,?,?,?,?)");
			preparedStatement.setString(1, PID);
			preparedStatement.setString(2, partyfname);
			preparedStatement.setString(3, Baddrs1);
			preparedStatement.setString(4, Baddrs2);
			preparedStatement.setString(5, Bstate);
			preparedStatement.setString(6, Bzcode);
			
			//String postalID = request.getParameter("PARTYADDRSID");
			//session.setAttribute("POSTALID", postalID);
			
			//int i=0;
			//i = preparedStatement.executeUpdate();
			 
			//preparedStatement.addBatch();
			
			//inserting new address  
			preparedStatement.executeUpdate();
			
			//ResultSet resultSet = preparedStatement.getGeneratedKeys();				
			//System.out.println("rs value-"+resultSet.next());		
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println("Clas Not FOund Exception in Process_Payment_servlet "+e.getMessage());
		} 
		catch (SQLException e) 
		{
			System.out.println("SQL Exception  in Process_Payment_servlet -"+e.getMessage());
		}
	}	
		//sending address details of user
		request.setAttribute("OrderDetailMap", orderDetailMap);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("Product_Review_Page.jsp");
		dispatcher.include(request, response);

		//doGet(request, response);
	}	
}