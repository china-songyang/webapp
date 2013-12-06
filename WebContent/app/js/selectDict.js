(function ($) {
	$.fn.selectDict = function(options) { 
		var opt = {
			action:'/app/system/dict/listDictByTypeForClient.do',
			type:'',
			id:'',
			value:''
		};
		var ops = $.extend(opt,options);
		$.post(saturnServerPath + ops.action, 
	       {type: ops.type},
	       function(json, textStatus){
		        var code = '<option value=""></option>';
	            var num = json.length;
	            for(i=0; i<num; i++){
	           		if(ops.value==json[i].id){
		           		 code += '<option value="' + json[i].id +'" selected>'+json[i].text +'</option>';
	           		}else{
		           		 code += '<option value="' + json[i].id +'">'+json[i].text +'</option>';
	           		}							       
	            }
	            $('#'+ops.id).html(code);
	       }, 
	       "json");
	}
})(jQuery);
