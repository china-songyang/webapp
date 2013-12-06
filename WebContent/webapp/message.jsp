<%@page import="com.saturn.website.Message"%>
<%@page import="com.saturn.app.utils.DateUtils"%>
<%@page import="com.saturn.website.PaginationUtils"%>
<%@page import="com.saturn.website.WebUtils"%>
<%@page import="com.saturn.website.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/include.jsp"%>
<script src="js/swfobject_modified.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/base.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/easyui.css">

<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/easyloader.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/testCode.js"></script>
<title>长春市志昂生物科技有限公司</title>
</head>
<script type="text/javascript">
	var code = '';

	function reload() {
		code = __getTestCode();
		$('#testCodeImage').attr("src", "<%=request.getContextPath()%>/app/system/testcode/test.do?code=" + code);
		return false;
	}
	
	$(function() {
		code = __getTestCode();
		$('#testCodeImage').attr("src", "<%=request.getContextPath()%>/app/system/testcode/test.do?code=" + code);
		//$('#testCode').val(code);
		$('#lyform').css("display","none");
	});
	
	function showLyForm(){
		if("block"==$('#lyform').css("display")){
			$('#lyform').css("display","none");
		}else{
			$('#lyform').css("display","block");
		}
	}
	
	function submitForm(form) {
		var testCode = $('#testCode').val();
		if (testCode.toLowerCase() != code.toLowerCase()) {
			$.messager.alert('提示','验证码不正确','info');
			$('#testCode').focus();
			return;
		}
		
		if ($('#sendText').val() == '') {
			$.messager.alert('提示','请填写留言信息','info');
			$('#sendText').focus();
			return;
		}
		
		$.ajax({
			url : '<%=request.getContextPath()%>/app/website/message/addByClient.do', 
			type : 'post',         
			dataType : 'json',     
			data : {
				sendText : $("#sendText").val(),         
				sendName : $("#sendName").val(),         
				sendEmail : $("#sendEmail").val(),     
				sendPhone : $("#sendPhone").val(),     
				cid : '<%=WebUtils.getRootCid(request)%>',     
				type : '留言',     
				receiveText : '',     
				stateName : '未回复',     
				state : 'message.state.false',     
				hasShow : 'visible.true',     
				hasShowName : '显示',     
				sendTime : '<%=DateUtils.getSystemTime()%>',     
				receiveTime : '',     
				receiveOperater : '',     
				receiveOperaterName : ''
			},
			success : function(data) {
				if (data) {
					$("#sendText").val('');       
					$("#sendName").val('');
					$("#sendEmail").val('');
					$("#sendPhone").val('');
					$('#testCode').val('');
					$('#lyform').css("display","none");
					//$.messager.alert('提示','保存成功','info');
					//alert('保存成功');
					using(['dialog','messager'], function(){
						$.messager.show({
							title:'info',
							msg:'保存成功'
						});
					});
					//window.location.reload();
					reload();
				}
			} 
		});
	}
</script>
<body>
	<div id="container">
		<%@ include file="include/top.jsp"%>
		<div id="content">
			<%@ include file="include/left.jsp"%>
			<%
       		String __cid = request.getParameter("cid");
        	String __cname = "首页";
          	if (__cid != null) {
          		Content content = Content.get(__cid);
          		if (content != null) {
          			__cname = content.getName();
          		}
          	}
			Article article = Article.getOneByCid(__cid);
	  	  	String indexStr = request.getParameter("index");
			String title = "";
			String text = "";
			
			if (article != null) {
				title = article.getTitle();
				response.setHeader("title", title);
				text = article.getText();
			}
		%>
			<div class="right">
				<div class="party">
					<div class="partay">
						<h1><%=__cname %></h1>
					</div>
					<div class="partby">
						<div class="wz a">
							<form id="addForm"
								action="<%=request.getContextPath()%>/app/website/message/addByClient.do?to=<%=WebUtils.getRootCid(request)%>"
								method="post">
								<table border="0" cellpadding="0" cellspacing="0"
									style="width: 90%; margin-left: 30px;">
									<tr>
										<td height="25px">您好，欢迎您对我们的服务提出意见和建议。</td>
									</tr>
									<tr>
										<td height="25px">留言信息：</td>
									</tr>
									<tr>
										<td height="100px"><textarea name="sendText"
												id="sendText" style="width: 100%; height: 100px;"></textarea></td>
									</tr>
									<tr>
										<td><div id="sendTextTip"></div></td>
									</tr>
									<tr>
										<td height="25px"><br /> <span style="color: #1377c5;">联系方式：</span></td>
									</tr>
									<tr>
										<td height="25px">为了能够及时解决您的疑问或问题，请留下您准确的联系方式，以便我们的客服人员能够快捷、准确的联系到您。</td>
									</tr>
									<tr>
										<td><table cellpadding="0" cellspacing="0">
												<tr align="left">
													<td height="25px" width="80px" align="right">姓名：</td>
													<td width="180px"><input type="text" name="sendName"
														id="sendName" maxlength="20" /></td>
												</tr>
												<tr align="left">
													<td height="25px" align="right">联系电话：</td>
													<td><input type="text" name="sendPhone" id="sendPhone"
														maxlength="30" /></td>
												</tr>
												<tr align="left">
													<td height="25px" align="right">电子邮箱：</td>
													<td><input type="text" name="sendEmail" id="sendEmail"
														maxlength="30" /></td>
												</tr>
												<tr align="left">
													<td height="25px" align="right">验证码：</td>
													<td colspan="2"><table cellpadding="0" cellspacing="0">
															<tr>
																<td><input type="text" name="testCode"
																	id="testCode" maxlength="4" size="4" /> &nbsp;</td>
																<td><img id="testCodeImage" alt="点击更换图片"
																	onclick="reload()" style="cursor: pointer;" /></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td>&nbsp;</td>
													<td><input type="button" value="提 交" name="submit"
														onclick="javascript:return submitForm(this.form);" /></td>
													<td>&nbsp;</td>
												</tr>
											</table></td>
									</tr>
								</table>
							</form>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<!--右-->

			</div>
			<!--右侧-->
			<div class="clear"></div>
		</div>
		<!--内容-->
		<%@ include file="include/foot.jsp"%>
	</div>
	<!--容器-->
	<script type="text/javascript">
<!--
swfobject.registerObject("FlashID");
swfobject.registerObject("FlashID2");
//-->
</script>
</body>
</html>