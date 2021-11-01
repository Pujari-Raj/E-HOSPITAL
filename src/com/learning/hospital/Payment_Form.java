package com.learning.hospital;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.framework.entity.EntityQuery;

public class Payment_Form extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Payment_Form() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		
		String cardholdername = request.getParameter("card-holder-name");
		String cardnumber = request.getParameter("card-number");
		String cardexpirymonth = request.getParameter("expiry-month");
		String cardexpiryyear = request.getParameter("expiry-year");
		String cardcvv = request.getParameter("cvv");
		
		
		String productId = request.getParameter("productId");
		String productType = request.getParameter("productType");
		String slotDate = request.getParameter("slotdate");
		String slotTime = request.getParameter("slotTime");
		String partyAddrsId = request.getParameter("partyaddrsId");
		String orderprice = request.getParameter("orderPrice");
		String partyId = request.getParameter("partyId");
		String payOptn = request.getParameter("PaymentOption");
		
		System.out.println("\n cardno-"+cardnumber+ "card mont"+cardexpirymonth+"card year"+cardexpiryyear+"cvv-"+cardcvv);
		
		Map<String, Object> cardDetails = EntityQuery.queryOne("CARDS","CARDNUMBER='"+cardnumber+"'");
	
		if(cardnumber.equals(cardDetails.get("CARDNUMBER")) && cardexpirymonth.equals(cardDetails.get("EXPMONTH")) && cardexpiryyear.equals(cardDetails.get("EXPYEAR")) && cardcvv.equals(cardDetails.get("CARDCVV")))
		{
			//System.out.println("\n card Authenticated");
			
			Map<String, Object> timeMap = null; 
			
			Map<String, Object>  orderidMap  = EntityQuery.queryOne("ORDERDETAIL","ORDERPRODUCTID='"+productId+"'");
			//String orderid = (String) orderidMap.get("ORDERID");
			//System.out.println(orderid);
			
			if(productType.equals("services"))
			{	
				timeMap = EntityQuery.queryOne("TIMESLOTS", "SLOTID='"+slotTime+"'");
		
				request.setAttribute("SlotTime", slotTime);
			}
			
			if(productType.equals("Appointment"))
			{	
			 timeMap = EntityQuery.queryOne("TIMESLOTS", "SLOTID='"+slotTime+"'");
		
				request.setAttribute("SlotTime", slotTime);
			}
			
			//Database Details
			String dburl ="jdbc:h2:tcp://localhost/~/test";
			String dbusrnm = "sa";
			String dbpwd = "sasa";

			
			try
			{
				Class.forName("org.h2.Driver");
				Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd); 
				PreparedStatement preparedStat = conn.prepareStatement("Insert into ORDERDETAIL (ORDERPRODUCTID,ORDERFULLTDATE,ORDERFULLTIME,ORDERADDRSID,ORDERPRICE,ORDERSTATUS,PARTYID) values (?,?,?,?,?,?,?)");
				//preparedStat.setString("ORDERID", ");
				preparedStat.setString(1, productId);
				preparedStat.setDate(2,Date.valueOf(slotDate));
				
				if(productType.equals("services"))
				{	
					preparedStat.setTime(3, Time.valueOf(timeMap.get("TIMETO").toString()));
				}
				if(productType.equals("Appointment"))
				{	
					preparedStat.setTime(3, Time.valueOf(timeMap.get("TIMETO").toString()));
				}
				
				
				preparedStat.setString(4, partyAddrsId);
				preparedStat.setString(5, orderprice);
				preparedStat.setString(6, "pending");
				preparedStat.setString(7, partyId);
				
				
			//	String bedstatus = request.get
				//request.setAttribute("bedstatus", );
				int rows= preparedStat.executeUpdate();
				
				if(rows>0)
				{
				
					PreparedStatement preparedStatement1 = conn.prepareStatement("Insert into PAYMENTINFO (PAYMENTMODE,PAYMENTSTATUS,TRANSACTIONID,TRANSACTIONTOKEN,ORDERID,PARTYID) values(?,?,?,?,?,?)");
					preparedStatement1.setString(1, payOptn);
					preparedStatement1.setString(2, "successfull");
					//preparedStatement1.setString(3, Utility.randomAlphaNumeric(10));
					preparedStatement1.setString(3, null);
					
					preparedStatement1.setString(4, null);
					preparedStatement1.setString(5,(String) orderidMap.get("ORDERID"));
					preparedStatement1.setString(6, partyId);
					
					preparedStatement1.executeUpdate();
					
					
					// Code to send mail to user after booking the prouduct
					 		
					request.setAttribute("partyAddrsid", partyAddrsId);
					RequestDispatcher dispatcher = request.getRequestDispatcher("Order_Confirm.jsp");
					dispatcher.forward(request, response);
				}	
				else 
				{
					System.out.println("Error in insertion");
				}
				
			} 
				
			catch (ClassNotFoundException e) 
			{
				System.out.println("Class not found Exception in Order_cnfrm servlet"+e);
			} 
			catch (SQLException e) 
			{
				System.out.println("SQL Exception in Order_cnfrm servlet"+e);
			}
			
		}	

		else
		{
			RequestDispatcher dispatcher = request.getRequestDispatcher("payment_error.jsp");
			dispatcher.forward(request, response);
		
		}
	}

}
