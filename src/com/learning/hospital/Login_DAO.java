package com.learning.hospital;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Login_DAO {

	// Validating the user using their email & password
	// 
	public static boolean login_validate(String email, String Password) {
		
		boolean status = false;
		
		//JDBC Connection 
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		String Query = "SELECT * FROM PARTY where email=? and pswd=?";
		
		
		try 
		{
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			//Statement stat = conn.createStatement();
			PreparedStatement preparedStat = conn.prepareStatement(Query);
			preparedStat.setString(1, email);
			preparedStat.setString(2, Password);
			
			ResultSet rs = preparedStat.executeQuery();
			status= rs.next();// setting the resultset value in status object
					
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println(" Class Not found Exception in Login_DAO class "+e.getMessage());
		}
		catch (SQLException e) {
			System.out.println("SQLException in Login_DAO class  "+e.getMessage());
		}
		return status;		
	}	
	
	public static boolean validate_email(String email) 
	{
		
		boolean status = false;
		
		//JDBC Connection 
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		String Query = "SELECT * FROM PARTY where email=?";
		
		
		try 
		{
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			//Statement stat = conn.createStatement();
			PreparedStatement preparedStat = conn.prepareStatement(Query);
			preparedStat.setString(1, email);
			
			ResultSet rs = preparedStat.executeQuery();
			status= rs.next();// setting the resultset value in status object
					
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println(" Class Not found Exception in Login_DAO class "+e.getMessage());
		}
		catch (SQLException e) {
			System.out.println("SQLException in Login_DAO class  "+e.getMessage());
		}
		return status;		
	}	

}
