package com.huaxin.ssm.bean;
/** 
* @author 作者 卜天全: 

* @version 创建时间：2019年3月7日 下午4:18:59 

* 类说明 
*/
public class Salgrade {

	//测试oracle数据库实现类
	public int grade;
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String losal;
	public String hisal;
	
	public String getLosal() {
		return losal;
	}
	public void setLosal(String losal) {
		this.losal = losal;
	}
	public String getHisal() {
		return hisal;
	}
	public void setHisal(String hisal) {
		this.hisal = hisal;
	}

}
