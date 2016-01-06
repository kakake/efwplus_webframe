/***********定义变量************/


/***********初始化入口**********/
$(function() {
	
});

/***********方法实现************/
function gethello(){
    $.ajax({
		type : "POST",
		url : "Controller.aspx?controller=WebTest01@HelloController&method=GetHello",
		data : {},
		success : function (msg) {
			var retobject = eval('(' + msg + ')');
			if (retobject.ret == 0) { //后台操作成功
				//
			} else {
			    //
			}
			if (retobject.msg != '') {
				//alert("结果: " + retobject.msg);
				$.messager.alert('提示', "结果: " + retobject.msg, 'info');
			}
		}
	});
}