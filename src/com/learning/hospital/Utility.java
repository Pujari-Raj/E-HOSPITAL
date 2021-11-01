package com.learning.hospital;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpRequest.BodyPublisher;
import java.net.http.HttpRequest.BodyPublishers;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.paytm.pg.merchant.PaytmChecksum;

public class Utility {

	public static String getUserFromEmail(String email) {
		
		//JDBC Connection 
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		String Query = "SELECT * FROM PARTY where email=?";
		String usrnm = "";
		
		try {
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			//Statement stat = conn.createStatement();
			PreparedStatement preparedStat = conn.prepareStatement(Query);
			preparedStat.setString(1, email);
			
			ResultSet rs = preparedStat.executeQuery();
			
			if(rs.next())
			{	
				usrnm=rs.getString("FNAME");// getting the firstname from the PARTY table 
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
		
		return usrnm;
		
	}

	//code to validate whether user is logged in and his session is going or not
	public static boolean user_login_Validate(HttpServletRequest request) 
	{
		HttpSession session = request.getSession();
		if(session.getAttribute("customer")==null)
		{
			System.out.println("in login_validate");
			return false;
		}
		else
		{	
			return true;
		}
	}
	
	public static Map<String, Object> getpaytmtransaction_token(String callbackurl,String transactionurl,String merchantid,String merchantkey,String website,String orderId,String customerId,String channelid)
	{
		
		Map<String, Object> paytmtransaction = new HashMap<String, Object>();
		
		JSONObject paytmParams = new JSONObject();
		JSONObject paytmBody = new JSONObject();
		
		try 
		{
			paytmBody.put("requestType", "Payment");
			paytmBody.put("mid", merchantid);
			paytmBody.put("websiteName", website);
			paytmBody.put("callbackUrl", callbackurl);
			paytmBody.put("orderId", orderId);
			
			JSONObject transactionAmt = new JSONObject();
			transactionAmt.put("value",new BigDecimal(500.00));
			transactionAmt.put("currency", "INR");
			
			JSONObject userInfo = new JSONObject();
			userInfo.put("custId", customerId);
			
			paytmBody.put("txnAmount", transactionAmt);
			paytmBody.put("userInfo", userInfo);
			
			String checksum = PaytmChecksum.generateSignature(paytmBody.toString(), merchantkey);
			
			JSONObject head = new JSONObject();
			head.put("signature", checksum);
			 		
			paytmParams.put("head", head);
			paytmParams.put("body", paytmBody);
			//paytmParams.put("channelId", channelid); 
			
			System.out.println(callbackurl);
			System.out.println(transactionurl);
			System.out.println(merchantid);
			System.out.println(merchantkey);
			System.out.println(website);
			System.out.println(orderId);
			System.out.println(checksum);
			
			String post_data = paytmParams.toString();
			
			System.out.println(paytmParams.toString());
			
			URL url = new URL(transactionurl+"?mid="+merchantid+"&orderId="+orderId);
			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.setRequestMethod("POST");
			urlConnection.setRequestProperty("Content-Type", "application/json");
			urlConnection.setDoOutput(true);

			System.out.println(urlConnection.getResponseCode());
			
			HttpClient client = HttpClient.newHttpClient();
			HttpRequest httpRequest =  (HttpRequest) HttpRequest.newBuilder().uri(URI.create(transactionurl+"?mid="+merchantid+"&orderId="+orderId)).header("Accept", "application/json").POST(BodyPublishers.ofString(paytmParams.toString())).build();
			HttpResponse<String> httpResponse = client.send(httpRequest,BodyHandlers.ofString());
			
			if(httpResponse.statusCode()!=200)
			{
				System.out.println("Error in response"+httpResponse);
			}
			else
			{
				System.out.println("response"+httpResponse.body());
			}
			
			//DataOutputStream dataOutputStream = new DataOutputStream(urlConnection.getOutputStream());
			//dataOutputStream.writeBytes(post_data);
//			//dataOutputStream.close();
//			String responsedata = "";
//			InputStream  inputStream = urlConnection.getInputStream();
//			BufferedReader bufferedReader = new BufferedReader(new java.io.InputStreamReader(inputStream));
//			
//			if((responsedata=bufferedReader.readLine())!=null)
//			{
//				System.out.println("response data- "+responsedata);
//			}	
//			bufferedReader.close();
//			urlConnection.disconnect();
		} 
		catch (JSONException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		catch (IOException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return paytmtransaction;	
	}
	
	private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	public static String randomAlphaNumeric(int count) 
	{
	StringBuilder builder = new StringBuilder();
	while (count-- != 0) {
	int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
	builder.append(ALPHA_NUMERIC_STRING.charAt(character));
	}
	return builder.toString();
	}
}
