package com.saturn.website;

import java.sql.Connection;
import java.util.List;

import org.json.JSONObject;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ITransaction;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;
import com.saturn.app.utils.LogManager;

/**
 * 目录
 * 
 * @author Administrator
 *
 */
public class Content {
	
	private String id; 
	private String name;
	private String english;
	private String path;
	private String parentId;
	private String sort;
	private String hasShow;
	private String hasShowName;
	private String mode;
	private String modeName;
	
	private static ORMapping<Content> mapping = new ResultORMapping<Content>();
	
	public static int add(Content vo) {
		//指定值对象类型(VOClass)。例子：User
		//指定插入表名称(tableName)。例子：如user表3个列，tableName=user(id, name, gender)
		//根据列的顺序获取值对象的属性值。例子：vo.getId(), vo.getName(), vo.getGender()
		
		
		String parentId = vo.getParentId();
		if (parentId != null && !"".equals(parentId.trim())) {
			return SimpleDaoTemplate.update(
					"INSERT INTO web_content(id, name, english, path, parentId, hasShow, hasShowName, mode, modeName) VALUES(?, ?, ?, ?, ?, ?, ?,  ?, ?)", 
					vo.getId(),
					vo.getName(),
					vo.getEnglish(),
					vo.getPath(),
					vo.getParentId(),
					vo.getHasShow(),
					vo.getHasShowName(),
					vo.getMode(),
					vo.getModeName()
			);
		}
		
		return SimpleDaoTemplate.update(
				"INSERT INTO web_content(id, name, english, path, hasShow, hasShowName, mode, modeName) VALUES(?, ?, ?, ?, ?, ?, ?, ?)", 
				vo.getId(),
				vo.getName(),
				vo.getEnglish(),
				vo.getPath(),
				vo.getHasShow(),
				vo.getHasShowName(),
				vo.getMode(),
				vo.getModeName()
		);
	}
	
	public static int edit(Content vo) {
		//指定值对象类型(VOClass)。例子：User
		//指定插入表名称(tableName)。例子：如user表3个列，tableName=user
		//指定修改列信息(modify)。例子：name=?, value=?
		//根据修改列的顺序获取值对象的属性值。例子：vo.getName(), vo.getValue(), vo.getId()
		String parentId = vo.getParentId();
		if (parentId != null && !"".equals(parentId.trim())) {
			return SimpleDaoTemplate.update(
					"UPDATE web_content SET name = ?, english = ?, path = ?, parentId = ?, sort = ?, hasShow = ?, hasShowName = ?, mode = ?, modeName = ? WHERE id = ?", 
					vo.getName(),
					vo.getEnglish(),
					vo.getPath(),
					vo.getParentId(),
					vo.getSort(),
					vo.getHasShow(),
					vo.getHasShowName(),
					vo.getMode(),
					vo.getModeName(),
					vo.getId()
			);
		}
		
		return SimpleDaoTemplate.update(
				"UPDATE web_content SET name = ?, english = ?, path = ?, sort = ?, hasShow = ?, hasShowName = ?, mode = ?, modeName = ?  WHERE id = ?", 
				vo.getName(),
				vo.getEnglish(),
				vo.getPath(),
				vo.getSort(),
				vo.getHasShow(),
				vo.getHasShowName(),
				vo.getMode(),
				vo.getModeName(),
				vo.getId()
		);
	}
	
