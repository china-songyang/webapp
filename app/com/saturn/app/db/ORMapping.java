package com.saturn.app.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ORMapping<T> {
	public void mappingResult(ResultSet rs, T t) throws SQLException {
		
	}
	
	public void mappingParameter(PreparedStatement ps, T t) throws SQLException {
		
	}
}
