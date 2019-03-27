<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/icon.css">
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.form.js"></script>
</head>
<script type="text/javascript">
$(function(){
	
	getTable();
	$("#dg").datagrid({  
        //双击事件  
        onDblClickRow: function (index, row) {
        	//alert(123);
            UserInfoDialog(row.id);
        }  
    });
	
})
    
function getTable(){
	//获取文本框的值
	var sname=$("#s_username").val();
	//alert(sname);
    	$('#dg').datagrid({
    		//增加查询条件
    	    url:'<%=path%>/user/getAllUser.do?a='+sname+'',
    	    fitColumns:true,
    	    /* autoRowHeight:false, */
    	    rownumbers: true,
    	   /*  singleSelect: true, *//* 是否设置多选 */
    	    pagination:true,//设置是否分页
		    pageList:[10,20,30,50],
		    pageSize:10,
    	    toolbar: '#tb',
    	    columns:[[
    	    	{ title: '', field: '', checkbox:true, width: 100 },
    	    	/* {field:'id',title:'id',width:100}, */
    			{field:'username',title:'用户名',width:100},
    			/* {field:'password',title:'密码',width:100}, */
    			{field:'email',title:'邮箱',width:100},
    			{field:'name',title:'实名',width:100},
    		    { title: '性别', field: 'sex', width: 60,
	            	formatter: function(value,row,index){
	            		var str="";
	            		if(value=="1"){
	            			str="<img src='<%=path%>/images/nans.png' style='width: 20px;height: 20px;'>";
	            		}else{
	            			str="<img src='<%=path%>/images/nvs.png' style='width: 20px;height: 20px;'>";
	            		}
	            		return str;
                    }
	            }, 
    			{field:'qq',title:'QQ',width:100},
    			{field:'weixin',title:'微信号',width:100},
    			{field:'regtime',title:'注册时间',width:100},
    			  /* {field: 'enable',title: '是否启用', width: 80,
	            	formatter: function(value,row,index){
	            		return value=="1"?"已启用":"未启用"
	                }
	            }, */
	            {field: 'filepath',title: '用户照片(点击下载)', width: 110,
	            	
	            	formatter: function(value,row,index){
	            		//页面遍历图片
	            		var strsrc="<%=path%>/user/downloadFile.do?id="+row.id+" ";
	            		var str="<img src="+strsrc+" style='width: 15px;height: 20px;'>";
	            		return "<a href=\"javascript:downloadFile('"+row.id+"')\">"+str+"</a>  "
	                }
	            },
	            {field:'sname',title:'角色类型',width:100},
    			{field:'id',title: '操作', width: 110,
	            	formatter: function(value,row,index){
	            		var str = "";
	            		str +="  <a href=\"javascript:loadRoleAuthority('"+value+"')\">角色配置</a>  ";
	            		str +="  <a href=\"javascript:deleteUser('"+value+"')\">删除</a>  ";
	            		str +="  <a href=\"javascript:toupdate('"+value+"')\">修改</a>  ";
	            		return str;
	    			}
				}
    	    ]]
    	});
    }

//配置用户角色
function loadRoleAuthority(id){
	$('#userId').val(id);
	//$('#roleSelect').val(name);
	$('#roleSelectDialog').dialog('open').dialog('setTitle', '角色配置');
	//查询角色列表
	$.ajax({
        type: "POST",
        url:"<%=path%>/user/getRoleList.do",
        data: {'id':id},
        dataType : 'json',
        success: function(data){
        	//alert(JSON.stringify(data));
        	$('#roleSelect').combobox({    
				data:data.rolelist,    
			    valueField:'id',    
			    textField:'name'
			});
        	$('#roleSelect').combobox('setValue', data.roleid);
        },
        error: function(e){
        	$.messager.alert('提示', '操作失败', 'error');
        }
    });
	
}

//保存用户角色
function saveUserRole(){
	var json = {'id':$('#userId').val(),'roleid':$('#roleSelect').combobox('getValue')};
	$.ajax({
        type: "POST",
        url:"<%=path%>/user/saveUserRole.do",
        data: json,
        dataType : 'text',
        success: function(data){
        	if("1"==data){
        		$.messager.alert('提示', '操作成功', 'info');
        		$('#roleSelectDialog').dialog('close');
        	}else{
        		$.messager.alert('提示', '操作失败', 'info');
        	}
        },
        error: function(e){
        	$.messager.alert('提示', '操作失败', 'error');
        }
    });
}

