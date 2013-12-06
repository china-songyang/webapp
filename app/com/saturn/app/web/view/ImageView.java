package com.saturn.app.web.view;

import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IView;

/**
 * 二进制流类型视图的实现类，保存了字节流类型的数据。
 * 
 * @author 谷钰
 * 
 * @version 1.0 2008.8.28
 * 
 * @see IView
 * @see HttpServletRequest
 * @see HttpServletResponse
 * 
 */
public class ImageView implements IView {

	private BufferedImage img;

	public ImageView(BufferedImage img) {
		this.img = img;
	}

	public void dispather(HttpServletRequest request,
			HttpServletResponse response) {
		ServletOutputStream sout = null;

		try {
			response.setContentType("image/jpeg");
			
			ImageIO.write(img, "PNG", response
					.getOutputStream());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (sout != null) {
				try {
					sout.flush();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}