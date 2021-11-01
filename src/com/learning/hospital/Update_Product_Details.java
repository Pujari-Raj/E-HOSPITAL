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

public class Update_Product_Details extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Update_Product_Details() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String productId = request.getParameter("productId");
		System.out.println(productId);
		
		String productdscprtn = request.getParameter("product_dscrptn");
		System.out.println(productdscprtn);
		
		String productdname = request.getParameter("product_Name");
		System.out.println(productdname);
		
		String productdMRP = request.getParameter("product_MRP");
		System.out.println(productdMRP);
		
		String productDSCT = request.getParameter("product_DSCT");
		System.out.println(productDSCT);
		
		String productImageUrl = request.getParameter("product_Imageurl");
		System.out.println(productImageUrl);
		
		String productCateogry = request.getParameter("product_Cateogry");
		System.out.println(productCateogry);
		
		String productType = request.getParameter("product_Type");
		System.out.println(productType);
		
		//String productPartyId = request.getParameter("product_partyId");
		//System.out.println(productPartyId);
		
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
			PreparedStatement prepstatement = conn.prepareStatement("update product set PRDTDSCRPTN = ?, PRDTNAME = ?, PRDTMRPPRICE = ?, PRDTDSCTPRICE = ?, PIMAGEURL  = ?, CATERGORYID = ?, PRODUCTTYPE = ? where PID =?");
			
			System.out.println(prepstatement);
			prepstatement.setString(1, productdscprtn);
			prepstatement.setString(2, productdname);
			prepstatement.setString(3, productdMRP);
			prepstatement.setString(4, productDSCT);
			prepstatement.setString(5, productImageUrl);
			prepstatement.setString(6, productCateogry);
			prepstatement.setString(7, productType);
			
			prepstatement.setString(8, productId);
			
			
			
			i = prepstatement.executeUpdate();
			System.out.println("i val-"+i);
			// If all values gets insert into Dbase then forward user to (Login.jsp) else throw exception
			//to forward user from one page to another use RequestDispatcher/ sednRedirect
			if(i>0)
			{
				request.setAttribute("productID", productId);
				
				request.setAttribute("success_message", "Product Updated Successfully");
				RequestDispatcher dispatcher = request.getRequestDispatcher("Product_Details.jsp");
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
