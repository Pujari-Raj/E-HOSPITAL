package com.framework.entity;

import java.sql.Array;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;

public class EntityQuery {

	//Getting the Single record from table
	//queryOne(String from, String whereCdtn)=>passing the tablename in 1st paramter (from ->'tablename',) and whereConditions in 2nd paramter(whereCond->'Where columname='value'') 
	public static Map<String, Object> queryOne(String from,String whereCond) {
		
		//Creating Map for storing the whereCond getting from parameter
		Map<String, Object> whereMap = whereMap(whereCond);
		
		//Creating map for getting the data from Database
		Map<String, Object> returnrslt = new HashMap<String, Object>();
		
		//Passing the map with (where conditions) whereMap to mapToString to convert from Map into String
		StringBuilder whereQueryString = mapToString(whereMap);
		
		//Writing Query
		StringBuilder query = new StringBuilder("select * from "+from+" where "+whereQueryString);
		
		System.out.println(query);
		try 
		{
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/test", "sa", "sasa");
			//Statement stat = conn.createStatement();
			
			PreparedStatement preparedStat = conn.prepareStatement(query.toString());
			ResultSet rs = preparedStat.executeQuery();
			//metadata(is data about data) i.e from resultset-> rs we are executing the query to get 
			//the data from the rs we need resultsetmetadata to get the  data from the (rs) 
			ResultSetMetaData rsmetaData = rs.getMetaData();
			
			while(rs.next())
			{		
				//getColumnCount() method retreives the no of colm's from the table we're fetching the data 
				for(int i=1;i<=rsmetaData.getColumnCount();i++)	
				{
					//getColumnName get the Colm name from the key receivied from parameter and search it in dbase
					//getColumnName get the Colm value from the value  receivied from parameter and search it in dbase
					returnrslt.put(rsmetaData.getColumnName(i), rs.getString(rsmetaData.getColumnName(i)));  
				}
			}
		} 
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return returnrslt;	//returns Map
	}
	
	//In this way where Condition should be passed in parameter"PARTYID=8 ,PARTYTYPE='Patient'"
	//whereMap(String whereConditions) funtion accepts the where conditions as paramter
	public static Map<String, Object> whereMap(String whereConditions) 
	{
		//Creating Map to store the where cdtns 
		Map<String, Object> whereMap = new HashMap<String, Object>();
		
		//It will split the where condition (in query) with the (",")
		//Storing (Map<String, Object>) into an array 
		//Spliiting the One Array into multiple Array with "comma(,)"
				String[] keyValuePairs = whereConditions.split(","); 
			
				//System.out.println("key value pair-"+keyValuePairs.length);
				for(String keyValuePair:keyValuePairs) 
				{
					//Splitting the where cdtn with '=' 
					String[] entry = keyValuePair.split("=");
					//putting array values into the Map
					whereMap.put(entry[0], entry[1]);
					//System.out.println("entry value- "+entry[0]+" "+entry[1]);
				}	
		return whereMap;
	}
	
	public static StringBuilder whereStringBuilder(String whereConditions) 
	{
		//Creating Map to store the where cdtns 
		StringBuilder builder = new StringBuilder();
		//It will split the where condition (in query) with the (",")
		//Storing (Map<String, Object>) into an array 
		//Spliiting the One Array into multiple Array with "comma(,)"
				String[] keyValuePairs = whereConditions.split(","); 
			
				int i=1;
				//System.out.println("key value pair-"+keyValuePairs.length);
				for(String keyValuePair:keyValuePairs) 
				{
					//Splitting the where cdtn with '=' 
					String[] entry = keyValuePair.split("=");
					//putting array values into the Map
					
					builder.append(entry[0]+"="+entry[1]);
					
					//System.out.println("entry value- "+entry[0]+" "+entry[1]);
				
					if(entry.length>i)
					{
						builder.append(" or ");
					}
					i++;
				}	
		return builder;
	}
	
	//mapToString(Map<> condition) will take map as Conditions and changing it to String Query
	public static StringBuilder mapToString(Map<String, Object> condition) 
	{
		//Creating StringBuilder so that we can change the condition receving from parameter
		StringBuilder cndtnQuery = new StringBuilder();
		
		int i = 1; //Creating (ResultSet) Size 
		
		
		//modern for loop(for-each loop)
		//for(data_type variable_name:array)-->for(Map<String, Object>('Datatype') entryMap('variable_name'):condition(collection).entrySet())
		for(Map.Entry<String, Object> entryMap:condition.entrySet())
		{
			//Appending the wherecondition String
			//entryMap.getKey gets the columname and add (=) symbol between columnvalue
			cndtnQuery.append(entryMap.getKey()+"="+entryMap.getValue());
			
			//It will append the where contdition with "and" if they specify more than 1 colm into parameter 
			if(condition.size()>i)
			{
				cndtnQuery.append(" and ");
			}
			i++;
		}
		return cndtnQuery;	
	}
	
