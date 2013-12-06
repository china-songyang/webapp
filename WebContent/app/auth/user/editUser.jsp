<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function edit() {
		$('#editForm').submit();
	}
	
	$(function() {
		$('#name').focus();
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="修改用户信息"
		icon="icon-edit-form" collapsible="true" style="padding: 10px;">

		<form id="editForm"
			action="<%=request.getContextPath()%>/app/auth/user/updateUser.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right">登录ID:</td>
					<td><input id="id" name="id" type="text" value="${user.id}"
						readonly="readonly"></input></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>姓名:</td>
					<td><input id="name" name="name" type="text"
						value="${user.name}"></input></td>
					<td>
						<div id="nameTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>等级:</td>
					<td><select id="level" class="easyui-combobox" name="level"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=user.level"
						valueField="id" textField="text" editable="false " value="${user.level}"></select></td>
				</tr>
				<tr>
					<td style="text-align: right">邮箱:</td>
					<td><input id="email" name="email" type="text"
						value="${user.email}"></input></td>
					<td>
						<div id="emailTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right">手机号:</td>
					<td><input id="phone" name="phone" type="text"
						value="${user.phone}"></input></td>
					<td>
						<div id="phoneTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right">办公电话:</td>
					<td><input id="tel" name="tel" type="text" value="${user.tel}"></input></td>
					<td><div id="telTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">传真:</td>
					<td><input id="fax" name="fax" type="text" value="${user.fax}"></input></td>
					<td><div id="faxTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">职务:</td>
					<td><input id="post" name="post" type="text" value="${user.post}"></input></td>
					<td><div id="postTip"></div></td>
				</tr>
				<tr>
					<td colspan="3">
						<div style="padding: 10px;">
							<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
								onclick="edit()">确定</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
						</div>
					</td>
				</tr>
			</table>
			<input id="password" name="password" type="hidden"
				value="${user.password}"></input>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "editForm"
		});

		$("#id").formValidator({
			onfocus : "标识由数字、字母或者下划线组成，例如：admin"
		}).regexValidator({
			regexp : "loginId"
		});

		$("#name").formValidator({
			onfocus : "用户姓名不能为空,不超过10个字符！"
		}).inputValidator({
			min : 1,
			max : 10
		});

		$("#email").formValidator({
			empty : true,
			onfocus : "请正确填写邮箱，例如：some@163.com"
		}).regexValidator({
			regexp : "email"
		}).inputValidator({
			max : 100,
			onerror : "不超过100个字符"
		});

		$("#phone").formValidator({
			empty : true,
			onfocus : "请正确填写电话(11位)，例如：13566969636"
		}).regexValidator({
			regexp : "phone"
		}).inputValidator({
			max : 100,
			onerror : "不超过100个字符"
		});
	});
</script>
</html>