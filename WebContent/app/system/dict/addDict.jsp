<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加数据字典</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function add() {
		var typeValue = $('#type').combobox('getValue');
		
		if (typeValue == "") {
			alert("类型不能为空!");
		} else {
			$('#addForm').submit();
		}
	}
	
	$(function() {
		$('#type').combobox({
			width : 256,
			onSelect:function(record){
				$('#id').val(record.text);
		    }
		});
		
		$('#key').focus();
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="添加数据字典信息" icon="icon-save"
		collapsible="true" style="padding: 10px;">
		<form id="addForm"
			action="<%=request.getContextPath()%>/app/system/dict/addDict.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>类型:</td>
					<td><select id="type" class="easyui-combobox" name="type"
						url="<%=request.getContextPath()%>/app/system/dict/queryDictType.action"
						valueField="id" textField="text" editable="true"></select></td>
					<td><div id="typeTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>标识:</td>
					<td><input id="key" name="key" type="text"></input></td>
					<td><div id="keyTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>值:</td>
					<td><input id="value" name="value" type="text"></input></td>
					<td><div id="valueTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>拼音:</td>
					<td><input id="pinyin" name="pinyin" type="text"></input></td>
					<td><div id="pinyinTip"></div></td>
				</tr>
				<tr>
					<td colspan="3">
						<div style="padding: 10px;">
							<a href="#" onclick="add()" class="easyui-linkbutton"
								iconCls="icon-add">添加</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "addForm"
		});
		
		$("#key").formValidator({
			onfocus : "请输入标识"
		}).inputValidator({
			min : 1,
			max : 50,
			onerror : "标识不超过50字符"
		});
		
		/*
		$("#key").formValidator({
			onfocus : "请输入标识"
		}).regexValidator({
			regexp : "id"
		}).inputValidator({
			min : 1,
			max : 50,
			onerror : "标识不超过50字符"
		}).ajaxValidator({
			url : "<%=request.getContextPath()%>/app/system/dict/isRepeatDictId.action",
			data : $('#id').val(),
			success : function(data) {
				return data == "false";
			},
			onerror : "标识已经存在"
		});
		*/
		
		$("#value").formValidator({
			onfocus : "值不能为空"
		}).inputValidator({
			min : 1,
			max : 100,
			onerror : "不超过100个字符"
		});

		$("#pinyin").formValidator({
			onfocus : "请输入拼音全拼，例如：pinyin"
		}).inputValidator({
			min : 1,
			max : 100,
			onerror : "不超过100个字符"
		});
	});
</script>
</html>






