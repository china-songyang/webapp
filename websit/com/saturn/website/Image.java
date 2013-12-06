package com.saturn.website;

import java.util.List;

import org.json.JSONObject;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;

public class Image {
	private String id = "";
	private String articleId = "";
	private String imageUrl = "";
	private String state = "";
	private String stateName = "";
	private String createTime = "";
	
	private static ORMapping<Image> mapping = new ResultORMapping<Image>();
	
	public static int add(Image vo) {
		//指定值对象类型(VOClass)。例子：User
		//指定插入表名称(tableName)。例子：如user表3个列，tableName=user(id, name, gender)
		//根据列的顺序获取值对象的属性值。例子：vo.getId(), vo.getName(), vo.getGender()
		return SimpleDaoTemplate.update(
				"INSERT INTO acticle_re_img(articleId, imageUrl, state, stateName, createTime) VALUES(?, ?, ?, ?, ?)", 
				vo.getArticleId(),
				vo.getImageUrl(),
				vo.getState(),
				vo.getStateName(),
				vo.getCreateTime()
		);
	}
	
	public static ListData<Image> getAll(Image vo, String start,
			String offset, String orderBy, String order) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM acticle_re_img WHERE 1 = 1",
				new DymaticCondition().addSimpleCondition(vo, "articleId", "state", "createTime")
						.addCondition("and articleId = ?", vo.getId())
						.addCondition("ORDER BY {0} {1}", orderBy, order),
				mapping, Image.class, start, offset);
	}
	
	public static List<Image> getByAid(String aid) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM acticle_re_img WHERE state = 'visible.true'",
				new DymaticCondition().addCondition("and articleId = ?", aid),
				mapping, Image.class);
	}
	
	
	public static Image get(String id) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定表主键(key)。例子:key=id
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.queryOne(
				"SELECT * FROM acticle_re_img WHERE 1 = 1 and id = '" + id + "'",
				null, mapping, Image.class);
	}
	
	public static int edit(Image vo) {
		//指定值对象类型(VOClass)。例子：User
		//指定插入表名称(tableName)。例子：如user表3个列，tableName=user
		//指定修改列信息(modify)。例子：name=?, value=?
		//根据修改列的顺序获取值对象的属性值。例子：vo.getName(), vo.getValue(), vo.getId()
		return SimpleDaoTemplate.update(
				"UPDATE acticle_re_img SET articleId = ?, imageUrl = ?, state = ?, stateName = ?, createTime = ? WHERE id = ?", 
				vo.getArticleId(),
				vo.getImageUrl(),
				vo.getState(),
				vo.getStateName(),
				vo.getCreateTime(),
				vo.getId()
		);
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getArticleId() {
		return articleId;
	}
	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}
	
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getStateName() {
		return stateName;
	}
	public void setStateName(String stateName) {
		this.stateName = stateName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	@Override
	public String toString() {
		return new JSONObject(this).toString();
	}
}
