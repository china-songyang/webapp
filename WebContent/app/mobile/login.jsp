<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>��¼</title>
</head>
<body>
	<form id="loginForm" name="form1" method="post"
		action="<%=request.getContextPath()%>/mobile/user/login.do">
		�û����� <input name="id" type="text" class="login_input" value="" /> <br />
		<br /> ��&nbsp;&nbsp;�룺 <input name="password" type="password"
			class="login_input" value="" /><br /> <br /> <input name="Submit"
			type="submit" class="login_ok" onclick="return login();" value="��¼" />
	</form>
</body>
</html>