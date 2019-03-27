package com.huaxin.ssm.util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
public class DButil {
	
	//��ȡ���ݿ������
	public static  Connection getCon(){
		Connection con=null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con=DriverManager.getConnection("jdbc:oracle:thin:localhost:1521:orcl", "scott","orcl");
			System.out.println("con==="+con);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	} 
	
	public static void main(String[] args) {
		getCon();
	}
	
	public static void close(Statement st,ResultSet rs,Connection con){
		try {
			if(rs!=null){
				rs.close();
			}
			if(st!=null){
				st.close();
			}
			if(con!=null){
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

