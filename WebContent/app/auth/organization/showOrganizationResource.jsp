<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门资源信息</title>
<%@ include file="/app/includes/header.jsp"%>

<script type="text/javascript">
		$(function() {
			$('#resourceTable').treegrid({
				title : '部门资源列表',
				iconCls : 'icon-save',
				nowrap : false,
				striped : true, //数据条纹显示
				collapsible : true,
				singleSelect : false,//只能选一行
				url : '<%=request.getContextPath()%>/app/auth/organization/listOrganizationResource.action?organizationId='+$('#id').val(),
				idField : 'id',//唯一标识列
				treeField:'name',
				frozenColumns : [ [ {//不可被删除的列
					field : 'ck',
					checkbox : true
				}, {
					title : '标识',
					field : 'id',
					width : 140
				} ] ],
				columns : [ [ {
					field : 'name',
					title : '名称',
					width : 240
				}, {
					field : 'path',
					title : '路径',
					width : 200
				}, {
					field : '_parentId',
					title : '父资源',
					width : 240
				}  ] ],
				//pagination : true,
				rownumbers : true,
				animate:true,
				toolbar : [ {
					id : 'btnadd',
					text : '提交',
					iconCls : 'icon-add',
					handler : function() {
					
					var nodes = $('#resourceTable').treegrid('getSelections');
					var checkedIds = '';
					for(var i=0; i<nodes.length; i++){
						checkedIds += nodes[i].id +',';
					}
						window.location.href='<%=request.getContextPath()%>/app/auth/organization/updateOrganizationResource.action?checkedIds='+ checkedIds + '&organizationId=' +$('#id').val();
					}
				}, '-', {
					id : 'btnback',
					text : '返回',
					iconCls : 'icon-back',
					handler : function() {
						window.location.href='<%=request.getContextPath()%>/app/auth/organization/showOrganizations.jsp';
						return false;//决绝IE6的bug
					}
				}],
				onLoadSuccess : function() {
					var nodes = $('#resourceTable').treegrid('getChildren');
					for (var i = 0; i < nodes.length; i++) {
						if (nodes[i].checked != null) {
							if (nodes[i].checked != null) {
								$('#resourceTable').treegrid('select', nodes[i].id);
							}
						}

					}
				}
			});
		});
	</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="部门信息" icon="icon-save"
		collapsible="true" style="padding: 10px;">
		<label for="id">标识:</label> <input id="id" type="text" name="id"
			value="${organization.id}" readonly="readonly"></input> <label
			for="name">名称:</label> <input id="name" type="text" name="name"
			value="${organization.name}" readonly="readonly"></input> <label
			for="description">描述:</label> <input id="description"
			name="description" type="text" value="${organization.description}"
			readonly="readonly"></input>
	</div>
	<table id="resourceTable"></table>
	<input type="hidden" id="id" name="id" value="${organization.id}"></input>
</body>
</html>




