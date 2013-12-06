package com.saturn.action.system.upload;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;

public class UpLoadAction implements IAction {

	public String requestMapping() {
		return "/app/system/upload/upload.action";
	}

	@SuppressWarnings("rawtypes")
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String savePath = request.getSession().getServletContext()
				.getRealPath("/")
				+ "attached" + File.separator;

		// 文件保存目录URL
		String saveUrl = request.getContextPath() + "/attached/";

		// 定义允许上传的文件扩展名
		HashMap<String, String> extMap = new HashMap<String, String>();
		extMap.put("image", "gif,jpg,jpeg,png,bmp");
		extMap.put("flash", "swf,flv");
		extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
		extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2,apk");
		//用户存放汽车新车
		extMap.put("appCar", "gif,jpg,jpeg,png,bmp");

		// 最大文件大小
		long maxSize = 2000000000;//最大文件2G

		if (!ServletFileUpload.isMultipartContent(request)) {
			return new JsonView(getInfo("请选择文件。"));
		}
		// 检查目录
		File uploadDir = new File(savePath);
		if (!uploadDir.isDirectory()) {
			return new JsonView(getInfo("上传目录不存在。"));
		}
		// 检查目录写权限
		if (!uploadDir.canWrite()) {
			return new JsonView(getInfo("上传目录没有写权限。"));
		}

		String dirName = request.getParameter("dir");
		if (dirName == null) {
			dirName = "image";
		}
		if (!extMap.containsKey(dirName)) {
			return new JsonView(getInfo("目录名不正确。"));
		}
		// 创建文件夹
		savePath += dirName + File.separator;
		saveUrl += dirName + "/";
		File saveDirFile = new File(savePath);
		if (!saveDirFile.exists()) {
			saveDirFile.mkdirs();
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String ymd = sdf.format(new Date());
		savePath += ymd + File.separator;
		saveUrl += ymd + "/";

		File dirFile = new File(savePath);
		if (!dirFile.exists()) {
			dirFile.mkdirs();
		}

		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");

		try {
			List items = upload.parseRequest(request);
			Iterator itr = items.iterator();
			while (itr.hasNext()) {
				FileItem item = (FileItem) itr.next();
				String fileName = item.getName();
				long fileSize = item.getSize();
				if (!item.isFormField()) {
					// 检查文件大小
					if (fileSize > maxSize) {
						return new JsonView(getInfo("上传文件大小超过限制。"));
					}
					// 检查扩展名
					String fileExt = fileName.substring(
							fileName.lastIndexOf(".") + 1).toLowerCase();
					if (!Arrays.<String> asList(extMap.get(dirName).split(","))
							.contains(fileExt)) {
						return new JsonView(
								getInfo(getInfo("上传文件扩展名是不允许的扩展名。\n只允许"
										+ extMap.get(dirName) + "格式。")));
					}

					SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
					String newFileName = df.format(new Date()) + "_"
							+ new Random().nextInt(1000) + "." + fileExt;
					try {
						File uploadedFile = new File(savePath, newFileName);
						item.write(uploadedFile);
					} catch (Exception e) {
						return new JsonView(getInfo("上传文件失败。"));
					}

					return new JsonView("{\"error\":0, \"url\":\"" + saveUrl + newFileName + "\"}");
				}
			}
		} catch (FileUploadException e) {
			return new JsonView(getInfo("上传文件失败。"));
		}

		return new JsonView(getInfo("上传文件失败。"));
	}

	private String getInfo(String message) {
		String returnInfo = "{\"error\":1, \"message\":\"{2}\"}";

		return returnInfo.replace("{2}", message);
	}

}
