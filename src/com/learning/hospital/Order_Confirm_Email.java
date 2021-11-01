package com.learning.hospital;

import java.io.IOException;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.framework.entity.EntityQuery;

public class Order_Confirm_Email extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Order_Confirm_Email() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		
		String getusereml = (String) session.getAttribute("customer");
		
		Map<String, Object> getpartyidMap = EntityQuery.queryOne("PARTY", "EMAIL='"+getusereml+"'");
		String partyemail = (String) getpartyidMap.get("EMAIL");
		
		
		String orderID = request.getParameter("orderID");
		
		String to = partyemail;
		  
	      // Sender's email ID needs to be mentioned
	      String from = "basvarajpujari607@gmail.com";

	      String password = "p*b@1437";
	      // Assuming you are sending email from localhost
	     // String host = "localhost";

	      // Get system properties
	      Properties properties = System.getProperties();

	      // Setup mail server
	      properties.setProperty("mail.smtp.auth", "true");
	      properties.setProperty("mail.smtp.starttls.enable", "true");
	      properties.setProperty("mail.smtp.host", "smtp.gmail.com");
	      properties.setProperty("mail.smtp.port", "587");

	      // Get the default Session object.
	     // Session session1 = Session.getDefaultInstance(properties);
	      Session session1 = Session.getInstance(properties,
	    	      new javax.mail.Authenticator() {
	    	         protected PasswordAuthentication getPasswordAuthentication() {
	    	            return new PasswordAuthentication(from, password);
	    	         }
	    	      });
	      
	      try {
	         // Create a default MimeMessage object.
	         MimeMessage message = new MimeMessage(session1);

	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress(from));

	         // Set To: header field of the header.
	         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

	         // Set Subject: header field
	         message.setSubject("THANK YOU FOR PLACING YOUR ORDER WITH US.");

	         // Now set the actual message
	         message.setText("Your Order has been placed\n Your order Id is-"+orderID);

	         // Send message
	         Transport.send(message);
	         System.out.println("Sent message successfully....");
	      } 
	      catch (MessagingException mex)
	      {
	         mex.printStackTrace();
	      }

	     request.setAttribute("orderId", orderID); 
	  	RequestDispatcher dispatcher = request.getRequestDispatcher("Order_Confrim_Email.jsp");
		dispatcher.forward(request, response);
	
	      
		doGet(request, response);
	}

}
