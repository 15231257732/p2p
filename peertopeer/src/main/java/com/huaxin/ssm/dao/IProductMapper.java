package com.huaxin.ssm.dao;

import java.util.List;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Product;



public interface IProductMapper {
	
	public Integer deleteProduct(String id);
	
	public List<Product> getAllProduct(PageBean pagebean);
	
	public Integer getProductCount(PageBean pagebean);
	
	public Integer addProduct(Product product);
	
	public Integer updateProduct(Product product);
	
	public Product getProductById(String id);
	
	public List<Product> getProductList();
	
	
}
