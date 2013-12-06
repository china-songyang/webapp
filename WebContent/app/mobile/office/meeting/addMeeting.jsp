<%@page import="com.saturn.app.utils.DateUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加信息</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/panel.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/combo.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/combobox.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/datagrid.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/pagination.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/linkbutton.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/saturn.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/formValidator/validator.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/easyui-lang-zh_CN.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/formValidator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/formValidatorRegex.js"></script>

<%@ include file="/app/includes/kindEditor.jsp" %>
<script type="text/javascript">
	function add() {
		$('#addForm').submit();
	}
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="添加会议信息" icon="icon-add-form"
		collapsible="true" style="padding: 10px;">
		<form id="addForm" name="addForm"
			action="<%=request.getContextPath()%>/app/mobile/meeting/addMeeting.action"
			method="post">
			<table class="table-form">
				
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>会议标题:</td>
					<td><input id="title" name="title" type="text"></input></td>
					<td><div id="titleTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>会议内容:</td>
					<td><textarea name="text" id="text" style="width:400px;height:100px;"></textarea></td>
					<td><div id="textTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>会议时间:</td>
					<td><input id="time" name="time" type="text"></input></td>
					<td><div id="timeTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>会议地点:</td>
					<td><input id="address" name="address" type="text"></input></td>
					<td><div id="addressTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>发文单位:</td>
					<td><input id="unit" name="unit" type="text"></input></td>
					<td><div id="unitTip"></div></td>
				</tr>
				
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>发布者:</td>
					<td><input id="userId" name="userId" type="text"></input></td>
					<td><div id="userIdTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>状态:</td>
					<td><select id="state" class="easyui-combobox"
						name="state" url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=visible" valueField="id"
						textField="text" editable="false"></select></td>
					<td><div id="passwordTip"></div></td>
				</tr>
				<tr>
					<td colspan="3">
						<div style="padding: 10px;">
							<a href="#" onclick="add()" class="easyui-linkbutton"
								iconCls="icon-add">添加</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
						</div></td>
				</tr>
			</table>
			<input id="stateName" type="hidden" name="stateName" type="text" value="显示"></input>
			<input id="createTime" type="hidden" name="createTime" type="text" value="<%=DateUtils.getSystemTime()%>"></input>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "addForm"
		});

		$("#title").formValidator({
			onfocus : "标题不能为空,不超过100个字符！"
		}).inputValidator({
			min : 1,
			max : 100
		});

		$("#time").formValidator({
			onfocus : "会议时间不能为空"
		}).inputValidator({
			min : 1,
			max : 100
		});
		
		$("#address").formValidator({
			onfocus : "会议地点不能为空"
		});
		$("#userId").formValidator({
			onfocus : "发布者不能为空"
		});
	});
</script>
</html>