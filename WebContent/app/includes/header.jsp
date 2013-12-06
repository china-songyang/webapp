<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Expires" content="-1">


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/saturn.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/easyui-lang-zh_CN.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/formValidator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/formValidatorRegex.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/formValidator/validator.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/highcharts.js"></script>
<script type="text/javascript">
	<%
		Object __user = request.getSession().getAttribute("authUser");
		if (__user == null && request.getRequestURI().indexOf("/app/") >= 0) {
	%>
	
	$(function() {
		/*$.messager.show({
			title:'信息',
			msg:'用户会话过期，请重新登录',
			showType:'show'
		});*/
		$.messager.confirm('用户过期', '请重新登录', function(r){
			top.location.href = '<%=request.getContextPath()%>/app/login.jsp';
		});
	});
	<%
		}
	%>
</script>