package com.hospital.productServices;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductServices {
	
	//Defining the method for retrieving the products data from the database
	//Below function retrives value from Dbase according to specified to categoryId
	public static List<Map<String, Object>> getProductList(String cateogryId)
	{
		//Creating the List to store products attributes
		List<Map<String, Object>> productlist = new ArrayList<Map<String,Object>>();
		
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		String query = "SELECT * FROM PRODUCT";
		
		//If categoryId is not null then generate the below query
		if(cateogryId!=null)
		{
			query="SELECT * FROM PRODUCT where catergoryid=?";
		}
		//System.out.println("hello"+query);
		
		try {
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			//Statement stat = conn.createStatement();
			PreparedStatement preparedStat = conn.prepareStatement(query);
			
			//Setting the categoryId got from Services.jsp
			if(cateogryId!=null)
			{
				preparedStat.setString(1, cateogryId);
			}	
			ResultSet rs = preparedStat.executeQuery();
			
			while(rs.next())
			{
				//Creating the Map to store the product data
				//Mapping the products attributes into map's object and retrieving using the resultset 
				Map<String, Object> productMap = new HashMap<String, Object>(); 	
				
				//using getString method of resultset retriving the values from PRODUCT TABLE
				String productid = rs.getString("pid");
				String prouctdscrptn = rs.getString("PRDTDSCRPTN");
				String productname = rs.getString("PRDTNAME");
				String productmprice = rs.getString("PRDTMRPPRICE");
				String productdprice = rs.getString("PRDTDSCTPRICE");
				String productimageurl = rs.getString("PIMAGEURL");
				
				//System.out.println("product id-"+productid);
				
				//Adding the Map in (key, value) pair manner so that we can pass it list
				productMap.put("pid", productid);
				productMap.put("PRDTDSCRPTN", prouctdscrptn);
				productMap.put("PRDTNAME", productname);
				productMap.put("PRDTMRPPRICE", productmprice);
				productMap.put("PRDTDSCTPRICE", productdprice);
				productMap.put("PIMAGEURL", productimageurl);
				
				//Adding the Map value in List
				productlist.add(productMap);
				//System.out.println(productMap);
				//productMap.clear();
			}
			conn.close();
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println(" Class Not found Exception in Login_DAO class "+e.getMessage());
		}
		catch (SQLException e) {
			System.out.println("SQLException in Productservice class  "+e.getMessage());
		}	
		//System.out.println(productlist);
		return productlist;
	}
	
	//Defining the method for retrieving the products data from the database
	//Below function retrives value from Dbase according to specified to ProductId
		
	public static Map<String, Object> getProductById(String Productid)
	{
		Map<String, Object> productdetails = new HashMap<String, Object>();
		
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		String query = "SELECT * FROM PRODUCT where PID="+Productid;
		
		try {
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			//Statement stat = conn.createStatement();
			PreparedStatement preparedStat = conn.prepareStatement(query);
			ResultSet rs = preparedStat.executeQuery();
			//System.out.println("size"+rs.getFetchSize());
			
			while(rs.next())
			{
				//Mapping the products attributes into map's object and retrieving using the resultset 
				
				String productid = rs.getString("pid");
				String prouctdscrptn = rs.getString("PRDTDSCRPTN");
				String productname = rs.getString("PRDTNAME");
				String productmprice = rs.getString("PRDTMRPPRICE");
				String productdprice = rs.getString("PRDTDSCTPRICE");
				String productimageurl = rs.getString("PIMAGEURL");
				
				//System.out.println("product id-"+productid);
				
				productdetails.put("pid", productid);
				productdetails.put("PRDTDSCRPTN", prouctdscrptn);
				productdetails.put("PRDTNAME", productname);
				productdetails.put("PRDTMRPPRICE", productmprice);
				productdetails.put("PRDTDSCTPRICE", productdprice);
				productdetails.put("PIMAGEURL", productimageurl);
				
				//productlist.add(productMap);
				//System.out.println(productMap);
				//productMap.clear();
			}
			conn.close();
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println(" Class Not found Exception in Login_DAO class "+e.getMessage());
		}
		catch (SQLException e) {
			System.out.println("SQLException in Login_DAO class  "+e.getMessage());
		}	
		return productdetails;
	}
}