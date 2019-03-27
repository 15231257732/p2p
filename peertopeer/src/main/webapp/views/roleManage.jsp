<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <% String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/icon.css">
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/easyui-lang-zh_CN.js"></script>
</head>


<script type="text/javascript">
var path = '<%=path%>';
var currentRoleId;
$(function(){   
	$('#roleGird').datagrid({
	    loadMsg: "正在加载数据，请稍等...",  
	    url : path+"/role/getAllRole.do",
	    fitColumns: true,
	    rownumbers: true,
	    singleSelect: true,
	    toolbar:'#toolbar',
	    pagination:true,
	    pageList:[10,20,30,50],
	    pageSize:10,
	    columns: [[  
	            { title: '角色名称', field: 'name', width: 100},  
	            { title: '操作', field: 'id', width: 100,
	            	formatter: function(value,row,index){
	            		//alert(value);
	            		var str = "";
	            		str +="  <a href=\"javascript:loadMenuAuthority('"+value+"')\">菜单权限</a>";
	            		str +="  <a href=\"javascript:deleteRoleById('"+value+"')\">删除</a>";
	            		return str;
	    			}
				}
	        ]]
	});
})
	//打开添加角色的dialog
	function openAddRoleDialog(){
		//alert(132);
		$('#addRoleForm').form('clear');
		$('#addRoleDialog').dialog('open').dialog('setTitle','添加角色');
	}
//保存添加的角色
function addRole(){
	 $('#addRoleForm').form('submit',{
	 	url: path+"/role/saveOrUpdateRole.do",
	 	onSubmit: function(){
	 		return $(this).form('validate');
	 	},
		success: function(data){
			$('#addRoleDialog').dialog('close'); 
			$('#roleGird').datagrid('reload'); 
		}
 	});
}
//删除角色
function deleteRoleById(roleId){
	$.ajax({
        type: "POST",
        url: path+"/role/deleteRole.do",
        data: {"id":roleId},
        dataType : 'text',
        success: function(data){
        	$.messager.alert('提示', '操作成功', 'info');
        	$('#roleGird').datagrid('reload'); 
        },
        error: function(e){
        	$.messager.alert('提示', '操作失败', 'error');
        }
    });
}
//加载指定角色的菜单权限
function loadMenuAuthority(roleId){
	currentRoleId=roleId;
	//var data=[{'id':1,'text':'aa', 'children':[{'text':'bb','checked':true},{'text':'dd','checked':true}]},{ 'text':'cc','state':'open','children':[{'text':'Java'},{ 'text':'C'}] }];
	$('#menuAuthTreeDialog').dialog('open').dialog('setTitle','菜单权限');
	$('#menuAuthTree').tree({
		lines: true,
		checkbox: true,
		//data:data,
		url:path+"/role/getMenuAuthTree.do?id="+roleId
	});
}
//保存修改好后的角色菜单权限
function saveMenuAuthority(){
	var nodes = $('#menuAuthTree').tree('getChecked');
	var indeterminate = $('#menuAuthTree').tree('getChecked', 'indeterminate');
	var menuIds="";
	if(currentRoleId != null){
		if(nodes.length > 0){
			for (var i=0;i<nodes.length;i++){
				if(menuIds==""){
					menuIds+=nodes[i].id;
				}else{
					menuIds+="|"+nodes[i].id;
				}
			}
		}
		$.ajax({
	        type: "POST",
	        url: path+"/role/updateRoleMenu.do" ,
	        data: {'menuid':menuIds,'roleid':currentRoleId},
	        dataType : 'text',
	        success: function(data){
	        	if("true"==data){
	        		$.messager.alert('提示', '操作成功', 'info');
	        	}else{
	        		$.messager.alert('提示', '操作失败', 'info');
	        	}
	        },
	        error: function(e){
	        	$.messager.alert('提示', '操作失败', 'error');
	        }
	    });
	}
}
</script>
<body class="easyui-layout">
<div  style="width:100%;height:100%">
        <div id="toolbar">
		     <a href="javascript:openAddRoleDialog()" class="easyui-linkbutton" iconCls="icon-add">增加</a> 
	    </div> 
	    <div id="roleGird" style="height:100%;width: 100%;"></div> 
        <div id="addRoleDialog" class="easyui-dialog" style="width:100%;height:100%;padding:30px 20px" closed="true" buttons="#addRoleButtons">
			<form id="addRoleForm" method="post">
				<div >
					<label>角色名称:</label> <input name="name" class="easyui-textbox" required="true">
				</div>
			</form>
		</div>
		<div id="addRoleButtons">
			<a href="javascript:addRole()" class="easyui-linkbutton" iconCls="icon-save">保存</a> 
			<a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
		</div>
		<div id="menuAuthTreeDialog" class="easyui-dialog" title="权限列表" style="width:30%;height:60%;" closed="true">
			<ul id="menuAuthTree" class="easyui-tree"></ul>
			<a href="javascript:saveMenuAuthority()" class="easyui-linkbutton" iconCls="icon-save" style="align-content: center;">保存</a> 
		</div>
</div>
</body>
</html>