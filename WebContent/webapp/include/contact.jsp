<%@page import="com.saturn.website.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="part">
	<%
String txt_contact = Article.getOneArticleText("geneonhtml.contact");
if(txt_contact!=null && !"".equals(txt_contact)) {
	out.print(txt_contact);
} else {
	%>
	<div class="parta">
		<h1>推荐解决方案</h1>
	</div>
	<div class="partb">
		<div class="qh">
			<object id="FlashID2"
				classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="266"
				height="223">
				<param name="movie" value="flash/bh.swf" />
				<param name="quality" value="high" />
				<param name="wmode" value="opaque" />
				<param name="swfversion" value="6.0.65.0" />
				<!-- 此 param 标签提示使用 Flash Player 6.0 r65 和更高版本的用户下载最新版本的 Flash Player。如果您不想让用户看到该提示，请将其删除。 -->
				<param name="expressinstall" value="Scripts/expressInstall.swf" />
				<!-- 下一个对象标签用于非 IE 浏览器。所以使用 IECC 将其从 IE 隐藏。 -->
				<!--[if !IE]>-->
				<object type="application/x-shockwave-flash" data="flash/bh.swf"
					width="266" height="223">
					<!--<![endif]-->
					<param name="quality" value="high" />
					<param name="wmode" value="opaque" />
					<param name="swfversion" value="6.0.65.0" />
					<param name="expressinstall" value="Scripts/expressInstall.swf" />
					<!-- 浏览器将以下替代内容显示给使用 Flash Player 6.0 和更低版本的用户。 -->
					<div>
						<h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>
						<p>
							<a href="http://www.adobe.com/go/getflashplayer"><img
								src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif"
								alt="获取 Adobe Flash Player" width="112" height="33" /></a>
						</p>
					</div>
					<!--[if !IE]>-->
				</object>
				<!--<![endif]-->
			</object>
		</div>
		<div class="pc">
			<img src="images/jqr.jpg" width="266" height="202" />
		</div>
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>
<%
}
%>
