<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/saturn.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/testCode.js"></script>
<title>登录页面</title>
<script type="text/javascript">
	var code = __getTestCode();

	function login() {
		var testCode = $('#testCode').val();
		
		if (testCode.toLowerCase() != code.toLowerCase()) {
			//alert('验证码不正确');
			$.messager.alert('提示','验证码不正确','info');
			$('#testCode').focus();
			return;
		}
		
		$('#loginForm').submit();
	}
	
	function reload() {
		code = __getTestCode();
		$('#testCodeImage').attr("src", "<%=request.getContextPath()%>/app/system/testcode/test.do?code=" + code);
		return false;
	}
	
	$(function() {
		code = __getTestCode();
		$('#testCodeImage').attr("src", "<%=request.getContextPath()%>/app/system/testcode/test.do?code=" + code);
		
		$('#testCode').val(code);
	});
	
</script>
</head>
<body
	background="<%=request.getContextPath()%>/app/themes/saturn/images/saturn/background.png">
	<div class="login_img">
		<div class="login_text">
			<form id="loginForm" name="form1" method="post"
				action="<%=request.getContextPath()%>/app/auth/user/login.do">
				用户名： <input name="id" type="text" class="login_input" value="system" />
				<br /> <br /> 密&nbsp;&nbsp;码： <input name="password"
					type="password" class="login_input" value="111111" /><br /> <br />
				验证码： <input id="testCode" name="testCode" type="text"
					class="login_input" value="" /><br /> <br /> <input
					name="Submit" type="submit" class="login_ok"
					onclick="return login();" value="登录" /> <img id="testCodeImage"
					alt="验证码" onclick="reload()" style="cursor: hand">
			</form>
		</div>
	</div>
</body>
</html>