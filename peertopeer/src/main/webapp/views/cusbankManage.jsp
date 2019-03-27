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
        <div id="t_toolbar">
             <label>银行名称:</label> <input id="s_name" name="name" class="easyui-textbox">
             <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="searchObj()">查询</a>
             <a href="javascript:reSet();" class="easyui-linkbutton" iconCls="icon-clear">重置</a> 
             <a href="javascript:openAddDialog()" class="easyui-linkbutton" iconCls="icon-add">增加</a>
	    </div>
	    <!-- 定义数据列表 -->
        <div id="DataGird" style="height:480px"></div> 
        <!-- 添加/修改对话框 -->
		<div id="addOrUpdateDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 30px 20px" closed="true">
			<form id="addOrUpdateForm">
				<input type="hidden" id="c_id" name="id"/>
				<div style="height: 30px;">
				    <label>所属客户:</label> <input id="cusSelect" name="cid" class="easyui-combobox" required="true"/>
				</div>
				<div style="height: 30px;">
					<label>银行编号:</label> <input id="bankno" name="bankno" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>银行名称:</label> <input id="bankname" name="bankname" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>客户账号:</label> <input id="cardno" name="cardno" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>账户名称:</label> <input id="cardname" name="cardname" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>开户省份:</label> <input id="province" name="province" class="easyui-combobox" >
				</div>
				<div style="height: 30px;">
					<label>开户城市:</label> <input id="city" name="city" class="easyui-textbox">
				</div>
				<div style="height: 30px;">
					<label>开户区县:</label> <input id="county" name="county" class="easyui-textbox">
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
			$('#DataGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...", 
			    url:path+"/cusbank/getAllCusBank.do",
			    fitColumns: true,
			    rownumbers: true,
			    singleSelect: true,
			    toolbar:'#t_toolbar',
			    pagination:true,//设置是否分页
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  
				            { title: '客户编号', field: 'customer_code', width: 100},  
				            { title: '客户名称', field: 'customer_name', width: 100},  
				            { title: '银行编号', field: 'bankno', width: 100},  
				            { title: '银行名称', field: 'bankname', width: 100},  
				            { title: '账号', field: 'cardno', width: 100},  
				            { title: '开户名', field: 'cardname', width: 100}, 
				            { title: '省份', field: 'sheng', width: 100}, 
				            { title: '是否激活', field: 'active', width: 100,
				            	formatter: function(value,row,index){
				            		var str = "";
				            		if(value==0){
				            			str="未激活";
				            		}else{
				            			str="已激活";
				            		}
				            		return str;
				    			}
				            }, 
				            { title: '操作', field: 'id', width: 100,
				            	formatter: function(value,row,index){
				            		var str = "";
				            		if(row.active==0){
				            			str +="  <a href=\"javascript:deleteObj('"+value+"')\">删除</a>  ";
				            			str +="  <a href=\"javascript:activeObj('"+value+"','"+row.cid+"')\">激活</a>  ";
				            		}
				            		str +="  <a href=\"javascript:updateDialog('"+value+"')\">修改</a>  ";
				            		return str;
				    			}
							}
				        ]]
			});

		});
		//打开添加客户的dialog
		function openAddDialog(){
			$('#addOrUpdateForm').form('clear');
			//加载客户信息
			$.ajax({
		        type: "POST",
		        url: path+"/cusbank/getCustomerList.do",
		        data: {},
		        dataType : 'json',
		        success: function(data){
		        	//alert(JSON.stringify(data));
		        	$('#cusSelect').combobox({    
						data:data.list,    
					    valueField:'cid',    
					    textField:'customer_name'
					});
		        	$('#province').combobox({    
						data:data.sslist,
					    valueField:'id',    
					    textField:'sheng'
					});
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
			$('#addOrUpdateDialog').dialog('open').dialog('setTitle', '新增客户开户信息');
		}
		function dialogClose(){
			$('#addOrUpdateDialog').dialog('close');
		}
		//打开修改窗口
		function updateDialog(id){
			$('#addOrUpdateForm').form('clear');
			$.ajax({
		        type: "POST",
		        url: path+"/cusbank/getCusBankById.do",
		        data: {"id":id},
		        dataType : 'json',
		        success: function(data){
		        	var bankinfo=data.bankinfo;
		        	var cuslist=data.cuslist;
		        	$("#c_id").val(id);
		        	$('#cusSelect').combobox({    
						data:cuslist,    
					    valueField:'cid',    
					    textField:'customer_name'
					});
 		        	$('#cusSelect').combobox('setValue', bankinfo.cid);
		        	$("#bankno").textbox('setValue',bankinfo.bankno);
		        	$("#bankname").textbox('setValue',bankinfo.bankname);
 		        	$("#cardno").textbox('setValue',bankinfo.cardno);
 		        	$("#cardname").textbox('setValue',bankinfo.cardname);
 		        	
 		        	//$("#province").textbox('setValue',bankinfo.province);
 		        	
 		        	$('#province').combobox({    
						data:data.sslist,
					    valueField:'id',    
					    textField:'sheng'
					});
 		        	$('#province').combobox('setValue', bankinfo.province);
 		        	$("#city").textbox('setValue',bankinfo.city);
 		        	$("#county").textbox('setValue',bankinfo.county);
		        	$('#addOrUpdateDialog').dialog('open').dialog('setTitle', '修改客户开户信息');
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//删除客户
		function deleteObj(id){
			$.ajax({
		        type: "POST",
		        url: path+"/cusbank/deleteCusBank.do",
		        data: {"id":id},
		        dataType : 'text',
		        success: function(data){
		        	if(data==1){
		        		$.messager.alert('提示', '操作成功', 'info');
			        	$('#DataGird').datagrid('reload'); 
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//激活
		function activeObj(id,cid){
			$.ajax({
		        type: "POST",
		        url: path+"/cusbank/activeObj.do",
		        data: {"id":id,"cid":cid},
		        dataType : 'text',
		        success: function(data){
		        	if(data>=1){
		        		$.messager.alert('提示', '操作成功', 'info');
			        	$('#DataGird').datagrid('reload'); 
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//查询客户
		function searchObj() {
			var sname=$("#s_name").textbox('getValue');
			var url=path+"/cusbank/getAllCusBank.do";
			$('#DataGird').datagrid({
				url:url,
				queryParams:{"sname":sname}
			});
	    }
		//重置查询条件
		function reSet() {
			$("#s_name").textbox('setValue',"");
		}
		//保存添加、修改内容
		function saveOrUpdate() {
			url = path+"/cusbank/saveOrUpdate.do";
			$.ajax({
		        type: "POST",
		        url: url,
		        data: $('#addOrUpdateForm').serialize(),
		        dataType : 'text',
		        success: function(data){
		        	if(1==data){
		        		$.messager.alert('提示', '操作成功', 'info');
		        		$('#addOrUpdateDialog').dialog('close');
		        		$('#DataGird').datagrid('reload'); 
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
			$('#addOrUpdateForm').form('submit',{
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},    
			    success:function(data){    
			    	saveOrUpdate();
			    }
			});
		}
		
	</script>     
    
</body>
</html>