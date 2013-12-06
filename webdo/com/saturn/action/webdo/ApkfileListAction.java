package com.saturn.action.webdo;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;
import com.saturn.website.Apkfile;

public class ApkfileListAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		//-------
		String aid = request.getParameter("aid");
		List list = Apkfile.getAll();
		
		JSONArray ja = new JSONArray();
		if (!list.isEmpty()) {
			List menu = new ArrayList();
			for (int i = 0; i < list.size(); ++i) {
				Apkfile art = (Apkfile) list.get(i);
					JSONObject jobj = new JSONObject(art);
					menu.add(jobj);
			}
			ja = new JSONArray(menu);
		}
		return new JsonView(ja.toString());
	}

	public String requestMapping() {
		return "/webdo/apkfile/apkfilelist.do";
	}

}
