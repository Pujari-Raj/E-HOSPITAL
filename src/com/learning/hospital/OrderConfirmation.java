package com.learning.hospital;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.framework.entity.EntityQuery;
import com.paytm.pg.merchant.PaytmChecksum;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import org.json.*;
public class OrderConfirmation extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public OrderConfirmation() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//	response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		HttpSession session = request.getSession();	
		String getusereml = (String) session.getAttribute("customer");
		System.out.println("email-"+getusereml);
		
		Map<String, Object> getpartyidMap = EntityQuery.queryOne("PARTY", "EMAIL='"+getusereml+"'");
		String partyid = (String) getpartyidMap.get("PARTYID");
		
		System.out.println("partyid- "+getpartyidMap.get("PARTYID"));
		
		String sdate =  request.getParameter("SDate");
		String stime =  request.getParameter("STime"); // STime => Slotid 
		String partyaddrsid =  request.getParameter("partyaddrsid");
		System.out.println("addrs id-"+partyaddrsid);
		String productId =  request.getParameter("orderproductid");
		String payOption = request.getParameter("paymentOptn");
		System.out.println("pay-"+payOption);
		String productType = request.getParameter("productType");
		
		String bedId = request.getParameter("bedID");
		System.out.println("bed-Id in order_confirmation servlet- "+bedId+"\n");
		
		Map<String, Object> orderpricemap = EntityQuery.queryOne("PRODUCT","PID ='"+productId+"'");
		String orderprice = (String) orderpricemap.get("PRDTDSCTPRICE"); 
		
		Map<String, Object> timeMap = null; 
		
		Map<String, Object>  orderidMap  = EntityQuery.queryOne("ORDERDETAIL","ORDERPRODUCTID='"+productId+"'");
		//String orderid = (String) orderidMap.get("ORDERID");
		//System.out.println(orderid);
		
		request.setAttribute("SlotDate", sdate);
		
		if(productType.equals("services"))
		{	
			timeMap = EntityQuery.queryOne("TIMESLOTS", "SLOTID='"+stime+"'");
	
			request.setAttribute("SlotTime", stime);
		}
		
		if(productType.equals("Appointment"))
		{	
		 timeMap = EntityQuery.queryOne("TIMESLOTS", "SLOTID='"+stime+"'");
	
			request.setAttribute("SlotTime", stime);
		}
		
		if(productType.equals("bed"))			
		{
			request.setAttribute("SlotTime", stime);
		}
		
		request.setAttribute("partyAddrsid",partyaddrsid);
		request.setAttribute("orderproductid", productId);
		request.setAttribute("orderprice", orderprice);
		
		Map<String, Object> ordercnfrmap = new HashMap<String, Object>();
		//ordercnfrmap.put();
		
		//Database Details
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";

		
		if(payOption.equals("paymentAppt"))
		{	
		
			try
			{
				Class.forName("org.h2.Driver");
				Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd); 
				PreparedStatement preparedStat = conn.prepareStatement("Insert into ORDERDETAIL (ORDERPRODUCTID,ORDERFULLTDATE,ORDERFULLTIME,ORDERADDRSID,ORDERPRICE,ORDERSTATUS,PARTYID,BEDSTATUS,BEDID) values (?,?,?,?,?,?,?,?,?)");
				//preparedStat.setString("ORDERID", ");
				preparedStat.setString(1, productId);
				preparedStat.setDate(2,Date.valueOf(sdate));
				
				if(productType.equals("services"))
				{	
					preparedStat.setTime(3, Time.valueOf(timeMap.get("TIMETO").toString()));
				}
				if(productType.equals("Appointment"))
				{	
					preparedStat.setTime(3, Time.valueOf(timeMap.get("TIMETO").toString()));
				}
				if(productType.equals("bed"))			
				{
					preparedStat.setString(3, stime);
				}
				
				preparedStat.setString(4, partyaddrsid);
				preparedStat.setString(5, orderprice);
				preparedStat.setString(6, "pending");
				preparedStat.setString(7, partyid);
				preparedStat.setString(8, "No");
				
				if(productType.equals("services"))
				{	
					preparedStat.setString(9, null);
				}
				
				if(productType.equals("Appointment"))
				{	
					preparedStat.setString(9, null);
				}	
				if(productType.equals("bed"))			
				{
					preparedStat.setString(9, bedId);
					PreparedStatement preparedStatement2 = conn.prepareStatement("Update BEDRECORD set BEDSTATUS = ?  where Bedid = ?");
					preparedStatement2.setString(1, "Occupied");
					preparedStatement2.setString(2, bedId);
					preparedStatement2.executeUpdate();
					
				}
				
				//	String bedstatus = request.get
				//request.setAttribute("bedstatus", );
				
				/*After creation of order the payment info gets inserted for that order */
				int rows= preparedStat.executeUpdate();
				
				if(rows>0)
				{
				
					PreparedStatement preparedStatement1 = conn.prepareStatement("Insert into PAYMENTINFO (PAYMENTMODE,PAYMENTSTATUS,TRANSACTIONID,TRANSACTIONTOKEN,ORDERID,PARTYID) values(?,?,?,?,?,?)");
					preparedStatement1.setString(1, payOption);
					preparedStatement1.setString(2, "pending");
					preparedStatement1.setString(3, null);
					preparedStatement1.setString(4, null);
					preparedStatement1.setString(5,(String) orderidMap.get("ORDERID"));
					preparedStatement1.setString(6, partyid);
					
					preparedStatement1.executeUpdate();
					
					
					// Code to send mail to user after booking the prouduct
					 				
					RequestDispatcher dispatcher = request.getRequestDispatcher("Order_Confirm.jsp");
					dispatcher.forward(request, response);
				}	
				else 
				{
					System.out.println("Error in insertion");
				}
				
				/*Code to update the status of timeslot in database*/
				Map<String, Object> totalpatientMap = EntityQuery.queryOne("TIMESLOTS", "slotid= '"+stime+"'");
				String maxpatient =  (String)totalpatientMap.get("TOTALPATIENTS");
				//Integer patientval = (Integer) totalpatientMap.get("TOTALPATIENTS");
				System.out.println("\n Total Patient value- "+maxpatient);
				int updatepatientval = Integer.parseInt(maxpatient);
				int updateval = (updatepatientval)+1;
				
//				int patient_val = (int) totalpatient.get("TOTALPATIENTS");
//				int updateval = patient_val +1;
//				
				String patientcontextvalue = getServletContext().getInitParameter("max_no_patient");
				System.out.println(" patient context value-"+patientcontextvalue);
				
//				if(patientval==null)
//				{
//					PreparedStatement preparedStatement3 = conn.prepareStatement("update TIMESLOTS set TOTALPATIENTS=? where SLOTID = ?");
//					preparedStatement3.setInt(1, updateval);
//					preparedStatement3.setString(2, stime);
//					
//					int val =0; 
//					val = preparedStatement3.executeUpdate();
//					if(val>0)
//					{
//						System.out.println("total patients value updated-"+val);
//					}
//				}	
////				
//				else 
//				{
				if(maxpatient.equals(patientcontextvalue))
				{
					System.out.println("In slot blocking block");
					PreparedStatement preparedStatement2 = conn.prepareStatement("update TIMESLOTS set SLOTSTATUS=? where slotid=?");
					preparedStatement2.setString(1, "N");
					preparedStatement2.setString(2, stime);
					
					int rs =0; 
					rs = preparedStatement2.executeUpdate();
					if(rs>0)
					{
						System.out.println("Slot status updated-"+rs);
					}
				}
				
					
					PreparedStatement preparedStatement4 = conn.prepareStatement("update TIMESLOTS set TOTALPATIENTS=? where SLOTID = ?");
					preparedStatement4.setInt(1, updateval);
					preparedStatement4.setString(2, stime);
					
					int i =0; 
					i = preparedStatement4.executeUpdate();
					if(i>0)
					{
						System.out.println("total patients value updated-"+i);
					}
					
					
					
				//}
				
				
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
	
		if(payOption.equals("paymentppal"))
		{
			request.setAttribute("ProductId", productId);
			request.setAttribute("Producttype", productType);
			request.setAttribute("SlotDate", sdate);
			request.setAttribute("SlotTime", stime);
			request.setAttribute("partyAddrsid", partyaddrsid);
			request.setAttribute("orderPrice", orderprice);
			request.setAttribute("PartyId", partyid);
			request.setAttribute("paymentOption", payOption);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("payment_form.jsp");
			dispatcher.forward(request, response);
		}
	}		
		//doGet(request, response);
}
