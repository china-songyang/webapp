<%@page import="com.saturn.website.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String txt_contactme = Article.getOneArticleText("geneonhtml.contactme");
if(txt_contactme!=null && !"".equals(txt_contactme)) {
	out.print(txt_contactme);
} else {
	%>
<div class="part">
	<div class="parta">
		<h1>联系我们</h1>
	</div>
	<div class="partb">
		<div class="contant">
			<h2>长春市志昂生物科技有限公司</h2>
			<div class="lxfs">
				<p>高新区锦湖大路1357号5楼516室</p>
				<p>0431-89251663</p>
				<p>0431-89251665</p>
				<p>info@geneonbio.com</p>
			</div>
		</div>
	</div>
	<div class="clear"></div>
</div>
<%
}
%>