	public static Content get(String id) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定表主键(key)。例子:key=id
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.queryOne(
				"SELECT * FROM web_content WHERE 1 = 1 and id = '" + id + "'",
				null, mapping, Content.class);
	}
	
	public static ListData<Content> getAll(Content vo, String start,
			String offset, String orderBy, String order) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM web_content WHERE 1 = 1",
				new DymaticCondition().addSimpleCondition(vo, "id", "name", "english", "path", "hasShow", "mode")
						.addCondition("ORDER BY {0} {1}", orderBy, order),
				mapping, Content.class, start, offset);
	}
	
	public static ListData<Content> getRoot(Content vo, String start,
			String offset, String orderBy, String order) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM web_content WHERE 1 = 1 AND parentId is NULL ",
				new DymaticCondition().addSimpleCondition(vo, "id", "name", "english", "path", "hasShow", "mode")
						.addCondition("ORDER BY {0} {1}", orderBy, order),
				mapping, Content.class, start, offset);
	}
	
	public static ListData<Content> getChildren(Content vo, String parentId, String start,
			String offset, String orderBy, String order) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM web_content WHERE 1 = 1 AND parentId = '" + parentId + "' ",
				new DymaticCondition().addSimpleCondition(vo, "id", "name", "english", "path", "hasShow", "mode")
						.addCondition("ORDER BY {0} {1}", orderBy, order),
				mapping, Content.class, start, offset);
	}
	
	public static List<Content> getChildren(String id) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM web_content WHERE 1 = 1",
				new DymaticCondition().addCondition("AND parentId = '?'", id),
				mapping, Content.class);
	}
	
	
	public static List<Content> getRoot() {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM web_content WHERE parentId is NULL",
				null,
				mapping, Content.class);
	}
	
	public static int show(String id) {
		Content content = get(id);
		String hasShow = content.getHasShow();
		
		if ("visible.true".equals(hasShow)) {
			content.setHasShow("visible.false");
			content.setHasShowName("隐藏");
		} else {
			content.setHasShow("visible.true");
			content.setHasShowName("显示");
		}
		
		return edit(content);
	}
	
	public static void changeSort(final String firstId, final String secondId) {
		SimpleDaoTemplate.update(new ITransaction() {
			public int execute(Connection connection) {
				Content c1 = get(firstId);
				Content c2 = get(secondId);
				
				String sort1 = c1.getSort();
				String sort2 = c2.getSort();
				
				SimpleDaoTemplate.update(connection,
					"UPDATE web_content SET sort = ? WHERE id = ?", 
					"-1",
					secondId
				);
					
				
				SimpleDaoTemplate.update(connection,
					"UPDATE web_content SET sort = ? WHERE id = ?", 
					sort2,
					firstId
				);
				
				SimpleDaoTemplate.update(connection,
					"UPDATE web_content SET sort = ? WHERE id = ?", 
					sort1,
					secondId
				);
				
				return 0;
			}
		});
	}
	
	public static String getAllContentTreeJSON(String id) {
		String json = generateTreeJSON(id);
		LogManager.getLogger(LogManager.LOG_KEY_APP).debug(
				"TreeJSON:" + json);
		return json;
	}

	public static String generateTreeJSON(String id) {
		List<Content> rows = Content.getChildren(id);
		
		StringBuffer buffer = new StringBuffer();
		buffer.append("[");

		for (Content content : rows) {
			List<Content> child = Content.getChildren(content.getId());
			
			if (child == null || child.isEmpty()) {//没有子节点还没有要维护的内容
				if ("content.mode.none".equals(content.getMode())) {
						//|| (content.getPath() != null && !"".equals(content.getPath()))) { //有独立的jsp页，无需维护
					continue;
				}
			}
			
			buffer.append("{");
			buffer.append("\"id\":" + "\"" + content.getId() + "\"" + ",");
			buffer.append("\"text\":" + "\"" + content.getName() + "\"" + ",");
			buffer.append("\"mode\":" + "\"" + content.getMode() + "\"" + ",");

			if (child != null && !child.isEmpty()) {
				buffer.append("\"state\":" + "\"closed\"" + ",");
			} 
			
			// buffer.append("\"iconCls\":\"icon-author\",");
			if (content.getPath() != null) {
				buffer.append("\"attributes\":{\"path\":" + "\""
						+ content.getPath() + "\", \"mode\":\"" + content.getMode() + "\"}");
			} else {
				buffer.append("\"attributes\":{\"mode\":\"" + content.getMode() + "\"}");
			}

			buffer.append(", \"children\" : ").append(generateTreeJSON(content.getId()));
			buffer.append("},");
		}
		buffer.append("]");
		
		return buffer.toString().replaceFirst(",]", "]");
	}
	
	public static int remove(final String id) {
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		return SimpleDaoTemplate.update("DELETE FROM web_content WHERE id = ?",
				id);
	}
	
	/*实现删除id项，和它的所有子节点
	public static int remove(final String id) {
		List<Content> allChildren = getAllChildren(id);
		StringBuffer ids = new StringBuffer();
		
		if (!allChildren.isEmpty()) {
			for (Content content : allChildren) {
				ids.append("'"+content.getId() + "',");
			}
		}
		ids.append("'"+id+"'");
		
		return SimpleDaoTemplate.update("DELETE FROM web_content WHERE id IN (" + ids + ")");
	}
	
	public static List<Content> getAllChildren(String parentId) {
		List<Content> children = null;
		
		if (parentId == null) {
			children = getRoot();
		} else {
			children = getChildren(parentId);
		}
		
		LinkedList<Content> stack = new LinkedList<Content>(children);
		List<Content> allChildren = new ArrayList<Content>();
		
		while (!stack.isEmpty()) {
			Content content = stack.removeFirst();
			allChildren.add(content);
			
			List<Content> child = getChildren(content.getId());
			if (!child.isEmpty()) {
				stack.addAll(child);
			}
		}
		
		return allChildren;
	}
	*/
	
	public static void removes(String[] ids) {
		if (ids != null) {
			for (String id : ids) {
				remove(id);
			}
		}
	}
	
	public Content() {
		
	}
	
	public Content(String id, String name, String english, String path,
			String parentId, String sort, String hasShow, String hasShowName,
			String mode, String modeName) {
		super();
		this.id = id;
		this.name = name;
		this.english = english;
		this.path = path;
		this.parentId = parentId;
		this.sort = sort;
		this.hasShow = hasShow;
		this.hasShowName = hasShowName;
		this.mode = mode;
		this.modeName = modeName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEnglish() {
		return english;
	}

	public void setEnglish(String english) {
		this.english = english;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getHasShow() {
		return hasShow;
	}

	public void setHasShow(String hasShow) {
		this.hasShow = hasShow;
	}
	
	public String getHasShowName() {
		return hasShowName;
	}

	public void setHasShowName(String hasShowName) {
		this.hasShowName = hasShowName;
	}
	
	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getModeName() {
		return modeName;
	}

	public void setModeName(String modeName) {
		this.modeName = modeName;
	}

	@Override
	public String toString() {
		return new JSONObject(this).toString().replace("parentId", "_parentId");
	}
}
