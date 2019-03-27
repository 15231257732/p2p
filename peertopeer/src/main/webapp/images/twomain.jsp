<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
String path=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>主页面</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css">
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path%>/js/highcharts.js"></script>
<script type="text/javascript" src="<%=path%>/js/exporting.js"></script>
</head>
<body>
	<div style="margin:20px 0;"></div>
	<div class="easyui-layout" style="width:100%;height:780px;">
		<div data-options="region:'north'" style="height:120px">
		</div>
		<div data-options="region:'south',split:true" style="height:100px;"></div>
		<!--左菜单  -->
		<div data-options="region:'west',split:true" title="菜单" style="width:260px;">
		<ul id="tt" class="easyui-tree">
			    <li>
					<span>Sub Folder</span>
					<ul>
						<li>
							<span>Sub Folder 1</span>
							<ul>
								<li><span><a href="<%=path%>/user/toList.do" target="main">用户管理</a></span></li>
								<li><span>File 12</span></li>
								<li><span>File 13</span></li>
							</ul>
						</li>
						<li><span>File 2</span></li>
						<li><span>File 3</span></li>
					</ul>
				 </li>
			    <li><span>File21</span></li>
			</ul>
		</div>
		<div
			data-options="region:'center',title:'详细信息列表',iconCls:'icon-ok'">
			<!--左菜单连接右表面  -->
			
			<iframe name="main" width="99%" height="99%" frameborder="no"
				border="0">
				
				
				
				</iframe>
		</div>
	</div>
</body>
</html>