package com.saturn.webdo;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.apache.log4j.Logger;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ITransaction;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;
import com.saturn.app.utils.LogManager;
import com.saturn.website.Apkfile;

/**
 * apk文件下载存储
 * 
 * @author Administrator
 *
 */
public class MobileBase {
	
	private String id;
	private String command;
	private String platformType;
	private String deviceId;
	private String osVersion;
	private String mobileType;
	private String softVersion;
	
	private static org.apache.log4j.Logger Logger = LogManager.getLogger(LogManager.LOG_KEY_APP);
	
	private static ORMapping<MobileBase> mapping = new ResultORMapping<MobileBase>();
	private static ORMapping<HashMap> resultMapping = new ORMapping<HashMap>() {

		@SuppressWarnings("unchecked")//hashmap的类型检查
		@Override
		public void mappingResult(ResultSet rs, HashMap t) throws SQLException {
			try {
				ResultSetMetaData metaData = rs.getMetaData();
				
				if (metaData != null) {
					int size = metaData.getColumnCount();
					for (int i = 1; i <= size; ++i) {
						String name = metaData.getColumnName(i);
						
						try {
							String value = rs.getString(name);
							t.put(name, value);
						} catch (Exception e) {
							Logger.debug(e);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

			Logger.debug("Result Mapping Object[" + t.getClass().getSimpleName() + "]:" + t);
		}
	};
	public static Map addOrEdit(final MobileBase vo,final String downloadUrl) {
		final Map map = new HashMap();
		SimpleDaoTemplate.update(new ITransaction() {
			
			@Override
			public int execute(Connection connection) {
				// TODO Auto-generated method stub
				int vov = 0, filev = 0;
				String t = "",message = "",url = "",content = "";
				
				Apkfile file = Apkfile.getFirst();
				try {
					vov = Integer.parseInt(vo.getSoftVersion());
					filev = Integer.parseInt(file.getSoftVersion());
				} catch (Exception e) {
					// TODO: handle exception
					e.getStackTrace();
				}
				if(vov<filev){
					//有更新T
					t="T";
					message="有更新";
					url=downloadUrl+file.getApkfile();
					content=file.getTitle();
					
					MobileBase mb = get(vo.getDeviceId());
					if(mb!=null){
						//更新记录
						mb.setSoftVersion(file.getSoftVersion());
						edit(mb);
					}else{
						//添加记录
						vo.setSoftVersion(file.getSoftVersion());
						add(vo);
					}
				}else{
					//无更新F
					t="F";
					message="无更新";
				}
				//Map map = new HashMap();
				map.put("command", vo.getCommand());
				map.put("status", t);
				map.put("message", message);
				map.put("downloadUrl", url);
				map.put("content", content);
				
				return 0;
			}
		});
		return map;
		//<%=request.getContextPath()%>/app/system/upload/download.do?note='+ note
	}
	
	public static int add(MobileBase vo) {
		//指定值对象类型(VOClass)。例子：User
		//指定插入表名称(tableName)。例子：如user表3个列，tableName=user(id, name, gender)
		//根据列的顺序获取值对象的属性值。例子：vo.getId(), vo.getName(), vo.getGender()
		return SimpleDaoTemplate.update(
				"INSERT INTO mobile_base(command, platformType, deviceId, osVersion, mobileType, softVersion) VALUES(?, ?, ?, ?, ?, ?)", 
				vo.command,
				vo.platformType,
				vo.deviceId,
				vo.osVersion,
				vo.mobileType,
				vo.softVersion
		);
	}
	
	public static int edit(MobileBase vo) {
		//指定值对象类型(VOClass)。例子：User
		//指定插入表名称(tableName)。例子：如user表3个列，tableName=user
		//指定修改列信息(modify)。例子：name=?, value=?
		//根据修改列的顺序获取值对象的属性值。例子：vo.getName(), vo.getValue(), vo.getId()
		return SimpleDaoTemplate.update(
				"UPDATE mobile_base SET softVersion = ? WHERE deviceId = ?", 
				vo.softVersion,
				vo.deviceId
		);
	}
	
	public static MobileBase get(String deviceId) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定表主键(key)。例子:key=id
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.queryOne(
				"SELECT * FROM mobile_base WHERE 1 = 1 and deviceId = '" + deviceId + "'",
				null, mapping, MobileBase.class);
	}
	
	
	public static ListData<MobileBase> getAll(MobileBase vo, String start,
			String offset, String orderBy, String order) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM mobile_base WHERE 1 = 1",
				new DymaticCondition().addSimpleCondition(vo, "deviceId")
						.addCondition("ORDER BY {0} {1}", orderBy, order),
				mapping, MobileBase.class, start, offset);
	}
	
	public static List<MobileBase> getAll() {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * FROM mobile_base WHERE 1 = 1",null,
				mapping, MobileBase.class);
	}
	
	public static int remove(final String id) {
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		return SimpleDaoTemplate.update("DELETE FROM mobile_base WHERE id = ?",
				id);
	}
	
	public static void removes(String[] ids) {
		if (ids != null) {
			for (String id : ids) {
				remove(id);
			}
		}
	}
	
	public MobileBase() {
		
	}

	public MobileBase(String id, String command, String platformType,
			String deviceId, String osVersion, String mobileType,
			String softVersion) {
		super();
		this.id = id;
		this.command = command;
		this.platformType = platformType;
		this.deviceId = deviceId;
		this.osVersion = osVersion;
		this.mobileType = mobileType;
		this.softVersion = softVersion;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCommand() {
		return command;
	}

	public void setCommand(String command) {
		this.command = command;
	}

	public String getPlatformType() {
		return platformType;
	}

	public void setPlatformType(String platformType) {
		this.platformType = platformType;
	}

	public String getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	public String getOsVersion() {
		return osVersion;
	}

	public void setOsVersion(String osVersion) {
		this.osVersion = osVersion;
	}

	public String getMobileType() {
		return mobileType;
	}

	public void setMobileType(String mobileType) {
		this.mobileType = mobileType;
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
