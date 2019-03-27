<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%String path=request.getContextPath(); %>
    
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

</script>
<body>
	<div id="cc" class="easyui-layout" style="width: 800px; height: 400px;">
		<div data-options="region:'west'" style="width: 250px;">
			<ul id="menutree" class="easyui-tree"></ul>
		</div>
		<div data-options="region:'center'">
			<form id="addRoleForm" method="post">
				<div style="height: 30px;">
					<label>ID主键值:</label> <input id="id" name="id"
						class="easyui-textbox" editable="false">
				</div>
				<div style="height: 30px;">
					<label>菜单名称:</label> <input id="name" name="name"
						class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>URL路径:</label> <input id="url" name="url"
						class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>菜单图片:</label> <input id="iconcls" name="iconcls"
						class="easyui-textbox">
				</div>
				<div style="height: 30px;">
					<label>是否启用:</label> <select id="enable" name="enable"
						class="easyui-combobox">
						<option value="1">启用</option>
						<option value="0">禁用</option>
					</select>
				</div>
				<div style="height: 30px;">
					<a id="btn" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-save'">保存</a>
				</div>
			</form>
		</div>
	</div>

</body>
</html>