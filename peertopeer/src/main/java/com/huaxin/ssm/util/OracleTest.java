package com.huaxin.ssm.util;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.huaxin.ssm.bean.Salgrade;

/**
 * @author 作者 卜天全:
 * 
 * @version 创建时间：2019年3月7日 下午3:58:33
 * 
 *          类说明
 */
public class OracleTest {

	public OracleTest() {
		// TODO Auto-generated constructor stub
	}

	public static void add(Salgrade salgrade) {
		Connection con = DButil.getCon();
		PreparedStatement ps = null;
		String sql = "insert into salgrade values (?,?,?)";
		try {
			ps = con.prepareStatement(sql);
			/*
			 * for(int b=0;b<1000;b++) { ps.setInt(1, salgrade.getGrade()+b);
			 * ps.setString(2,salgrade.getLosal()); ps.setString(3,salgrade.getHisal());
			 * ps.addBatch();
			 * }
			 */
			for (int i = 0; i < 100000; i++) {
				ps.setInt(1, salgrade.getGrade() + i);
				ps.setString(2, salgrade.getLosal());
				ps.setString(3, salgrade.getHisal());
				ps.addBatch();
				if (i % 10000 == 0) {
					ps.executeBatch();
					con.commit();
					ps.clearBatch();
				}
			}
			ps.executeBatch();
			con.commit();
			ps.clearBatch();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DButil.close(ps, null, con);
		}
	}

	public static void main(String[] args) {
		Salgrade salgrade = new Salgrade();
		salgrade.setGrade(1);
		salgrade.setLosal("2");
		salgrade.setHisal("3");
		long startTime = System.currentTimeMillis();// 获取当前时间
		add(salgrade);
		long endTime = System.currentTimeMillis();
		System.out.println("程序运行时间：" + (endTime - startTime) / 1000 + "ms");
	}

}
