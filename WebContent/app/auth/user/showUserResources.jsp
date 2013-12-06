<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源信息</title>
<%@ include file="/app/includes/header.jsp"%>

<script type="text/javascript">
		$(function() {
			$('#resourceTable').treegrid({
				title : '资源列表',
				iconCls : 'icon-datalist',
				nowrap : false,
				striped : true, //数据条纹显示
				collapsible : true,
				singleSelect : false,//只能选一行
				url : '<%=request.getContextPath()%>/app/auth/user/listUserResource.action?userId='+$('#id').val(),
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
						window.location.href='<%=request.getContextPath()%>/app/auth/user/updateUserResource.action?checkedIds='+ checkedIds + '&userId=' +$('#id').val();
					}
				}, '-', {
					id : 'btnback',
					text : '返回',
					iconCls : 'icon-back',
					handler : function() {
						window.location.href='<%=request.getContextPath()%>/app/auth/user/showUsers.jsp';
						return false;//决绝IE6的bug
					}
				}],
				onLoadSuccess: function(){
					var nodes = $('#resourceTable').treegrid('getChildren');
					for(var i=0; i < nodes.length; i++) {
						if (nodes[i].checked != null) {
							if (nodes[i].checked) {
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
	<div id="panel" class="easyui-panel" title="用户信息" icon="icon-save"
		collapsible="true" style="padding: 10px;">
		<label for="id">登录ID:</label> <input id="id" type="text" name="id"
			value="${user.id}" readonly="readonly"></input> <label for="name">姓名:</label>
		<input id="name" type="text" name="name" value="${user.name}"
			readonly="readonly"></input> <label for="phone">电话:</label> <input
			id="phone" name="phone" type="text" value="${user.phone}"
			readonly="readonly"></input>
	</div>
	<table id="resourceTable"></table>
	<input type="hidden" id="id" name="id" value=${user.id}></input>
</body>
</html>