//打开查看窗口
function UserInfoDialog(id){
	$('#infoForm').form('clear');
	$.ajax({
        type: "POST",
        url:"<%=path%>/user/getUserById.do",
        data: {"id":id},
        dataType : 'json',
        success: function(data){
        	$("#tname").html(data.username);
        	$("#tsex").html(data.sex=="1"?"男":"女");
        	$("#tregtime").html(data.regtime.substring(0,10));
        	$("#temail").html(data.email);
        	$("#tqq").html(data.qq);
        	$("#tweixin").html(data.weixin);
        	$("#tenable").html(data.enable=="1"?"已启用":"未启用");
        	if(data.filepath!="" && data.filepath!=null){
        		$("#tyhzp").attr('src',"<%=path%>/user/downloadFile.do?id="+data.id);
        	}else{
        		$("#tyhzp").attr('src',"<%=path%>/images/mrtx.jpg");
        	}
        	$('#infoDialog').dialog('open').dialog('setTitle', '用户信息');
        	/* $('#dd').dialog('open').dialog('setTitle', '修改用户'); */
        	//$('#dd').dialog('open').dialog('setTitle', '增加用户');
        },
        
        error: function(e){
        	$.messager.alert('提示', '操作失败', 'error');
        }
    });
}
    
//删除用户
function deleteUser(id){
	$.ajax({
        type: "POST",
        url:"<%=path%>/user/deleteUser.do",
        data: {"id":id},
        dataType : 'text',
        success: function(data){
        	if(data==1){
        		$.messager.alert('提示', '操作成功', 'info');
	        	$('#dg').datagrid('reload'); 
        	}
        },
        error: function(e){
        	$.messager.alert('提示', '操作失败', 'error');
        }
    });
}
//增加
function add(){
	//清空表单
	$('#form').form('clear');
	//将图片替换
	$("#yhzp").attr('src',"<%=path%>/images/mrtx.jpg");
	
	$("input[name='sex'][value='男']").prop("checked",true);//性别默认选中
	
	//弹出模态表单框 
	$('#dd').dialog('open').dialog('setTitle', '增加用户');
	$("#password").textbox({disabled:false});//禁用;
}
//提交表单 
function submitForm(){
	$('#form').form('submit',{
		onSubmit:function(){
			return $(this).form('enableValidation').form('validate');
		},    
		success:function(){
	    	saveOrUpdate();
	    }
	});
}
//增加或修改
function saveOrUpdate(){
	var username=$("#username").textbox('getValue');
	var name=$("#name").textbox('getValue');
	if(username==name){
		//上传附件需要用jquery.form中的ajaxSubmit方法
		$('#form').ajaxSubmit({
	        type: "POST",
	        url:"<%=path%>/user/saveOrUpdata.do",
	        dataType : 'text',
	        success: function(data){
	        	if(1==data){
	        		$.messager.alert('提示', '操作成功', 'info');
	        		$('#dd').dialog('close');
	        		$('#dg').datagrid('reload'); 
	        	}else{
	        		$.messager.alert('提示', '操作失败', 'info');
	        	}
	        },
	        error: function(e,a,b){
	        	$.messager.alert('提示', '操作失败', 'error');
	        }
	    });
		
	}else{
		alert("用户名和实名不一致");
	}
	
	<%-- $.ajax({
		type:"post",
		url:"<%=path%>/user/saveOrUpdata.do",
		data:$('#form').serialize(),
		dataType:"text",
		success:function(res){
			//关闭模态框 
			$('#dd').dialog('close');
			//刷新列表
			$('#dg').datagrid('reload');
		}
	}) --%>
}
//打开修改窗口
function toupdate(id){
	$('#form').form('clear');
	$('#dd').dialog('open');
	//$('#password').textbox('textbox').attr('readonly',true);  //设置输入框为禁用
	$("#password").textbox({disabled:true});//禁用;
	//$('#dg').datagrid('reload'); 
	//$('#password').datagrid('hideColumn', 'field')
	//$('#word').next().hide();
	$.ajax({
        type: "POST",
        url:"<%=path%>/user/getUserById.do",
        data: {"id":id},
        dataType : 'json',
        success: function(data){
        	/* alert(data.filepath); */
        	/* {"email":"","enable":"","id":"10060","name":"","password":"11","qq":"11","regtime":"","sex":"1","username":"11","weixin":""} */
        	$("#id").val(data.id);
        	$("#username").textbox('setValue',data.username);
        	$("#password").textbox('setValue',data.password);
        	$("#email").textbox('setValue',data.email);
        	$("#name").textbox('setValue',data.name);
	        	if (data.sex == "1") {
	               $("input[name='sex'][value='1']").prop("checked",true); 
	            }else if(data.sex == "0"){
	               $("input[name='sex'][value='0']").prop("checked",true); 
	            }
	        	$("#qq").textbox('setValue',data.qq);
	        	$("#weixin").textbox('setValue',data.weixin);
	        	$("#regtime").datebox('setValue',data.regtime);
	        	//$('#enable').combobox('select',"1");//下拉框默认选中
	        	$("#enable").combobox('setValue',data.enable);//下拉框默认选中
	        	if(data.filepath!="" && data.filepath!=null){
	        		$("#userfile").filebox('setValue',data.filepath);
	        		$("#yhzp").attr('src',"<%=path%>/user/downloadFile.do?id="+data.id);
	        	}else{
	        		$("#yhzp").attr('src',"<%=path%>/images/mrtx.jpg");
	        	}
        	$('#dd').dialog('open').dialog('setTitle', '修改用户');
        },
        error: function(e){
        	$.messager.alert('提示', '操作失败', 'error');
        }
    });
}
//重置查询条件
function reSet() {
	//清空文本框的值
	$("#s_username").textbox('setValue',"");
}
/*导出excel表单   */
function exportExcel(){
	var sname=$("#s_username").textbox('getValue');
	<%-- var url="<%=path%>/user/exportExcel.do?name='+encodeURI(encodeURI(sname))+'"; --%>
	<%-- <%=path%>/user/getAllUser.do?a='+sname+' --%>
	location.href="<%=path%>/user/exportExcel.do?name='+encodeURI(encodeURI(sname))+'";
	/* window.location.href= url ; */
}
//下载
function downloadFile(id){
	location.href="<%=path%>/user/downloadFile.do?id="+id;
}
//点击回车键进行搜索
document.onkeydown=function(event){ 
    var e = event || window.event || arguments.callee.caller.arguments[0]; 
    if(e && e.keyCode==13){
    	getTable();
    }
}
//批量删除
function deductSelect(){
	var ids="";
	var rows=$("#dg").datagrid("getChecked");
	for(var i in rows){
		if(ids==""){
			ids+="'"+rows[i].id+"'";
		}else{
			ids+=","+"'"+rows[i].id+"'";
		}
	}
	if(ids==""){
		$.messager.alert('提示', '请选择删除的数据!', 'info');
		return ;
	}
	//alert(ids);
	if(confirm("***确定删除***")){
		deleteUser(ids);
	}else{
		
	}
	
	//刷新页面
	getTable();
}
</script>
<body class="easyui-layout">

