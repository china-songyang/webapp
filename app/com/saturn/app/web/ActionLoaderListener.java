package com.saturn.app.web;

import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.saturn.app.utils.FileUtils;

public class ActionLoaderListener implements ServletContextListener {

	private static final String ACTION_ROOT_PATH_DEFAULT = "/com/saturn/action";
	private static final String ACTION_ROOT_PATH = "actionRootPath";

	public void contextInitialized(ServletContextEvent event) {
		ServletContext context = event.getServletContext();
		String actionRootPath = context.getInitParameter(ACTION_ROOT_PATH);

		if (actionRootPath == null) {
			actionRootPath = ACTION_ROOT_PATH_DEFAULT;
		}

		List<String> classNames = loadActionClass(actionRootPath);
		ActionManager.add(classNames);
	}

	public void contextDestroyed(ServletContextEvent event) {
	}

	public List<String> loadActionClass(String actionRootPath) {
		List<String> actionClass = new ArrayList<String>();

		URL url = ActionLoaderListener.class.getResource(actionRootPath);
		File rootDir = new File(url.getFile());

		LinkedList<File> dirs = new LinkedList<File>();
		dirs.add(rootDir);

		while (!dirs.isEmpty()) {
			File dir = dirs.removeFirst();
			addSubDirs(dir, dirs);
			print(actionClass, dir);
		}
		
		return actionClass;
	}

	private void addSubDirs(File dir, LinkedList<File> dirs) {
		File[] files = FileUtils.getSubDirectory(dir);

		if (files != null) {
			for (File file : files) {
				dirs.add(file);
			}
		}
	}

	private void print(List<String> actionClass, File dir) {
		File[] file = FileUtils.getSubFile(dir, ".class");

		if (file != null) {
			for (int i = 0; i < file.length; i++) {
				actionClass.add(getClassFullName(file[i].getAbsolutePath()));
			}
		}
	}

	public String getClassFullName(String filePath) {
		String classPath = new File(ActionLoaderListener.class.getResource("/")
				.getFile()).getAbsolutePath();
		
		String className = filePath.replace(classPath, "");
		className = className.replace(File.separatorChar+"", ".");
		className = className.replace(".class", "");
		return className.substring(1);
	}
}
