<%@page import="com.saturn.app.utils.DateUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加网站留言</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function add() {
		var typeValue = $('#cid').combogrid('getValue');
		
		if (typeValue == "") {
			alert("目录标识不能为空!");
		} else {
			$('#addForm').submit();
		}
	}
	
	$(function() {
		$('#sendText').focus();
		
		$('#state').combobox({
			width : 250,
			value : "message.state.true",
			onSelect : function(record){
				$('#stateName').val(record.text);
		    }
		});
		
		$('#hasShow').combobox({
			width : 250,
			value : "visible.false",
			onSelect : function(record){
				$('#hasShowName').val(record.text);
		    }
		});
		
		$('#cid').combogrid({
			width : 250,
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
			]]
		});
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="添加网站留言"
		icon="icon-add-form" collapsible="true" style="padding: 10px;">
		<form id="addForm"
			action="<%=request.getContextPath()%>/app/website/message/add.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>目录标识:</td>
					<td><select id="cid" name="cid"></select></td>
					<td><div id="cidTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>类型:</td>
					<td>
					<td><input id="type" name="type" type="text""></input></td>
					</td>
					<td><div id="typeTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>留言内容:</td>
					<td><textarea id="sendText" name="sendText" cols="50" rows="5"></textarea></td>
					<td><div id="sendTextTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">留言电话:</td>
					<td><input id="sendPhone" name="sendPhone" type="text"></input></td>
					<td><div id="sendPhoneTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">留言邮箱:</td>
					<td><input id="sendEmail" name="sendEmail" type="text"></input></td>
					<td><div id="sendEmailTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">留言人:</td>
					<td><input id="sendName" name="sendName" type="text"></input></td>
					<td><div id="sendNameTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>回复内容:</td>
					<td><textarea id="receiveText" name="receiveText" cols="50"
							rows="5"></textarea></td>
					<td><div id="receiveTextTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>状态:</td>
					<td><select id="state" class="easyui-combobox" name="state"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=message.state"
						valueField="id" textField="text" editable="false"></select></input></td>
					<td><div id="stateTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>显示:</td>
					<td><select id="hasShow" class="easyui-combobox"
						name="hasShow"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=visible"
						valueField="id" textField="text" editable="false"></select></td>
					<td><div id="hasShowTip"></div></td>
				</tr>
				<tr>
					<td colspan="3">
						<div style="padding: 10px;">
							<a href="#" onclick="add()" class="easyui-linkbutton"
								iconCls="icon-add">添加</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
						</div>
					</td>
				</tr>
			</table>
			<input id="stateName" type="hidden" name="stateName" type="text"
				value="已回复"></input> <input id="hasShowName" type="hidden"
				name="hasShowName" type="text" value="隐藏"></input> <input
				id="sendTime" type="hidden" name="sendTime" type="text"
				value="<%=DateUtils.getSystemTime()%>"></input> <input
				id="receiveTime" type="hidden" name="receiveTime" type="text"
				value="<%=DateUtils.getSystemTime()%>"></input> <input
				id="receiveOperater" type="hidden" name="receiveOperater"
				type="text" value="${authUser.id}"></input> <input
				id="receiveOperaterName" type="hidden" name="receiveOperaterName"
				type="text" value="${authUser.name}"></input>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "addForm"
		});
		
		$("#sendText").formValidator({
			onfocus : "留言内容不超过500字符"
		}).inputValidator({
			min : 1,
			max : 500
		});
		
		$("#sendName").formValidator({
			empty : true,
			onfocus : "用户姓名不能为空,不超过50个字符！"
		}).inputValidator({
			min : 1,
			max : 50
		});
		
		$("#sendEmail").formValidator({
			empty : true,
			onfocus : "请正确填写邮箱，例如：some@163.com"
		}).regexValidator({
			regexp : "email"
		}).inputValidator({
			max : 100,
			onerror : "不超过100个字符"
		});

		$("#sendPhone").formValidator({
			empty : true,
			onfocus : "请正确填写电话(11位)，例如：13566969636"
		}).regexValidator({
			regexp : "phone"
		}).inputValidator({
			max : 100,
			onerror : "不超过100个字符"
		});
		
		$("#receiveText").formValidator({
			onfocus : "回复内容不超过500字符"
		}).inputValidator({
			min : 1,
			max : 500
		});
	});
</script>
</html>