<div id="tb" style="padding: 10px;">
        <label>用户名:</label> <input id="s_username" name="s_username" class="easyui-textbox">
        <a href="javaScript:getTable()" class="easyui-linkbutton" id="idd" data-options="iconCls:'icon-search',plain:true" onclick="dologin()">查询</a>
        <a href="javascript:reSet();" class="easyui-linkbutton" iconCls="icon-clear">清空</a> 
		<a href="javaScript:add()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">增加</a>
		<a href="javascript:deductSelect()" class="easyui-linkbutton" iconCls="icon-ok">批量删除</a>
		<a href="javascript:exportExcel()" class="easyui-linkbutton" iconCls="icon-redo">导出EXCEL</a>
	</div>
	<div id="dg" style="height:100%"></div>
	<!-- 弹出框 -->
    <div id="dd" class="easyui-dialog" title="用户维护" style="width:450px;height:450px;"
	    data-options="iconCls:'icon-save',resizable:true,modal:true" closed="true"> 
	    <!-- form 表单-->
	    <!--  enctype="multipart/form-data"页面中有上传信息  -->
	    <form id="form" method="post" style="margin-left: 20px;margin-top: 20px;" enctype="multipart/form-data">
		        <input type="hidden" id="id" name="id"/>
		        
		        <div style="float: right; width: 150px;height: 180px;margin: 10px 20px 0px 0px;">
				  <img id="yhzp" alt="用户照片" src="<%=path%>/images/mrtx.jpg" style="width: 130px;height: 180px;">
				</div>
				<div style="height: 30px;">
				    <label for="username">姓名:</label> <input id="username" name="username" class="easyui-textbox" required="true"/>
				</div>
				<div style="height: 30px;">
				   <label for="password">密码:</label><input  id="password" name="password" class="easyui-textbox" required="true"/>
				</div>
				
				<div style="height: 30px;">
					<label for="email">邮箱:</label> <input id="email" name="email" class="easyui-textbox" data-options="prompt:'请输入邮箱',validType:'email'"/>
				</div>
				<div style="height: 30px;">
					<label for="name">实名:</label> <input id="name" name="name" class="easyui-textbox" required="true" data-options="prompt:'请与用户名一致',iconCls:'icon-man'">
				</div>
				<!-- <div style="height: 30px;">
					<label for="sex">性别:</label> 
					<select id="sex" name="sex" class="easyui-combobox" panelHeight="auto" style="width: 160px;">
						<option  value="1">男</option>
						<option  value="0">女</option>
					</select>
				</div> -->
				
				<div style="height: 30px;">
					<label >用户性别:</label>
					<input id="sex" type="radio" name="sex" class="easyui-validatebox" value="1" ><label>男</label></input>
					<input id="sex" type="radio" name="sex" class="easyui-validatebox" value="0" ><label>女</label></input>
				</div>	
				
				<div style="height: 30px;">
					<label for="qq">QQ:</label> <input id="qq" name="qq" class="easyui-textbox" required="true">
				</div>
				
				<div style="height: 30px;">
					<label for="weixin">微信:</label> <input id="weixin" name="weixin" class="easyui-textbox">
				</div>
 				<div style="height: 30px;font-size: 8px;">
 					<label for="regtime">时间:</label> <input id="regtime" name="regtime" class="easyui-datebox"> 
 				</div>
				<div style="height: 30px;float: left;margin: 0px 100px 0px 0px;">
					<label>是否启用:</label>
					<select id="enable" name="enable" class="easyui-combobox" panelHeight="auto" >
						<option  value="1">已启用</option>
						<option  value="0">未启用</option>
					</select>
				</div>
				<div style="height: 30px;float: left;">
					<label>用户照片:</label>
					<input name="userfile" size="44" class="easyui-filebox" data-options="prompt:'图片...'" >
				</div>
			</form>
			<div style="height: 30px;float: right;margin: 40px 150px 0px 0px;">
				<a href="javascript:submitForm()" class="easyui-linkbutton" iconCls="icon-save" >保存</a>
				<a href="javascript:dialogClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
	</div>
	
	<!-- 详细信息对话框 -->
		<div id="infoDialog" class="easyui-dialog" style="width: 450px; height: 400px; padding: 30px 20px" closed="true">
			<form id="infoForm" >
				<input type="hidden" id="id" name="id"/>
				<div  style="float: left;">
					<div style="height: 30px;">
						<label>用户姓名:</label> <span id="tname"></span>
					</div>
					<div style="height: 30px;">
						<label>用户性别:</label><span id="tsex"></span>
					</div>
					<div style="height: 30px;">
						<label>入职时间:</label><span id="tregtime"></span>
					</div>
					<div style="height: 30px;">
						<label>Email:&nbsp;&nbsp;&nbsp;&nbsp;</label><span id="temail"></span> 
					</div>
					<div style="height: 30px;">
					   <label>用户  QQ:</label> <span id="tqq"></span>
				    </div>
				</div>
				<div style="float: right; width: 130px;height: 180px;">
				  <img id="tyhzp" alt="用户照片" src="<%=path%>/images/mrtx.jpg" style="width: 130px;height: 180px;">
				</div>
				<div style="height: 30px;float: left;margin: 0px 130px 0px 0px;">
					<label>用户微信:</label> <span id="tweixin"></span>
				</div>
				<div style="height: 30px;float: left;margin: 0px 130px 0px 0px;">
					<label>是否启用:</label> <span id="tenable"></span>
				</div>
			</form>
		</div>
	
   <div id="roleSelectDialog" class="easyui-dialog" style="width:400px;height:100px;" closed="true">
			<input  id="userId" name="userId" type="hidden"/>
			<input id="roleSelect" name="roleSelect"/>
			<input type="button" value="保存" iconCls="icon-save" onclick="saveUserRole()"/>
		</div>
</body>
</html>