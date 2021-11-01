package com.learning.hospital;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.framework.entity.EntityQuery;

public class Product_Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Product_Delete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String productid = request.getParameter("productid");
		System.out.println("Party Address Id: "+productid);

		boolean delData = EntityQuery.deleteData("PRODUCT","PID="+productid);
		
		if(delData==true)
		{
			request.getRequestDispatcher("Update_Delete_Product.jsp").forward(request, response);;
		}	

		
		doGet(request, response);
	}

}
