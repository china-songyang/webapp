<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网站目录信息</title>
<%@ include file="/app/includes/header.jsp"%>

<script type="text/javascript">
		$(function() {
			$('#hasShow').combobox({
				onSelect : function(record){
					queryVO();
			    }
			});
			
			$('#mode').combobox({
				onSelect : function(record){
					queryVO();
			    }
			});
			
			$('#queryTable').treegrid({
				title : '网站目录列表',
				iconCls : 'icon-datalist',
				nowrap : false,
				striped : true, //数据条纹显示
				collapsible : true,
				singleSelect : false,//只能选一行
				url : '<%=request.getContextPath()%>/app/website/content/list.action',
				idField : 'id',//唯一标识列
				treeField:'name',
				remoteSort : true,
				frozenColumns : [ [ {//不可被删除的列
					field : 'ck',
					checkbox : true
				}, {
					title : '标识',
					field : 'id',
					width : 150,
					sortable : true
				} ] ],
				columns : [ [ {
					field : 'name',
					title : '名称',
					width : 200
				}, {
					field : 'english',
					title : '英文名称',
					width : 100
				}, {
					field : 'path',
					title : '路径',
					width : 240
				}, {
					field : 'hasShowName',
					title : '显示',
					width : 40,
					formatter : function(value, rec) {
						return '<span><a href="<%=request.getContextPath()%>/app/website/content/show.action?show=' + rec.id + '">' + rec.hasShowName +'</a>';
					}
				}, {
					field : 'modeName',
					title : '模式',
					width : 40
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
				//pagination : true,
				rownumbers : true,
				animate:true,
				toolbar : [ {
					id : 'btnadd',
					text : '添加',
					iconCls : 'icon-add',
					handler : function() {
						var rows = $('#queryTable').treegrid('getSelections');
						if (rows.length > 1) {
							$.messager.alert('提示','最多选择一项','info');
							return;
						}
						
						if (rows.length == 0) {
							window.location.href='<%=request.getContextPath()%>/app/website/content/add.jsp?parentId=';
						} else {
							window.location.href='<%=request.getContextPath()%>/app/website/content/add.jsp?parentId='+rows[0].id;
						}
						return false;//解决IE6的不跳转的bug
					}
				}, {
					id : 'btnedit',
					text : '编辑',
					iconCls : 'icon-edit',
					handler : function() {
						var rows = $('#queryTable').treegrid('getSelections');
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
						var rows = $('#queryTable').treegrid('getSelections');
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
								window.location.href='<%=request.getContextPath()%>/app/website/content/delete.action?ids='+ids.join('__');
							}
						});
						return false;
					}
				}, {
					id : 'btnChange',
					text : '位置互换',
					iconCls : 'icon-reload',
					handler : function() {
						var rows = $('#queryTable').treegrid('getSelections');
						if (rows.length != 2) {
							$.messager.alert('提示','请选择2个互换项','info');
							return;
						} 
						
						var first = rows[0];
						var second = rows[1];
						
						if (first._parentId != second._parentId) {
							$.messager.alert('提示','2个互换项必须是同一级别','info');
							return;
						}
						
						$.messager.confirm('确认互换项', '确认互换该选项', function(result){
							if (result){
								window.location.href='<%=request.getContextPath()%>/app/website/content/change.action?first='+first.id+'&second='+second.id;
							}
						});
						return false;
					}
				}, {
					id : 'btnToList',
					text : '列表显示',
					iconCls : 'icon-redo',
					handler : function() {
						window.location.href='<%=request.getContextPath()%>/app/website/content/show.jsp';
						return false;//决绝IE6的bug
					}
				}, '-']
			});
		});
		
		function queryVO() {
			$('#queryTable').treegrid({
			queryParams : {
				id : $('#id').val(),
				name : $('#name').val(),
				english : $('#english').val(),
				path : $('#path').val(),
				hasShow : $('#hasShow').combobox('getValue'),
				mode : $('#mode').combobox('getValue')
			}});
			
			$('#queryTable').treegrid("load");
		}
		
		function clearQueryForm() {
			$('#queryForm').form('clear');
		}
		
		function deleteVO(id){
			$.messager.confirm('确认删除项', '确认删除该选项', function(result){
				if (result){
					window.location.href='<%=request.getContextPath()%>/app/website/content/delete.action?ids=' + id;
				}
			});
			return false;
		}
		function editVO(id){
			window.location.href='<%=request.getContextPath()%>/app/website/content/query.action?id='+ id;
			return false;
		}
	</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="查询条件"
		icon="icon-query-form" collapsible="true" style="padding: 10px;">

		<form id="queryForm" method="post">
			<table>
				<tr align="right">
					<td>标识:</td>
					<td><input id="id" name="id" type="text"></input></td>
					<td>名称:</td>
					<td><input id="name" name="name" type="text"></input></td>
					<td>英文名称:</td>
					<td><input id="english" name="english" type="text"></input></td>
					<td>路径:</td>
					<td><input id="path" name="path" type="text"></input></td>
				</tr>
				<tr>
					<td>是否显示:</td>
					<td><select id="hasShow" class="easyui-combobox"
						name="hasShow"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=visible"
						valueField="id" textField="text" mode="remote"></select></td>
					<td>模式:</td>
					<td><select id="mode" class="easyui-combobox" name="mode"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=content.mode"
						valueField="id" textField="text" mode="remote"></select></td>
				</tr>
			</table>
			<div style="padding: 10px;">
				<a href="#" class="easyui-linkbutton" onclick="queryVO();"
					iconCls="icon-search">确定</a> <a href="#" class="easyui-linkbutton"
					onclick="clearQueryForm();" iconCls="icon-cancel">取消</a>
			</div>
		</form>
	</div>
	<table id="queryTable"></table>
</body>
</html>




