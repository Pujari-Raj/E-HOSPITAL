package com.learning.hospital;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.UploadContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;


@MultipartConfig()
public class Admin_Add_Product extends HttpServlet 
{		public Admin_Add_Product() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.getWriter().append("Served at add product servlet: ").append(request.getContextPath());
	}

	private String filePath = "D:\\\\Backup\\\\eclipse-workspace\\\\CollegeProject\\\\E-Hospital\\\\WebContent\\\\productcontent\\\\";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productDscrptn = "";
		String productName = "";
		String productMrpPrice = "";
		String productDiscountPrice = "";
		String productCategoryId = "";
		String productType = "";
		//String productPartyId = "";
		String productImage = "";
		
		String Imageurl ="";
		//Make Directory Code
			
		File file = new File(filePath);
		if(file.exists()) {
			System.out.println("folder already exist");
		}
		else {
			boolean makeDir = file.mkdirs();
			if(makeDir){
		         System.out.println("Directory created successfully");
		      }else{
		         System.out.println("Sorry couldnt create specified directory");
		    }
		}

		
		//Check that we have a file upload request
		boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
		if(isMultiPart) {
			System.out.println("is Multipart");
		}
		
		response.setContentType("text/html");
	    java.io.PrintWriter out = response.getWriter( );
	    
	    DiskFileItemFactory factory = new DiskFileItemFactory();

	    // Create a new file upload handler
	     ServletFileUpload upload = new ServletFileUpload(factory);
	     
	     try 
	     { 
	          // Parse the request to get file items.
	          List<?> fileItems = upload.parseRequest(request);
	 	
	          // Process the uploaded file items
	          Iterator<?> i = fileItems.iterator();

	          int j = 1;
	          while ( i.hasNext () ) 
	          {
	             FileItem fi = (FileItem)i.next();
	             
	             if ( !fi.isFormField () ) 
	             {
	                // Get the uploaded file parameters
//			                String fieldName = fi.getFieldName();
	                String fileName = fi.getName();
//			                String contentType = fi.getContentType();
//			                boolean isInMemory = fi.isInMemory();
//			                long sizeInBytes = fi.getSize();
	             
	                // Write the file
	      
	                if( fileName.lastIndexOf("\\") >= 0 ) 
	                {
	                   file = new File( filePath + fileName.substring( fileName.lastIndexOf("\\"))) ;
	                } else {
	                   file = new File( filePath + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
	                }
	                fi.write( file ) ;
	                String uploadedFileName[] = fileName.split("\\\\");
	                productImage = filePath+uploadedFileName[uploadedFileName.length-1].toString();
	                //out.println("Stored In Directory: " + filePath+uploadedFileName[uploadedFileName.length-1]);
	             }
	             
	             if(fi.isFormField()) 
	             {
//			            	  String fieldName = fi.getFieldName();
//			            	  String value = fi.getString();
	            	 
		            if(j==1) 
		            {
		            	productDscrptn = fi.getString();
		            }
		            else if(j==2)
		            {
		            	productName = fi.getString();
		            }
		            else if(j==3)
		            {
		            	productMrpPrice = fi.getString();
		            }
		            else if(j==4)
		            {
		            	productDiscountPrice = fi.getString();
		            }
		            else if(j==5)
		            {
		            	productCategoryId = fi.getString();
		            }
		            else if(j==6)
		            {
		            	productType = fi.getString();
		            }
		         }
	             j++;
	          }
	          
	          Imageurl = productImage;
	          System.out.println("Product Image Url-"+productImage);
	          System.out.println("Image URl in Admin_Add-Product-"+Imageurl);
	              
	        int rs=0;
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
	  			PreparedStatement prepstatement = conn.prepareStatement("insert into product (PRDTDSCRPTN,PRDTNAME,PRDTMRPPRICE,PRDTDSCTPRICE,PIMAGEURL,CATERGORYID,PRODUCTTYPE)  values(?,?,?,?,?,?,?)");
	   			
	  			prepstatement.setString(1, productDscrptn);
	  			prepstatement.setString(2, productName);
	  			prepstatement.setString(3, productMrpPrice);
	  			prepstatement.setString(4, productDiscountPrice);
	  			prepstatement.setString(5, Imageurl);
	  			prepstatement.setString(6, productCategoryId);
	  			prepstatement.setString(7, productType);
	  			//prepstatement.setString(8, productPartyId);
	  			
	  			
	  			rs = prepstatement.executeUpdate();
	  			
	  			// If all values gets insert into Dbase then forward user to (Login.jsp) else throw exception
	  			//to forward user from one page to another use RequestDispatcher/ sednRedirect
	  			if(rs>0)
	  			{
	  				RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
	  				dispatcher.include(request, response);;
	  			}
	  		} 
	  		catch (ClassNotFoundException e) 
	  		{
	  			System.out.println("Clas Not FOund Exception in Admin_Add_Product servlet"+e.getMessage());
	  		} 
	  		catch (SQLException e) 
	  		{
	  			System.out.println("SQL Exception  in Admin_Add_Product servlet"+e.getMessage());
	  		}

	          
	     } 
	     catch(Exception ex) 
	     {
	             System.out.println(ex);
	     }
			     		    
	}
}