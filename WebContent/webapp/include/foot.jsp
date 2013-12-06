<%@page import="com.saturn.website.Article"%>
<%@page import="com.saturn.website.WebUtils"%>
<%@page import="com.saturn.website.Content"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="footer">
	<div id="copy">
		<div class="fastnav">
			<%
				List __contents_foot = Content.getChildren(WebUtils.getRootCid(request));
				String __id_foot = request.getParameter("cid");

				if (!__contents_foot.isEmpty()) {
					for (int i = 0; i < __contents_foot.size(); ++i) {
						Content content = (Content) __contents_foot.get(i);
						if ("显示".equals(content.getHasShowName())) {
							String id = content.getId();
							if (__id_foot == null) {
								__id_foot = id;
							}

							String css = "";
							if (__id_foot.equals(id)) {
								css = "color:#11b5eb";
							}
							if(i==0){
			%>
			<a href="<%=WebUtils.getLink(id, null)%>" style="<%=css%>"><%=content.getName()%></a>
			<%					
							}else{
			%>
			&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<%=WebUtils.getLink(id, null)%>"
				style="<%=css%>"><%=content.getName()%></a>
			<%
							}
						}
					}
				}
			%>
			<%
				//代码管理
String txt_foot = Article.getOneArticleText("geneonhtml.foot");
if(txt_foot!=null && !"".equals(txt_foot)) {
	out.print(txt_foot);
} else {
	%>
			<P>Copyright© 2012长春市志昂生的科技有限公司 All Rights Reseived</P>
			<P>地址：高新区锦湖大路1357号5楼516室</P>
			<P>网站备案:吉ICP备00000007</P>
			<%
}
%>
		</div>
	</div>
	<!--版权-->
	<div class="clear"></div>