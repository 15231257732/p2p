<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/icon.css">
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/easyui-lang-zh_CN.js"></script>
</head>

<body >
    <div  style="height:490px">
        <div id="p_toolbar">
             <label>产品名称:</label> <input id="s_productname" name="productname" class="easyui-textbox">
             <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="searchUser()">查询</a>
             <a href="javascript:reSet();" class="easyui-linkbutton" iconCls="icon-clear">重置</a> 
             <a href="javascript:openAddUserDialog()" class="easyui-linkbutton" iconCls="icon-add">增加</a>
	    </div>
	    <!-- 定义数据列表 -->
        <div id="productGird" style="height:480px"></div> 
        <!-- 添加/修改对话框 -->
		<div id="addOrUpdateProductDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 30px 20px" closed="true">
			<form id="addOrUpdateProductForm">
				<input type="hidden" id="product_id" name="id"/>
				<div style="height: 30px;">
					<label>产品名称:</label> <input id="product_name" name="name" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>年化收益:</label> <input id="product_proceeds" name="proceeds" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>是否上架:</label>
					<select id="isshelf" name="isshelf" class="easyui-combobox" >
						<option value="">--请选择--</option>
						<option  value="1">上架</option>
						<option  value="0">下架</option>
					</select>
				</div>
				
				<div style="height: 30px;">
					<label>购买周期:</label> <input id="period" name="period" class="easyui-textbox">
				</div>
				
			</form>
			<div>
				<a href="javascript:submitForm()" class="easyui-linkbutton" iconCls="icon-save" >保存</a>
				<a href="javascript:dialogClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
		</div>
    </div>
    
    <script type="text/javascript">
        var path = '<%=path%>';
		$(function(){   
			$('#productGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...", 
			    url:path+"/product/getAllProduct.do",
			    fitColumns: true,
			    rownumbers: true,
			    singleSelect: true,
			    toolbar:'#p_toolbar',
			    pagination:true,//设置是否分页
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  
				            { title: '产品名称', field: 'name', width: 100},  
				            { title: '年化收益', field: 'proceeds', width: 100},  
				            { title: '够买周期', field: 'period', width: 100},  
				            { title: '是否上架', field: 'isshelf', width: 100,
				            	formatter: function(value,row,index){
				            		return value=="1"?"已上架":"已下架"
				                }
				            },
				            { title: '操作', field: 'id', width: 100,
				            	formatter: function(value,row,index){
				            		var str = "";
				            		str +="  <a href=\"javascript:deleteProduct('"+value+"')\">删除</a>  ";
				            		str +="  <a href=\"javascript:updateProductDialog('"+value+"')\">修改</a>  ";
				            		return str;
				    			}
							}
				        ]]
			});
			/* var p = $('#roleGird').datagrid('getPager');
            $(p).pagination({
                pageSize: 10,//每页显示的记录条数，默认为10  
                pageList: [10,20,30,50],//可以设置每页记录条数的列表  
                beforePageText: '第',//页数文本框前显示的汉字  
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
            }); */

		});
		//打开添加产品的dialog
		function openAddUserDialog(){
			$('#addOrUpdateProductForm').form('clear');
			$('#addOrUpdateProductDialog').dialog('open').dialog('setTitle', '新增产品');
		}
		function dialogClose(){
			$('#addOrUpdateProductDialog').dialog('close');
		}
		//打开修改窗口
		function updateProductDialog(productid){
			$('#addOrUpdateProductForm').form('clear');
			$.ajax({
		        type: "POST",
		        url: path+"/product/getProductById.do",
		        data: {"id":productid},
		        dataType : 'json',
		        success: function(data){
		        	$("#product_id").val(data.id);
		        	$("#product_name").textbox('setValue',data.name);
		        	$("#product_proceeds").textbox('setValue',data.proceeds);
 		        	$("#isshelf").combobox('setValue',data.isshelf);
 		        	$("#period").textbox('setValue',data.period);
		        	$('#addOrUpdateProductDialog').dialog('open').dialog('setTitle', '修改产品');
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//删除产品
		function deleteProduct(productid){
			$.ajax({
		        type: "POST",
		        url: path+"/product/deleteProduct.do",
		        data: {"id":productid},
		        dataType : 'text',
		        success: function(data){
		        	if(data==1){
		        		$.messager.alert('提示', '操作成功', 'info');
			        	$('#productGird').datagrid('reload'); 
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//查询产品
		function searchUser() {
			var sname=$("#s_productname").textbox('getValue');
			var url=path+"/product/getAllProduct.do";
			$('#productGird').datagrid({
				url:url,
				queryParams:{"sname":sname}
			});
	    }
		//重置查询条件
		function reSet() {
			$("#s_username").textbox('setValue',"");
		}
		//保存添加、修改内容
		function saveOrUpdateProduct() {
			url = path+"/product/saveOrUpdateProduct.do";
			$.ajax({
		        type: "POST",
		        url: url,
		        data: $('#addOrUpdateProductForm').serialize(),
		        dataType : 'text',
		        success: function(data){
		        	if(1==data){
		        		$.messager.alert('提示', '操作成功', 'info');
		        		$('#addOrUpdateProductDialog').dialog('close');
		        		$('#productGird').datagrid('reload'); 
		        	}else{
		        		$.messager.alert('提示', '操作失败', 'info');
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		function submitForm(){
			$('#addOrUpdateProductForm').form('submit',{
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},    
			    success:function(data){    
			    	saveOrUpdateProduct();
			    }
			});
		}
		
	</script>     
    
</body>
</html>