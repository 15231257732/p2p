package com.huaxin.ssm.service;

import java.util.List;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Product;


public interface IProductService {
	
	//删除
	public Integer deleteProduct(String id);
	//分页查询全部
	public List<Product> getAllProduct(PageBean pagebean);
	//分页
	public Integer getProductCount(PageBean pagebean);
	//增加或修改
	public Integer saveOrUpdateProduct(Product u);
	//通过ID查询信息
	public Product getProductById(String id);
	//查询全部
	public List<Product> getProductList();
	
	
}
