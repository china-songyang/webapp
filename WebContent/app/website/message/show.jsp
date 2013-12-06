<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息信息</title>
<%@ include file="/app/includes/header.jsp"%>

<script type="text/javascript">
		$(function() {
			$('#state').combobox({
				onSelect:function(record){
					queryVO();
			    }
			});
			
			$('#type').combobox({
				onSelect:function(record){
					queryVO();
			    }
			});
			
			$('#hasShow').combobox({
				onSelect:function(record){
					queryVO();
			    }
			});
			
			$('#queryTable').datagrid({
				title : '消息列表',
				iconCls : 'icon-datalist',
				nowrap : false,
				striped : true, //数据条纹显示
				collapsible : true,
				singleSelect : false,//只能选一行
				url : '<%=request.getContextPath()%>/app/website/message/list.action',
				idField : 'id',//唯一标识列
				sortName : 'id',
				sortOrder : 'desc',
				remoteSort : true,
				frozenColumns : [ [ {//不可被删除的列
					field : 'ck',
					checkbox : true
				}, {
					field : 'id',
					title : '标识',
					width : 30,
					sortable : true
				} ] ],
				columns : [ [ {
					field : 'cid',
					title : '目录标识',
					width : 100,
					sortable : true
				},  {
					field : 'type',
					title : '类型',
					width : 60,
					sortable : true
				},  {
					field : 'sendText',
					title : '留言内容',
					width : 130,
					sortable : true
				}, {
					field : 'receiveText',
					title : '回复内容',
					width : 130,
					sortable : true
				},{
					field : 'sendPhone',
					title : '留言电话',
					width : 70,
					sortable : true
				}, {
					field : 'sendName',
					title : '留言人',
					width : 60,
					sortable : true
				}, {
					field : 'sendTime',
					title : '留言时间',
					width : 120,
					sortable : true
				}, {
					field : 'receiveTime',
					title : '回复时间',
					width : 120,
					sortable : true
				}, {
					field : 'receiveOperaterName',
					title : '回复人',
					width : 50,
					sortable : true
				},  {
					field : 'stateName',
					title : '状态',
					width : 50,
					sortable : true
				}, {
					field : 'hasShowName',
					title : '显示',
					width : 40,
					sortable : true,
					formatter : function(value, rec) {
						return '<span><a href="<%=request.getContextPath()%>/app/website/message/show.action?show=' + rec.id + '">' + rec.hasShowName +'</a>';
					}
				}, {
					field : 'opt',
					title : '操作',
					width : 70,
					align : 'center',
					rowspan : 2,	
					formatter : function(value, rec) {
						return '<span><a href="#" onclick="editVO(\'' + rec.id + '\');"><img src="<%=request.getContextPath()%>/app/themes/icons/edit.png" width="16" height="16" border="0" /></a>'+
						'&nbsp&nbsp<a href="#" onclick="deleteVO(\'' + rec.id + '\');"><img src="<%=request.getContextPath()%>/app/themes/icons/cancel.png" width="14" height="14" border="0" /></a></span>';
					}
				} ] ],
				pagination : true,
				rownumbers : true,
				toolbar : [ /*{
					id : 'btnadd',
					text : '添加',
					iconCls : 'icon-add',
					handler : function() {
						window.location.href='<%=request.getContextPath()%>/app/website/message/add.jsp';
						return false;//解决IE6的不跳转的bug
					}
				}, */{
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
								window.location.href='<%=request.getContextPath()%>/app/website/message/delete.action?ids='+ids.join('__');
							}
						});
						return false;
					}
				}, '-']
			});
			
			$('#cid').combogrid({
				panelWidth : 600,
				idField : 'id',
				textField : 'name',
				pagination : true,
				rownumbers : true,
				sortName : 'id',
				sortOrder : 'asc',
				remoteSort : true,
				url : '<%=request.getContextPath()%>/app/website/content/listRoot.action',
				columns : [[
					{field : 'id',title : '标识',width : 150, sortable : true},
					{field : 'name',title : '名称',width : 100, sortable : true},
					{field : 'hasShowName',title : '显示', width : 120, sortable : true}
				]],
				onSelect:function(record){
					queryVO();
			    }
			});
		});
		
		function queryVO() {
			$('#queryTable').datagrid({
				queryParams : {
					cid : $('#cid').combogrid('getValue'),
					sendText : $('#sendText').val(),
					sendPhone : $('#sendPhone').val(),
					sendTime : $('#sendTime').datebox('getValue'),
					sendName : $('#sendName').val(),
					receiveText : $('#receiveText').val(),
					receiveTime : $('#receiveTime').datebox('getValue'),
					receiveOperaterName : $('#receiveOperaterName').val(),
					hasShow : $('#hasShow').combobox('getValue'),
					state : $('#state').combobox('getValue'),
					type : $('#type').combobox('getValue')
			}});
			
			$('#queryTable').datagrid("load");
		}
		
		function clearQueryForm() {
			$('#queryForm').form('clear');
		}
		
		function deleteVO(id){
			$.messager.confirm('确认删除项', '确认删除该选项', function(result){
				if (result){
					window.location.href='<%=request.getContextPath()%>/app/website/message/delete.action?ids=' + id;
				}
			});
			return false;
		}
		function editVO(id){
			window.location.href='<%=request.getContextPath()%>/app/website/message/query.action?id='+ id;
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
					<td>留言时间:</td>
					<td><input id="sendTime" name="sendTime"
						class="easyui-datebox" type="text"></input></td>
					<td>留言内容:</td>
					<td><input id="sendText" name="sendText" type="text"></input></td>
					<td>留言电话:</td>
					<td><input id="sendPhone" name="sendPhone" type="text"></input></td>
					<td>留言人:</td>
					<td><input id="sendName" name="sendName" type="text"></input></td>
				</tr>
				<tr align="right">
					<td>回复时间:</td>
					<td><input id="receiveTime" name="receiveTime"
						class="easyui-datebox" type="text"></input></td>
					<td>回复内容:</td>
					<td><input id="receiveText" name="receiveText" type="text"></input></td>
					<td>回复人:</td>
					<td><input id="receiveOperaterName" name="receiveOperaterName"
						type="text"></input></td>
				</tr>
				<tr align="right">
					<td>目录标识:</td>
					<td><select id="cid" name="cid" type="text"></select></td>
					<td>类型:</td>
					<td align="left"><select id="type" class="easyui-combobox"
						name="type"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=website.message.type"
						valueField="id" textField="text" mode="remote"></select></td>
					<td>状态:</td>
					<td align="left"><select id="state" class="easyui-combobox"
						name="state"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=message.state"
						valueField="id" textField="text" mode="remote"></select></td>
					<td>是否显示:</td>
					<td align="left"><select id="hasShow" class="easyui-combobox"
						name="hasShow"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=visible"
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




