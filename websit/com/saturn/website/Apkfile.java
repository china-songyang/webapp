package com.saturn.website;

import java.util.List;

import org.json.JSONObject;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;

/**
 * apk文件
 * 
 * @author Administrator
 *
 */
public class Apkfile {
	
	private String id;
	private String title;
	
	private String apkfile;
	
	private String createTime;
	private String operater;
	private String operaterName;
	private String softVersion;
	private String content;
	
	
	private static ORMapping<Apkfile> mapping = new ResultORMapping<Apkfile>();
	
	public static int add(Apkfile vo) {
		//指定值对象类型(VOClass)。例子：User
		//指定插入表名称(tableName)。例子：如user表3个列，tableName=user(id, name, gender)
		//根据列的顺序获取值对象的属性值。例子：vo.getId(), vo.getName(), vo.getGender()
		return SimpleDaoTemplate.update(
				"INSERT INTO web_apkfile(title, apkfile, createTime, operater, operaterName, softVersion, content) VALUES(?, ?, ?, ?, ?, ?, ?)", 
				vo.getTitle(),
				vo.getApkfile(),
				vo.getCreateTime(),
				vo.getOperater(),
				vo.getOperaterName(),
				vo.getSoftVersion(),
				vo.getContent()
		);
	}
	
	public static int edit(Apkfile vo) {
		//指定值对象类型(VOClass)。例子：User
		//指定插入表名称(tableName)。例子：如user表3个列，tableName=user
		//指定修改列信息(modify)。例子：name=?, value=?
		//根据修改列的顺序获取值对象的属性值。例子：vo.getName(), vo.getValue(), vo.getId()
		return SimpleDaoTemplate.update(
				"UPDATE web_apkfile SET title = ?, apkfile = ?, createTime = ?, operater = ?, operaterName = ?, softVersion = ?, content = ? WHERE id = ?", 
				vo.getTitle(),
				vo.getApkfile(),
				vo.getCreateTime(),
				vo.getOperater(),
				vo.getOperaterName(),
				vo.getSoftVersion(),
				vo.getContent(),
				vo.getId()
		);
	}
	
	public static Apkfile get(String id) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定表主键(key)。例子:key=id
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.queryOne(
				"SELECT * FROM web_apkfile WHERE 1 = 1 and id = '" + id + "'",
				null, mapping, Apkfile.class);
	}
	
	public static Apkfile getFirst() {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定表主键(key)。例子:key=id
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.queryOne(
				"SELECT * FROM web_apkfile WHERE 1 = 1 order by softVersion desc",
				null, mapping, Apkfile.class);
	}
	
	
	public static ListData<Apkfile> getAll(Apkfile vo, String start,
			String offset, String orderBy, String order) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM web_apkfile WHERE 1 = 1",
				new DymaticCondition().addSimpleCondition(vo, "title")
						.addCondition("ORDER BY {0} {1}", orderBy, order),
				mapping, Apkfile.class, start, offset);
	}
	
	public static List<Apkfile> getAll() {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM web_apkfile WHERE 1 = 1",null,
				mapping, Apkfile.class);
	}
	
	public static int remove(final String id) {
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		return SimpleDaoTemplate.update("DELETE FROM web_apkfile WHERE id = ?",
				id);
	}
	
	public static void removes(String[] ids) {
		if (ids != null) {
			for (String id : ids) {
				remove(id);
			}
		}
	}
	
	public Apkfile() {
		
	}


	public Apkfile(String id, String title, String apkfile, String createTime,
			String operater, String operaterName, String softVersion, String content) {
		super();
		this.id = id;
		this.title = title;
		this.apkfile = apkfile;
		this.createTime = createTime;
		this.operater = operater;
		this.operaterName = operaterName;
		this.softVersion = softVersion;
		this.content = content;
	}

	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getApkfile() {
		return apkfile;
	}

	public void setApkfile(String apkfile) {
		this.apkfile = apkfile;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getOperater() {
		return operater;
	}

	public void setOperater(String operater) {
		this.operater = operater;
	}

	public String getOperaterName() {
		return operaterName;
	}

	public void setOperaterName(String operaterName) {
		this.operaterName = operaterName;
	}

	public String getSoftVersion() {
		return softVersion;
	}

	public void setSoftVersion(String softVersion) {
		this.softVersion = softVersion;
	}

	@Override
	public String toString() {
		return new JSONObject(this).toString();
	}
}
