<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function edit() {
		$('#editForm').submit();
	}
	
	$(function() {
		$('#old').focus();
		
		<%
		Object result = request.getParameter("result");
		if (result != null) {
		%>
			$.messager.show({
				title:'信息',
				msg:'<%=result%>',
				showType:'show'
			});
		<%
		}
		%>
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="修改密码" icon="icon-edit-form"
		collapsible="true" style="padding: 10px;">

		<form id="editForm"
			action="<%=request.getContextPath()%>/app/auth/user/changePassword.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>旧密码:</td>
					<td><input id="old" name="old" type="password"></input></td>
					<td>
						<div id="oldTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>新密码:</td>
					<td><input id="newP" name="newP" type="password"></input></td>
					<td>
						<div id="newPTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>再次输入:</td>
					<td><input id="newP2" name="newP2" type="password"></input></td>
					<td>
						<div id="newP2Tip"></div>
					</td>
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
			<input id="id" name="id" type="hidden" value="${authUser.id}"></input>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "editForm"
		});

		$("#old").formValidator({
			onfocus : "密码位数在6到12之间"
		}).inputValidator({
			min : 6,
			max : 12
		});
		
		$("#newP").formValidator({
			onfocus : "密码位数在6到12之间"
		}).inputValidator({
			min : 6,
			max : 12
		});
		
		$("#newP2").formValidator({
			onfocus : "密码位数在6到12之间"
		}).inputValidator({
			min : 6,
			max : 12
		}).functionValidator({
			fun : function() {
				var newP = $('#newP').val();
				var newP2 = $('#newP2').val();
				
				this.isvalid = (newP == newP2);
			},
			onerror : "两次密码不一致"
		});
	});
</script>
</html>