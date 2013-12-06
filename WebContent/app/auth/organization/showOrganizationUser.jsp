<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门用户信息</title>
<%@ include file="/app/includes/header.jsp"%>

<script type="text/javascript">
		$(function() {
			$('#organizationUserTable').treegrid({
				title : '部门包含用户列表',
				iconCls : 'icon-datalist',
				nowrap : false,
				striped : true, //数据条纹显示
				collapsible : true,
				singleSelect : false,//只能选一行
				url : '<%=request.getContextPath()%>/app/auth/organization/listOrganizationUser.action?organizationId=<%=request.getParameter("id")%>',
				sortName : 'id',
				sortOrder : 'desc',
				remoteSort : true,
				idField : 'id',//唯一标识列
				frozenColumns : [ [ {//不可被删除的列
					field : 'ck',
					checkbox : true
				}, {
					title : '标识',
					field : 'id',
					width : 80,
					sortable : true
				} ] ],
				columns : [ [ {
					field : 'name',
					title : '名称',
					width : 120,
					sortable : true
				}, {
					field : 'description',
					title : '描述',
					width : 240,
					sortable : true
				} , {
					field : '_parentId',
					title : '父资源',
					width : 140
				} ] ],
				pagination : true,
				rownumbers : true,
				toolbar : [{
					id : 'btndelete',
					text : '删除',
					iconCls : 'icon-remove',
					handler : function() {
						var rows = $('#organizationUserTable').treegrid('getSelections');
						if (rows.length == 0) {
							$.messager.alert('提示','请选择删除项','info');
							return;
						} 
						
						var ids = [];
						for(var i=0;i<rows.length;i++){
							ids.push(rows[i].id);
						}

						$.messager.confirm('确认删除项', '确认删除该选项', function(result){
							if (result){
								window.location.href='<%=request.getContextPath()%>/app/auth/organization/deleteOrganizationUser.action?id=<%=request.getParameter("id")%>&ids='+ids.join('__');
							}
						});
						return false;//决绝IE6的bug
					}
				}, '-', {
					id : 'btnback',
					text : '返回',
					iconCls : 'icon-back',
					handler : function() {
						window.location.href='<%=request.getContextPath()%>/app/auth/organization/showOrganizations.jsp';
						return false;//决绝IE6的bug
					}
				} ]
			});
			
			$('#organizationNotHaveUserTable').datagrid({
				title : '部门可添加用户列表',
				iconCls : 'icon-datalist',
				nowrap : false,
				striped : true, //数据条纹显示
				collapsible : true,
				singleSelect : false,//只能选一行
				url : '<%=request.getContextPath()%>/app/auth/organization/listUserNotInOrganization.action?id=<%=request.getParameter("id")%>',
				sortName : 'id',
				sortOrder : 'desc',
				remoteSort : true,
				idField : 'id',//唯一标识列
				frozenColumns : [ [ {//不可被删除的列
					field : 'ck',
					checkbox : true
				}, {
					title : '标识',
					field : 'id',
					width : 80,
					sortable : true
				} ] ],
				columns : [ [ {
					field : 'name',
					title : '名称',
					width : 120,
					sortable : true
				}, {
					field : 'description',
					title : '描述',
					width : 240,
					sortable : true
				} ] ],
				pagination : true,
				rownumbers : true,
				toolbar : [ {
					id : 'btnadd',
					text : '添加',
					iconCls : 'icon-add',
					handler : function() {
						var rows = $('#organizationNotHaveUserTable').datagrid('getSelections');
						if (rows.length == 0) {
							$.messager.alert('提示','请选择添加项','info');
							return;
						} 
						
						var ids = [];
						for(var i=0;i<rows.length;i++){
							ids.push(rows[i].id);
						}

						$.messager.confirm('确认添加项', '确认添加该选项', function(result){
							if (result){
								window.location.href='<%=request.getContextPath()%>/app/auth/organization/addOrganizationUser.action?id=<%=request.getParameter("id")%>&ids='+ids.join('__');
							}
						});
						return false;//决绝IE6的bug
					}
				}, '-', {
					id : 'btnback',
					text : '返回',
					iconCls : 'icon-back',
					handler : function() {
						window.location.href='<%=request.getContextPath()%>/app/auth/organization/showOrganizations.jsp';
						return false;//决绝IE6的bug
					}
				}]
			});
		});
	</script>
</head>
<body>
	<table id="organizationUserTable"></table>
	<table id="organizationNotHaveUserTable"></table>
</body>
</html>




