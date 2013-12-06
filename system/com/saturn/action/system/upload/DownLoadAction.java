package com.saturn.action.system.upload;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;

public class DownLoadAction implements IAction {

	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		  	String name = request.getParameter("note");
			  // web绝对路径
			  String path = request.getSession().getServletContext().getRealPath("/");
			  String savePath = path.substring(0, path.lastIndexOf(File.separator));
			  savePath = savePath.substring(0, savePath.lastIndexOf(File.separator));
			  // 清空response
	            response.reset();

			  // 设置为下载application/x-download
			  response.setContentType("application/x-download");
			  // 即将下载的文件在服务器上的绝对路径
			  String filenamedownload = savePath + File.separator + name;
			  // 下载文件时显示的文件保存名称
			  String filenamedisplay = name.substring(name.lastIndexOf("/"));
			  // 中文编码转换
			  try {
				filenamedisplay = URLEncoder.encode(filenamedisplay, "UTF-8");
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			  response.addHeader("Content-Disposition", "attachment;filename="
			    + filenamedisplay);
			  try {
			   java.io.OutputStream os = response.getOutputStream();
			   java.io.FileInputStream fis = new java.io.FileInputStream(
			     filenamedownload);
			   	response.setHeader("Content-Length", ""+fis.available());
			   	response.setHeader("Encoding-Type", "UTF-8");
			   byte[] b = new byte[1024];
			   int i = 0;
			   while ((i = fis.read(b)) > 0) {
			    os.write(b, 0, i);
			   }
			   fis.close();
			   os.flush();
			   os.close();
			  } catch (Exception e) {

			  }

			 

		return null;
	}

	@Override
	public String requestMapping() {
		// TODO Auto-generated method stub
		return "/app/system/upload/download.do";
	}

}
