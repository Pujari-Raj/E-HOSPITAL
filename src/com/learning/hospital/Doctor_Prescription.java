package com.learning.hospital;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.framework.entity.EntityQuery;

public class Doctor_Prescription extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Doctor_Prescription() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String orderID = request.getParameter("orderId");
		System.out.print("order id -"+orderID);
		
		String partyID = request.getParameter("partyId");
		System.out.print("partyid in patient detail page-"+partyID);
		
		String[] medId = request.getParameterValues("medid");
		
		String patcomplain = request.getParameter("patientcomplain");
		
		System.out.println("medicine Id in doctor prescription - "+medId[0]);
		//char[] medid = medId.toCharArray();
		//System.out.println("meicine id"+medid.length);		
		
		System.out.print("partyid in patient detail page-"+medId);
		
		
		for(int i=0;i<medId.length;i++)
		{
			boolean result = false;
			
			Map<String, Object> inserttMap = new HashMap<String, Object>();
			inserttMap.put("ORDERID",new String(orderID));
			inserttMap.put("PARTYID",new String(partyID));
			inserttMap.put("PRODUCTID",new String(medId[i]));	
			
			result = EntityQuery.insertData("PRESCRIPTION", inserttMap);
			
			boolean updatecomplain = false;
			
			Map<String, Object> cdtnMap = new HashMap<String, Object>();
			cdtnMap.put("ORDERID", new String(orderID));
			
			Map<String, Object> valueMap = new HashMap<String, Object>();
			valueMap.put("PATIENTCOMPLAINT", new String(patcomplain));
			
			updatecomplain = EntityQuery.updateData("ORDERDETAIL", valueMap, cdtnMap);
 		}
		
	
		request.setAttribute("orderId", orderID);// passing orderid to re-fetch details in beolow forwarded jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("Doctor_Patient_Details.jsp");
		dispatcher.include(request, response);

	}	

}


