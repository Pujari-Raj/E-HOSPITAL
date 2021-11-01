package com.learning.hospital;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.framework.entity.EntityQuery;

public class Update_Party_Address extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Update_Party_Address() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		String partyAddrsId = request.getParameter("partyaddrsid");
		System.out.println("Party Address Id: "+partyAddrsId);

		boolean delData = EntityQuery.deleteData("PARTYADDRESS","PARTYADDRSID="+partyAddrsId);
		
		if(delData==true)
		{
			request.setAttribute("success_message", "Address Deleted Successfully");
			request.getRequestDispatcher("Your_Address.jsp").forward(request, response);;
		}	
	}
}