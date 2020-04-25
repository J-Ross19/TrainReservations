package main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
	
	public Database(){
		
	}

	public Connection getConnection(){
		
		//Create a connection string
		//group11database.cyivjxy8m4jv.us-east-2.rds.amazonaws.com:330/cs336Sample/
		String connectionUrl = "jdbc:mysql://group11database.cyivjxy8m4jv.us-east-2.rds.amazonaws.com:3306/TrainDatabase";
		Connection connection = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl,"admin", "asecurepassword");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	
	
	public static void main(String[] args) {
		Database dao = new Database();
		Connection connection = dao.getConnection();
		
		System.out.println(connection);		
		dao.closeConnection(connection);
	}
	
	

}