	//fetching multiple records(SAME AS queryOne() function) 
	public static List<Map<String, Object>> queryList(String from,String whereConditions)
	{
		StringBuilder query = new StringBuilder();
		List<Map<String, Object>> listQuery = new ArrayList<Map<String,Object>>();
		
		if(whereConditions!=null)
		{	
			Map<String, Object> whereMap = whereMap(whereConditions);
			
			System.out.println(whereMap);
		StringBuilder whereQueryString = mapToString(whereMap);
		
		query = new StringBuilder("select * from "+from+" where "+whereQueryString);
		}
		if(whereConditions==null)
		{
			query = new StringBuilder("select * from "+from);
		}
		try 
		{
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/test", "sa", "sasa");
			//Statement stat = conn.createStatement();
			
			PreparedStatement preparedStat = conn.prepareStatement(query.toString());
			//System.out.println(query);
			
			ResultSet rs = preparedStat.executeQuery();
			//metadata(is data about data) i.e from resultset-> rs we are executing teh query to get 
			//the data from the rs we need resultsetmetadata to get the  data from the (rs) 
			ResultSetMetaData rsmetaData = rs.getMetaData();
			
			while(rs.next())
			{		
				Map<String, Object> singleRecord = new HashMap<String, Object>();
				
				for(int i=1;i<=rsmetaData.getColumnCount();i++)	
				{
					singleRecord.put(rsmetaData.getColumnName(i), rs.getString(rsmetaData.getColumnName(i)));  
				}
				listQuery.add(singleRecord);
			}
		} 
		catch (ClassNotFoundException e) 
		{
			e.printStackTrace();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
			//System.out.println("List size- "+listQuery.size());
		
			
		return listQuery; //returns Map
	}
	
	public static List<Map<String, Object>> queryListUpdated(String from,String whereConditions)
	{
		StringBuilder query = new StringBuilder();
		List<Map<String, Object>> listQuery = new ArrayList<Map<String,Object>>();
		
		if(whereConditions!=null)
		{	
			
			//Map<String, Object> whereMap = whereMap(whereConditions);
			
			//System.out.println(whereMap);
		StringBuilder whereQueryString = whereStringBuilder(whereConditions);
		
		query = new StringBuilder("select * from "+from+" where "+whereQueryString);
		}
		if(whereConditions==null)
		{
			query = new StringBuilder("select * from "+from);
		}
		try 
		{
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/test", "sa", "sasa");
			//Statement stat = conn.createStatement();
			
			PreparedStatement preparedStat = conn.prepareStatement(query.toString());
			//System.out.println(query);
			
			ResultSet rs = preparedStat.executeQuery();
			//metadata(is data about data) i.e from resultset-> rs we are executing teh query to get 
			//the data from the rs we need resultsetmetadata to get the  data from the (rs) 
			ResultSetMetaData rsmetaData = rs.getMetaData();
			
			while(rs.next())
			{		
				Map<String, Object> singleRecord = new HashMap<String, Object>();
				
				for(int i=1;i<=rsmetaData.getColumnCount();i++)	
				{
					singleRecord.put(rsmetaData.getColumnName(i), rs.getString(rsmetaData.getColumnName(i)));  
				}
				listQuery.add(singleRecord);
			}
		} 
		catch (ClassNotFoundException e) 
		{
			e.printStackTrace();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
			//System.out.println("List size- "+listQuery.size());
		
			
		return listQuery; //returns Map
	}
	

	
	//Reference query-> INSERT INTO table_name VALUES (value1, value2, value3, ...);

	//insertData function take two parameters i.e tablename, insertMap(conditions map)
	public static boolean insertData(String tablename, Map<String, Object> insertMap)
	{
		StringBuilder insertQuery=  new StringBuilder("insert into ").append(tablename).append("(");
		
		
		List<Object> columnNameList = new ArrayList<Object>();//List of column name in which values are to be inserted
		List<Object> valuesList = new ArrayList<Object>();//List of values  which values is to be inserted
		
		for(String key: insertMap.keySet()) // Getting keyset from map i.e (Getting column names)
		{
			columnNameList.add(key);		//Adding column names to columNameList
		}
		
		for(Object values: insertMap.values()) // Getting values from map i.e (Getting values)
		{
			valuesList.add(values);			//Adding values to valuesList
		}
		
		for(int i=0;i<columnNameList.size();i++) // Iterating columnNameList to its size
		{	
			//Logic to add comma till the end of the columns 
			
			if(i== columnNameList.size()-1)// logic to not add comma to last value		
			{
				insertQuery.append(columnNameList.get(i));
			}	
			else 
			{
				insertQuery.append(columnNameList.get(i)).append(","); // appending Query to append columnames with commas
			}
		}
		insertQuery.append(") ");		//appending query 
		insertQuery.append("values(");	//appending query
		
		for(int i=0;i<valuesList.size();i++)	// Iterating valuesList to its size
		{
			if(i== valuesList.size()-1)	// logic to not add '?' to last value
			{
				insertQuery.append("?");
			}	
			else 
			{
				insertQuery.append("?").append(",");	// appending Query to append values with '?'	
			}
		}
		insertQuery.append(");");
		
		//System.out.println(insertQuery);
		
		String dburl ="jdbc:h2:tcp://localhost/~/test";
		String dbusrnm = "sa";
		String dbpwd = "sasa";
		
		try 
		{
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection(dburl, dbusrnm, dbpwd);
			PreparedStatement prepstatement = conn.prepareStatement(insertQuery.toString());
 			
			for(int i=0;i<valuesList.size();i++)
			{
				// Checking the type of column in which data is to inserted
				if(valuesList.get(i).getClass()== Integer.class)
				{
					prepstatement.setInt(i+1, (Integer)valuesList.get(i));
				}
				else if(valuesList.get(i).getClass()== String.class)
				{
					prepstatement.setString(i+1, (String)valuesList.get(i));
				}
				else if(valuesList.get(i).getClass()== Date.class)
				{
					prepstatement.setDate(i+1, (Date)valuesList.get(i));
				}
				else if(valuesList.get(i).getClass()== Time.class)
				{
					prepstatement.setTime(i+1, (Time)valuesList.get(i));
				}
			}
			
			int i = prepstatement.executeUpdate();
			
			// If all values gets insert into Dbase then forward user to (Login.jsp) else throw exception
			//to forward user from one page to another use RequestDispatcher/ sednRedirect
			if(i>0)
			{
				return true;
			}
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println("Clas Not FOund Exception in Admin_Add_Party"+e.getMessage());
		} 
		catch (SQLException e) 
		{
			System.out.println("SQL Exception  in Admin_Add_Party"+e.getMessage());
		}

		return false;	
	}
	
		
	public static boolean updateData(String tableName,Map<String, Object> valueMap,Map<String, Object> cdtnMap)
	{
		StringBuilder updateQuery = new StringBuilder("update ").append(tableName).append(" set ");
		
		int i=1;
		
		for(Map.Entry<String, Object> entry:valueMap.entrySet())
		{
			updateQuery.append(entry.getKey());
			
			updateQuery.append("=");
			
			if(entry.getValue().getClass()==String.class)
			{	
				updateQuery.append("'"+entry.getValue()+"'");
			}
			
			else if(entry.getValue().getClass()==Integer.class)
			{
				updateQuery.append(entry.getValue());
			}
			
			if(valueMap.size()!=i)
			{
				updateQuery.append(",");
			}
			
			i++;
		}
		updateQuery.append(" where ");
		
		int j=1;
		for(Map.Entry<String, Object> entry:cdtnMap.entrySet())
		{
			updateQuery.append(entry.getKey());
			updateQuery.append("=");
			
			if(entry.getValue().getClass()==String.class)
			{	
				updateQuery.append("'"+entry.getValue()+"'");
			}
			
			else if(entry.getValue().getClass()==Integer.class)
			{
				updateQuery.append(entry.getValue());
			}
			
			if(cdtnMap.size()!=j)
			{
				updateQuery.append(" and ");
			}
			
			j++;
		}
		
		try 
		{
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/test", "sa", "sasa");
			Statement stat = conn.createStatement();
			
			//PreparedStatement preparedStat = conn.prepareStatement(updateQuery.toString());
			int  result = stat.executeUpdate(updateQuery.toString());
			//metadata(is data about data) i.e from resultset-> rs we are executing the query to get 
			//the data from the rs we need resultsetmetadata to get the  data from the (rs) 
			
			//System.out.println(updateQuery);
			
			if(result>0)
			{
				return true;
			}
			
		} 
		catch (ClassNotFoundException e) 
		{
			e.printStackTrace();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		return false;	
}	
		
	public static boolean deleteData (String tableName, String whereCdtn)
	{
		StringBuilder deleteQuery;
		
		if(whereCdtn.contains(","))
		{
			whereCdtn = whereCdtn.replace(",", " and ");
			deleteQuery = new StringBuilder("delete from "+tableName+" where "+whereCdtn);		
		}	
		else
		{	
			deleteQuery =  new StringBuilder("delete from "+tableName+" where "+whereCdtn);
		}
		System.out.println(deleteQuery);
		
		try 
		{
			Class.forName("org.h2.Driver");
			Connection conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/test", "sa", "sasa");
		
			PreparedStatement preparedStatement = conn.prepareStatement(deleteQuery.toString());
			
			
			int rowDelete = preparedStatement.executeUpdate();
			if(rowDelete>0)
			{
				return true;
			}
		}
		catch (ClassNotFoundException e) 
		{
			System.out.println("Clas Not FOund Exception in Admin_Add_Party"+e.getMessage());
		} 
		catch (SQLException e) 
		{
			System.out.println("SQL Exception  in Admin_Add_Party"+e.getMessage());
		}

		return false;		
	}
}