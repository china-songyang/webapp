package com.saturn.system;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.json.JSONObject;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ITransaction;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;

public class Dict {
	
	private String id;
	private String key;
	private String value;
	private String type;
	private String pinyin;

	private static ORMapping<Dict> mapping = new ResultORMapping<Dict>();

	public static int add(Dict dict) {
		return SimpleDaoTemplate.update(
				"INSERT INTO app_dict(`key`, value, type, pinyin) VALUES(?, ?, ?, ?)", dict.getKey(),
				dict.getValue(), dict.getType(), dict.getPinyin());
	}

	public static Dict get(String id) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定表主键(key)。例子:key=id
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.queryOne(
				"SELECT * FROM app_dict WHERE 1 = 1 and id = '" + id + "'",
				null, mapping, Dict.class);
	}

	public static int edit(Dict dict) {
		return SimpleDaoTemplate
				.update("UPDATE app_dict SET `key` = ?, value = ?, type = ?, pinyin = ? WHERE id = ?",
						dict.getKey(), dict.getValue(), dict.getType(), dict.getPinyin(),
						dict.getId());
	}

	public static ListData<Dict> getDicts(Dict dict, String start,
			String offset, String orderBy, String order) {

		return SimpleDaoTemplate.query(
				"SELECT * FROM app_dict WHERE 1 = 1", new DymaticCondition()
				.addSimpleCondition(dict, "key", "value", "type", "pinyin")
						.addCondition("ORDER BY {0} {1}", orderBy, order),
				mapping, Dict.class, start, offset);
	}
	
	public static List<StringBuffer> getAllDictType() {
		return SimpleDaoTemplate.query("SELECT distinct(type) as typeStr from app_dict order by type", null,
				new ORMapping<StringBuffer>() {
					
					@Override
					public void mappingResult(ResultSet rs, StringBuffer t)
							throws SQLException {
					
						t.append(rs.getString("typeStr"));
					}
		}, StringBuffer.class);
	}
	
	public static void change(final String firstId, final String secondId) {
		SimpleDaoTemplate.update(new ITransaction() {
			public int execute(Connection connection) {
				Dict i1 = get(firstId);
				Dict i2 = get(secondId);

				String key1 = i1.getKey();
				String key2 = i2.getKey();

				SimpleDaoTemplate.update(connection,
						"UPDATE app_dict SET id = ? WHERE `key` = ?", "-1",
						key2);

				SimpleDaoTemplate.update(connection,
						"UPDATE app_dict SET id = ? WHERE `key` = ?",
						secondId, key1);

				SimpleDaoTemplate.update(connection,
						"UPDATE app_dict SET id = ? WHERE `key` = ?",
						firstId, key2);

				return 0;
			}
		});
	}
	
	public static List<Dict> getDictByType(String type) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM app_dict WHERE 1 = 1",
				new DymaticCondition().addCondition("AND type = '?' order by id desc", type),
				mapping, Dict.class);
	}
	
	public static String getDictJSONByType(String type) {
		List<Dict> dicts = getDictByType(type);
		
		StringBuffer buffer = new StringBuffer("[");

		for (Dict dict : dicts) {
			buffer.append("{\"id\":\"").append(dict.getKey()).append("\", \"text\":\"")
					.append(dict.getValue()).append("\", \"name\":\"")
					.append(dict.getValue()).append("\"},");
		}
		if (!dicts.isEmpty()) {
			buffer.deleteCharAt(buffer.length() - 1);
		}
		buffer.append("]");

		return buffer.toString();
	}
	
	public static String getAllTypeJSON() {
		List<StringBuffer> datas = getAllDictType();
		StringBuffer buffer = new StringBuffer("[");

		for (int i = 0; i < datas.size(); ++i) {
			Object data = datas.get(i);
			buffer.append("{\"id\":\"").append(data).append("\", \"text\":\"")
					.append(data).append("\"},");
		}

		if (!datas.isEmpty()) {
			buffer.deleteCharAt(buffer.length() - 1);
		}
		buffer.append("]");

		return buffer.toString();
	}

	public static int remove(final String id) {
		return SimpleDaoTemplate
				.update("DELETE FROM app_dict WHERE id = ?", id);
	}

	public static void removes(String[] ids) {
		if (ids != null) {
			for (String id : ids) {
				remove(id);
			}
		}
	}
	
	public Dict() {
	}

	public Dict(String id, String key, String value, String type, String pinyin) {
		super();
		this.id = id;
		this.key = key;
		this.value = value;
		this.type = type;
		this.pinyin = pinyin;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPinyin() {
		return pinyin;
	}

	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}

	@Override
	public String toString() {
		return new JSONObject(this).toString();
	}
}
