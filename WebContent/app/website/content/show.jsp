<%@page import="com.saturn.website.Content"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网站目录信息</title>
<%@ include file="/app/includes/header.jsp"%>

<%
		String parentId = request.getParameter("parentId");
		String url = request.getContextPath() + "/app/website/content/listRoot.action";
		if (parentId != null && !"".equals(parentId)) {
			url = request.getContextPath() + "/app/website/content/listChildren.action?parentId="+parentId;
		}
	%>
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
			
			$('#queryTable').datagrid({
				title : '网站目录列表',
				iconCls : 'icon-datalist',
				nowrap : false,
				striped : true, //数据条纹显示
				collapsible : true,
				singleSelect : false,//只能选一行
				url : '<%=url%>',
				idField : 'id',//唯一标识列
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
					width : 200,
					sortable : true,
					formatter : function(value, rec) {
						return '<span><a href="<%=request.getContextPath()%>/app/website/content/show.jsp?parentId=' + rec.id + '">' + rec.name +'</a>';
					}
				}, {
					field : 'english',
					title : '英文名称',
					width : 100,
					sortable : true
				}, {
					field : 'path',
					title : '路径',
					width : 240,
					sortable : true
				}, {
					field : 'hasShowName',
					title : '显示',
					width : 40,
					sortable : true,
					formatter : function(value, rec) {
						return '<span><a href="<%=request.getContextPath()%>/app/website/content/show.action?show=' + rec.id + '">' + rec.hasShowName +'</a>';
					}
				}, {
					field : 'modeName',
					title : '模式',
					width : 40,
					sortable : true
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
				animate:true,
				toolbar : [ {
					id : 'btnadd',
					text : '添加',
					iconCls : 'icon-add',
					handler : function() {
						var rows = $('#queryTable').datagrid('getSelections');
						if (rows.length > 1) {
							$.messager.alert('提示','最多选择一项','info');
							return;
						}
						
						if (rows.length == 0) {
						<%
							if (parentId != null) {
						%>	
							window.location.href='<%=request.getContextPath()%>/app/website/content/add.jsp?parentId=<%=parentId%>';
						<%  
							} else {
						%>
							window.location.href='<%=request.getContextPath()%>/app/website/content/add.jsp?parentId=';
						<%
							}
						%>
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
						var rows = $('#queryTable').datagrid('getSelections');
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
								<%
									if (parentId != null) {
								%>
								window.location.href='<%=request.getContextPath()%>/app/website/content/change.action?parentId=<%=parentId%>&first='+first.id+'&second='+second.id;
								<%
									} else {
								%>
								window.location.href='<%=request.getContextPath()%>/app/website/content/change.action?first='+first.id+'&second='+second.id;
								<%
									}
								%>
							}
						});
						return false;
					}
				}, 
				/*{
					id : 'btnToTree',
					text : '树型显示',
					iconCls : 'icon-redo',
					handler : function() {
						window.location.href='<%=request.getContextPath()%>/app/website/content/showTree.jsp';
						return false;//决绝IE6的bug
					}
				}, */
				'-'
				<%
					if (parentId != null && !"".equals(parentId)) {
						Content content = Content.get(parentId);
						String pId = content.getParentId();
						String pName = content.getName();
						
						String backUrl = request.getContextPath() + "/app/website/content/show.jsp";
						if (pId != null) {
							backUrl = request.getContextPath() + "/app/website/content/show.jsp?parentId="+pId;
						}
				%>
				, {
					id : 'btnback',
					text : '<%=pName%>',
					iconCls : 'icon-back',
					handler : function() {
						window.location.href='<%=backUrl%>';
						return false;//决绝IE6的bug
					}
				}
				<%}%>
				]
			});
		});
		
		function queryVO() {
			$('#queryTable').datagrid({
			queryParams : {
				id : $('#id').val(),
				name : $('#name').val(),
				english : $('#english').val(),
				path : $('#path').val(),
				hasShow : $('#hasShow').combobox('getValue'),
				mode : $('#mode').combobox('getValue')
			}});
			
			$('#queryTable').datagrid("load");
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
				<tr align="right">
					<td>显示:</td>
					<td align="left"><select id="hasShow" class="easyui-combobox"
						name="hasShow"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=visible"
						valueField="id" textField="text" mode="remote"></select></td>
					<td>模式:</td>
					<td align="left"><select id="mode" class="easyui-combobox"
						name="mode"
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

