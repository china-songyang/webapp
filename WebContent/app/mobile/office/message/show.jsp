<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户信息</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	$(function() {
		$('#queryTable').datagrid({
			title : '信息列表',
			iconCls : 'icon-datalist',
			nowrap : false,
			striped : true, //数据条纹显示
			collapsible : true,
			singleSelect : false,//只能选一行
			url : '<%=request.getContextPath()%>/mobile/message/listMessage.action',
			queryParams:{
				type:1
			},
			sortName : 'id',
			sortOrder : 'desc',
			remoteSort : true,
			idField : 'id',//唯一标识列
			frozenColumns : [ [ {//不可被删除的列
				field : 'ck',
				checkbox : true
			}] ],
			columns : [ [ {
				field : 'title',
				title : '信息标题',
				width : 180,
				sortable : true
			}, {
				field : 'creatername',
				title : '创建者',
				width : 120,
				sortable : true
			}, {
				field : 'statename',
				title : '状态',
				width : 100,
				formatter : function(value, rec) {
					return '<span><a href="<%=request.getContextPath()%>/app/mobile/office/message/show.action?show=' + rec.id + '">' + rec.statename +'</a>';
				}
			},{
				field : 'levelname',
				title : '等级',
				width : 100	
			},{
				field : 'type',
				title : '类型',
				width : 150,
				hidden:true
			},{
				field : 'createtime',
				title : '创建时间',
				width : 150	
			}, {
				field : 'opt',
				title : '操作',
				width : 100,
				align : 'center',
				rowspan : 2,
				formatter : function(value, rec) {
						return '<span><a href="#" onclick="editVO(\'' + rec.id + '\');"><img src="<%=request.getContextPath()%>/app/themes/icons/edit.png" width="16" height="16" border="0" /></a>'+
						'&nbsp&nbsp<a href="#" onclick="deleteVO(\'' + rec.id + '\');"><img src="<%=request.getContextPath()%>/app/themes/icons/cancel.png" width="14" height="14" border="0" /></a></span>';
				}
			} ] ],
			pagination : true,
			rownumbers : true,
			toolbar : [ {
				id : 'btnadd',
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					window.location.href='<%=request.getContextPath()%>/app/mobile/office/message/add.jsp';
					return false;//解决IE6的不跳转的bug
				}
			}, {
				id : 'btnedit',
				text : '编辑',
				iconCls : 'icon-edit',
				handler : function() {
					var rows = $('#queryTable').datagrid('getSelections');
					if (rows.length == 0) {
						$.messager.alert('提示','请选择修改项','info');
						return;
					} else if (rows.length > 1) {
						$.messager.alert('提示','只能选择一项','info');
						return;
					}
					editVO(rows[0].id);
					return false;
				}
			},{
				id : 'btndelete',
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					var rows = $('#queryTable').datagrid('getSelections');
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
							window.location.href='<%=request.getContextPath()%>/app/mobile/office/message/deleteMessage.action?ids='+ids.join('__')+'&type=1';
						}
					});
					return false;
				}
			}, {
				id : 'btnaddz',
				text : '人员',
				iconCls : 'icon-redo',
				handler : function() {
					var rows = $('#queryTable').datagrid('getSelections');
					if (rows.length == 0) {
						$.messager.alert('提示','请选择修改项','info');
						return;
					} else if (rows.length > 1) {
						$.messager.alert('提示','只能选择一项','info');
						return;
					}
					window.location.href='<%=request.getContextPath()%>/app/mobile/message/QueryMsgUser.action?id='+rows[0].id+'&type='+rows[0].type;
					return false;//解决IE6的不跳转的bug
				}
			}, {
				id : 'btnaddz',
				text : '发送',
				iconCls : 'icon-redo',
				handler : function() {
					var rows = $('#queryTable').datagrid('getSelections');
					if (rows.length == 0) {
						$.messager.alert('提示','请选择修改项','info');
						return;
					} else if (rows.length > 1) {
						$.messager.alert('提示','只能选择一项','info');
						return;
					}
					window.location.href='<%=request.getContextPath()%>/app/mobile/message/sendMsgToOpenfire.action?id='+rows[0].id;
					return false;//解决IE6的不跳转的bug
				}
			}]
		});
	});
	
	function deleteVO(id){
		$.messager.confirm('确认删除项', '确认删除该选项', function(result){
			if (result){
				window.location.href='<%=request.getContextPath()%>/app/mobile/office/message/deleteMessage.action?ids=' + id +'&type=1';
			}
		});
		return false;
	}
	
	function editVO(id){
		var rows = $('#queryTable').datagrid('getSelections');
		window.location.href='<%=request.getContextPath()%>/app/mobile/office/message/queryMessage.action?id='+ id + '&type='+rows[0].type;
		return false;
	}
	
	function queryVO() {
		$('#queryTable').datagrid({
			queryParams : {
				title : $('#title').val(),
				statename : $('#statename').val(),
				creatername : $('#creatername').val(),
				createtime : $('#createtime').datebox('getValue')
			}});
		$('#queryTable').datagrid("load");
	}
	
	function clearQueryForm() {
		$('#queryForm').form('clear');
	}
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="查询条件"
		icon="icon-query-form" collapsible="true"
		style="padding: 10px;">

		<form id="queryForm" method="post">
			<label for="title">标题:</label> 
			<input id="title" type="text" name="title"></input>
			<label for="statename">状态名称:</label>
			<input id="statename" type="text" name="statename"></input>
			<label for="creatername">创建者 :</label>
			<input id="creatername" type="text" name="creatername"></input>
			<label for="createtime">创建时间:</label>
			<input id="createtime" class="easyui-datebox" type="text" name="createtime"></input>
			<div style="padding: 10px;" >
				<a href="#" class="easyui-linkbutton" onclick="queryVO();" iconCls="icon-search">确定</a>
				<a href="#" class="easyui-linkbutton" onclick="clearQueryForm();" iconCls="icon-cancel">取消</a>
			</div>
		</form>
	</div>
	<table id="queryTable"></table>
</body>
</html>