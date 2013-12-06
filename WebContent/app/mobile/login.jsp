<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>登录</title>
</head>
<body>
	<form id="loginForm" name="form1" method="post"
		action="<%=request.getContextPath()%>/mobile/user/login.do">
		用户名： <input name="id" type="text" class="login_input" value="" /> <br />
		<br /> 密&nbsp;&nbsp;码： <input name="password" type="password"
			class="login_input" value="" /><br /> <br /> <input name="Submit"
			type="submit" class="login_ok" onclick="return login();" value="登录" />
	</form>
</body>
</html>