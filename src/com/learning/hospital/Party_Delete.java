package com.learning.hospital;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.framework.entity.EntityQuery;

public class Party_Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Party_Delete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String partyId = request.getParameter("partyid");
		System.out.println("Party Address Id: "+partyId);

		boolean delData = EntityQuery.deleteData("PARTY","PARTYID="+partyId);
		
		if(delData==true)
		{
			request.getRequestDispatcher("Update_Delete_Party.jsp").forward(request, response);;
		}	

		doGet(request, response);
	}

}
