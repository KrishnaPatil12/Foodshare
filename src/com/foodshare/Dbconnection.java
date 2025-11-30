package com.foodshare;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class Dbconnection {
	static Connection con=null;
	public static Connection connect(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/foodsharedb","root","");
		}
		catch(ClassNotFoundException e){
			e.printStackTrace();
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return (con);
	}

}