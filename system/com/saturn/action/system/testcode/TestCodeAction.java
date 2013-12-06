package com.saturn.action.system.testcode;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.ImageView;

public class TestCodeAction implements IAction {
	private static final long serialVersionUID = 1L;
	private static final int W = 60;
	private static final int H = 25;

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String codeStr = request.getParameter("code");
		
		BufferedImage img = new BufferedImage(W, H, BufferedImage.TYPE_INT_RGB);
		Graphics g = img.getGraphics();

		// 画背景
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, img.getWidth(), img.getHeight());

		// 画干扰线
		g.setColor(Color.PINK);
		for (int i = 0; i < 20; i++) {
			g.drawLine(new Random().nextInt(W), new Random().nextInt(H),
					new Random().nextInt(W), new Random().nextInt(H));
		}

		// 随机生成四个数
		g.setColor(Color.BLUE);
		g.setFont(new Font("Courier New", Font.BOLD, 16));
		
		for (int i = 0; i < codeStr.length(); i++) {
			g.drawString(codeStr.charAt(i) + "", 6 + i * 13, 17);
		}
		
		return new ImageView(img);
	}

	public String requestMapping() {
		return "/app/system/testcode/test.do";
	}

}
