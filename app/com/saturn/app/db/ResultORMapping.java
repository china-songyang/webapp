package com.saturn.app.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.saturn.app.exception.DBException;
import com.saturn.app.utils.BeanUtils;

public class ResultORMapping<T> extends ORMapping<T>{

	@Override
	public void mappingResult(ResultSet rs, T t) throws SQLException {
		BeanUtils.mapppingBean(rs, t);
	}

	@Override
	public void mappingParameter(PreparedStatement ps, T t) throws SQLException {
		throw new DBException("BeanORMapping not support this method!");
	}
}
