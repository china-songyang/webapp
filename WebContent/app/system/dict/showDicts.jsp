<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据字典信息</title>
<%@ include file="/app/includes/header.jsp"%>

<script type="text/javascript">
		$(function() {
			$('#type').combobox({
				width : 180,
				onSelect:function(record){
					queryVO();
	            }
			});
			
			$('#dictTable').datagrid({
				title : '数据字典列表',
				iconCls : 'icon-save',
				nowrap : false,
				striped : true, //数据条纹显示
				collapsible : true,
				singleSelect : false,//只能选一行
				url : '<%=request.getContextPath()%>/app/system/dict/listDicts.action',
				sortName : 'id',
				sortOrder : 'desc',
				remoteSort : true,
				idField : 'id',
				frozenColumns : [ [ {//不可被删除的列
					field : 'ck',
					checkbox : true
				}, {
					title : '标识',
					field : 'key',
					width : 150,
					sortable : true
				} ] ],
				columns : [ [ {
					field : 'value',
					title : '值',
					width : 120,
					sortable : true
				}, {
					field : 'pinyin',
					title : '拼音',
					width : 120,
					sortable : true
				}, {
					field : 'type',
					title : '类型',
					width : 240,
					sortable : true
				}] ],
				pagination : true,
				rownumbers : true,
				toolbar : [ {
					id : 'btnadd',
					text : '添加',
					iconCls : 'icon-add',
					handler : function() {
					window.location.href='<%=request.getContextPath()%>/app/system/dict/addDict.jsp';
					return false;//解决IE6的不跳转的bug
					}
				}, {
					id : 'btnedit',
					text : '编辑',
					iconCls : 'icon-ok',
					handler : function() {
						var rows = $('#dictTable').datagrid('getSelections');
						if (rows.length == 0) {
							$.messager.alert('提示','请选择修改项','info');
							return;
						} else if (rows.length > 1) {
							$.messager.alert('提示','只能选择一项','info');
							return;
						}
						
						window.location.href='<%=request.getContextPath()%>/app/system/dict/queryDict.action?id='+rows[0].id;
						return false;
					}
				},{
					id : 'btndelete',
					text : '删除',
					iconCls : 'icon-remove',
					handler : function() {
						var rows = $('#dictTable').datagrid('getSelections');
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
								window.location.href='<%=request.getContextPath()%>/app/system/dict/deleteDict.action?ids='+ids.join('__');
							}
						});
						return false;
					}
				}, '-', {
					id : 'btnedit',
					text : '位置互换',
					iconCls : 'icon-reload',
					handler : function() {
						var rows = $('#dictTable').datagrid('getSelections');
						if (rows.length != 2) {
							$.messager.alert('提示','请选择2个互换项','info');
							return;
						} 
						
						var first = rows[0];
						var second = rows[1];
						
						$.messager.confirm('确认互换项', '确认互换该选项', function(result){
							if (result){
								$.ajax({
									url : '<%=request.getContextPath()%>/app/system/dict/change.action',
									type : 'post',         
									dataType : 'json',     
									data : {
										type : $('#type').combobox('getValue'),
										first : first.id,
										second : second.id
									},
									success : function(data) {
										if (data) {
											$.messager.show({
												title:'信息',
												msg:'保存成功',
												showType:'show'
											});
											
											queryVO();
										}
									} 
								});
							}
						});
						return false;
					}
				} ]
			});
		});
		
		function queryVO() {
			$('#dictTable').datagrid({
				queryParams : {
					key : $('#key').val(),
					value : $('#value').val(),
					pinyin : $('#pinyin').val(),
					type : $('#type').combobox('getValue')
				}
			});
			
			$('#dictTable').datagrid("load");
		}
		
		function clearVOQueryForm() {
			$('#dictQueryForm').form('clear');
		}
	</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="查询条件" icon="icon-save"
		collapsible="true" style="padding: 10px;">

		<form id="dictQueryForm" method="post">
			<label for="key">标识:</label> <input id="key" name="key" type="text"></input>
			<label for="value">值:</label> <input id="value" name="value"
				type="text"></input> <label for="pinyin">拼音:</label> <input
				id="pinyin" name="pinyin" type="text"></input> <label for="type">类型:</label>
			<select id="type" class="easyui-combobox" name="type"
				url="<%=request.getContextPath()%>/app/system/dict/queryDictType.action"
				valueField="id" textField="text" mode="remote"
				value="<%=request.getParameter("type") == null ? "" : request.getParameter("type")%>"></select>
			<div style="padding: 10px;">
				<a href="#" class="easyui-linkbutton" onclick="queryVO();"
					iconCls="icon-search">确定</a> <a href="#" class="easyui-linkbutton"
					onclick="clearVOQueryForm();" iconCls="icon-cancel">取消</a>
			</div>
		</form>
	</div>
	<table id="dictTable"></table>
</body>
</html>




