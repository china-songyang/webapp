package com.saturn.app.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileFilter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

/**
 * 文件工具类
 * 
 * @author 谷钰
 * @version 1.0 2008.12.02
 * 
 */
public class FileUtils {

	public static File[] getSubDirectory(File dir) {
		if (dir == null || !dir.isDirectory()) {
			return null;
		}
		
		return dir.listFiles(new FileFilter() {

			public boolean accept(File pathname) {
				return pathname.isDirectory();
			}
		});
	}
	
	public static File[] getSubFile(File dir, final String suffix) {
		if (dir == null || !dir.isDirectory()) {
			return null;
		}
		
		return dir.listFiles(new FileFilter() {

			public boolean accept(File pathname) {
				return pathname.getName().endsWith(suffix);
			}
		});
	}

	/**
	 * 获得path路径下的文件或文件夹对象, 如果不存在自动创建
	 * 
	 * @param path
	 * @return
	 */
	public static File getFile(String path) {
		StringTokenizer directoryTokenzier = new StringTokenizer(path,
				File.separator);

		File file = null;
		StringBuffer pathBuffer = null;

		while (directoryTokenzier.hasMoreTokens()) {
			String directory = directoryTokenzier.nextToken();

			if (directory != null && !"".equals(directory)) {
				if (pathBuffer == null) {
					pathBuffer = new StringBuffer();
					pathBuffer.append(directory);
				} else {
					pathBuffer.append(File.separator).append(directory);
				}

				file = new File(pathBuffer.toString());
				if (!file.exists() && directoryTokenzier.hasMoreTokens()) {
					file.mkdir();
				} else if (file.isFile()) {
					break;
				}
			}
		}

		return file;
	}

	/**
	 * 文件复制
	 * 
	 * @param source
	 * @param copy
	 */
	public static void fileCopy(File source, File copy) {
		BufferedReader reader = null;
		PrintWriter writer = null;

		try {
			reader = new BufferedReader(new FileReader(source));
			writer = new PrintWriter(new FileWriter(copy));

			String line = null;
			while ((line = reader.readLine()) != null) {
				writer.println(line);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			if (writer != null) {
				writer.close();
			}
		}

	}
}
