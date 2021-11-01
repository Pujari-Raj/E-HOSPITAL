package com.learning.hospital;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.framework.entity.EntityQuery;

public class Bed_Check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Bed_Check() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//	response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		//Getting session value of user to get user details and fecth orders related to user
		String getusereml = (String) session.getAttribute("customer");
		//System.out.println("Getting Customer Email- "+getusereml);
		
		//Getting orderId from user
		String 	orderId = request.getParameter("order_Id");	
		//System.out.println("Getting Customer Email- "+orderId);
		
		Map<String, Object> partydetailMap = EntityQuery.queryOne("PARTY", "EMAIL='"+getusereml+"'");	
				
		List<Map<String, Object>> orderdetailMap = EntityQuery.queryList("ORDERDETAIL", "PARTYID='"+partydetailMap.get("PARTYID")+"'");
		
		Map<String, Object> orderMap = EntityQuery.queryOne("ORDERDETAIL","ORDERID='"+orderId+"'");
		String bedstatus = (String) orderMap.get("BEDSTATUS");
		System.out.println("bed status value in bed_check- "+bedstatus);
		
		Map<String, Object> partyproductMap = EntityQuery.queryOne("ORDERDETAIL", "PARTYID='"+partydetailMap.get("PARTYID")+"', ORDERID='"+orderId+"'");	
		
		//List<Map<String, Object>> orderMap = EntityQuery.queryList("ORDERDETAIL","ORDERID='"+orderId+"'");
		
		boolean verifyOrder = false;
		
		if(Utility.user_login_Validate(request)==true)//checking whether user is logged-in
		{
			System.out.println("user logged in");
			
					if(orderId.equals(partyproductMap.get("ORDERID")))// checking whether entered orderid is for party(user) whose logged-in as in dbase  
					{
						System.out.println("entered orderId is same for party whoes logged in");
						//verifyOrder = true;
						if(bedstatus.equals("Yes"))
						{		
							request.getRequestDispatcher("BookAppointment.jsp").forward(request, response);
						}
						else if(bedstatus.equals("No"))
						{
							request.setAttribute("bed_check_msg", true);
							request.getRequestDispatcher("Bed_check.jsp").forward(request, response);
						}
					}
					else if (orderId!=(partyproductMap.get("ORDERID"))) 
					{
						System.out.println("entered orderId is not same for party whoes logged in");
						//verifyOrder = true;
						request.setAttribute("OrderId_err_Msg", true);
						request.getRequestDispatcher("Bed_check.jsp").forward(request, response);
					}
			if(verifyOrder)
			{
				System.out.println("Order Verified");
			}
		
		}
		else if(Utility.user_login_Validate(request)==false)//checking whether user is logged-in if not then redirecting to login page 
		{
			System.out.println("checking whether user is logged-in if not then redirecting to login page");
			request.setAttribute("OrderId_err_Msg", true);
			RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
			dispatcher.forward(request, response);		
		}
	
		//doGet(request, response);
	}
}