package com.learning.hospital;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.framework.entity.EntityQuery;

public class Sendemail extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	public Sendemail() 
{
        super();
        // TODO Auto-generated constructor stub
}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String resetEmail = request.getParameter("resetemail");
		System.out.println("reset email-"+resetEmail);
		
		Map<String, Object> partyMap = EntityQuery.queryOne("PARTY", "EMAIL='"+resetEmail+"'");
		String partyid = (String) partyMap.get("PARTYID");
		String partymail = (String) partyMap.get("EMAIL");
		String partyFname = (String) partyMap.get("FNAME");
		String partyMname = (String) partyMap.get("MNAME");
		
		
		System.out.println(partyid);
		
		int min = 100;
		int max = 200;
		
		int randomOtp = (int)(Math.random()*(max-min+1)+min);
		
		System.out.println("random number- "+randomOtp);
		// Code to send mail to user after booking the prouduct
		
		request.setAttribute("EmailOTP", randomOtp);
		request.setAttribute("Email", partymail);
		
		String to = resetEmail;
		  
		boolean insertData = false;
		
		Map<String, Object> insertMap = new HashMap<>();
		
		insertMap.put("PARTYID", new String(partyid));
		insertMap.put("PARTYEMAIL", new String(partymail));
		insertMap.put("OTP", new Integer(randomOtp));
		
		insertData = EntityQuery.insertData("PASSSWORDRECOVERY", insertMap);
		
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
	         message.setSubject(" Reset Your Password ");

	         // Now set the actual message
	         message.setText("Dear "+partyFname+" "+partyMname+", This is your otp- "+randomOtp+"\n Use this One Time Password(OTP) to reset your passsword. Thankyou");

	         // Send message
	         Transport.send(message);
	         System.out.println("Sent message successfully....");
	      } 
	      catch (MessagingException mex)
	      {
	         mex.printStackTrace();
	      }
		
	  	RequestDispatcher dispatcher = request.getRequestDispatcher("Change_Password.jsp");
		dispatcher.forward(request, response);
	
	//doGet(request, response);
	}

}
