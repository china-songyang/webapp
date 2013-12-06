package com.saturn.app.db;

import java.util.Map;

import com.saturn.app.utils.BeanUtils;

public class DymaticCondition {

	private StringBuffer buffer = new StringBuffer(" ");

	public DymaticCondition addCondition(String key, String value) {
		if (value != null && !"".equals(value.trim()) && key != null
				&& !"".equals(key)) {
			
			buffer.append(key.replace("?", value)).append(" ");
		}

		return this;
	}
	
	public DymaticCondition addCondition(String key, String... values) {
		if (values != null) {
			for (int i = 0; i < values.length; ++i) {
				String value = values[i];
				
				if (value != null && !"".equals(value.trim()) && key != null
						&& !"".equals(key)) {
					
					key = key.replace("{"+i+"}", value);
				} else {
					return this;
				}
			}
		}
		
		buffer.append(key).append(" ");
		return this;
	}
	
	public <T> DymaticCondition addSimpleCondition(T t, String... fields) {
		if (fields != null) {
			for (int i = 0; i < fields.length; ++i) {
				String field = fields[i];
				String value = null;
				if (t instanceof Map) {
					@SuppressWarnings("rawtypes")
					Object o = ((Map)t).get(field);
					if (o != null) {
						value = o.toString();
					}
				} else {
					value = BeanUtils.invokeGet(t, field);
				}
				
				if (value != null && !"".equals(value.trim())) {
					
					buffer.append("AND ").append("`" + field + "`").append(" like '%").append(value).append("%' ");
				}
			}
		}
		
		return this;
	}

	public String toString() {
		return buffer.toString();
	}
}
