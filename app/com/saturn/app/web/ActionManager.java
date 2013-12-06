package com.saturn.app.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.saturn.app.utils.LogManager;

public class ActionManager {

	private static Logger logger = LogManager.getLogger(LogManager.LOG_KEY_APP);

	private static Map<String, IAction> actions = new HashMap<String, IAction>();

	private static List<Class<?>> actionClass = new ArrayList<Class<?>>();

	private ActionManager() {

	}

	public static void add(List<String> actionNames) {
		if (actionNames != null) {
			for (String name : actionNames) {
				try {
					Class<?> clazz = Class.forName(name);
					if (clazz.isLocalClass() || clazz.isMemberClass()) {
						continue;
					}
					Object object = clazz.newInstance();

					if (object instanceof IAction) {
						IAction action = (IAction) object;
						String key = action.requestMapping();
						add(key, action);

						logger.debug("Load Action [requestMapping=\"" + key
								+ "\", name=\"" + name + "\"]");
					}
				} catch (Exception e) {
					logger.error("Load Action Failed with name:" + name, e);
				}
			}
		}
	}

	public static void add(IAction action) {
		actions.put(action.requestMapping(), action);
	}

	public static void add(String key, IAction action) {
		actions.put(key, action);
	}

	public static void add(Class<?> clazz) {
		actionClass.add(clazz);
	}

	public static IAction get(String key) {
		IAction action = actions.get(key);

		if (action == null) {
			action = new NullAction(key);
		}

		return action;
	}

}
