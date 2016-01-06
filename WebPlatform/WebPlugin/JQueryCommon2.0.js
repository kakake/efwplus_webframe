
/** *  页面加载等待页面 * * @author zenghao * @date 2012/7/6 * */
var _html = "<div id='loading' style='position:absolute;left:0;width:100%;height:100%;top:0;background:#fff;'><div style='position:absolute;	cursor1:wait;left:5px;top:5px;width:auto;height:18px;background:#fff no-repeat;border:2px solid #ccc;color:#000;font-size:12px;'>\ 正在加载，请等待...\ </div></div>";
window.onload = function() {
    var _mask = document.getElementById('loading');
    _mask.parentNode.removeChild(_mask);
    if (top) { closeProgress(); }
}
document.write(_html);

function closeProgress() {
    try {
        if (top.progressFlag == 1) {
            top.Dialog.close();
            top.progressFlag = 0;
        }
        else if (top.progressFlag == 2) {
            top.hideSimpleProgress();
            top.progressFlag = 0;
        }
    }
    catch (e) { }
}

var _date = new Date(); //获取当前日期
var datenow = _date.getFullYear() + '-' + (_date.getMonth() + 1) + '-' + _date.getDate();

var PFun = window.parent;
var PdlgFun = window.parent.IframeApp;
function PdlgShow(dlgParams, url) {
	if (PdlgFun) {
		PFun.ShowParentAppDialog(dlgParams, url);
	} else {
		if ($("#IframeApp").length == 0) {
			var _html = '<div id="dialog-parentApp" class="easyui-dialog" icon="icon-edit" style="background:#fafafa;padding:0px;width:900px;height:550px; overflow:hidden;" resizable="true" modal="true"><iframe id="IframeApp" name="IframeApp" src="#" width="100%" height="100%" frameborder="0" scrolling="no"></iframe></div>';
			$("body").after(_html);
		}
		if (url)
			$('#IframeApp').attr('src', url);

		if (dlgParams)
			$('#dialog-parentApp').dialog(dlgParams);
		else
			$('#dialog-parentApp').dialog('open');

	}
}

function test() {
	alert('ok');
}

function PdlgClose(callbackfun) {
	if (PFun) {
		$('#dialog-parentApp').dialog('close');
		if (callbackfun)
			eval(callbackfun + '();');
	}
}

//********************************************************************************************
function simpleAjax(requestUrl, requestData, callback) {
	$.ajax({
		type : "POST",
		url : requestUrl,
		data : requestData,
		success : function (msg) {
			if (msg == "fail") {
				alert("命令验证失败！");
				//$.messager.alert('提示', "结果: 命令验证失败！", 'info');
				return;
			} else if (msg == "error") {
				alert("命令格式错误！");
				//$.messager.alert('提示', "结果: 命令格式错误！", 'info');
				return;
			} else if (msg == "exception") {
				alert("命令执行异常！");
				//$.messager.alert('提示', "结果: 命令执行异常！", 'info');
				return;
			} else {
				var data = eval('(' + msg + ')');
				
				if(data.ret==1)
				{
					alert("返回错误："+data.msg);
				}
				if (callback)
					callback(data, msg);
					
			}
		}
	});
}

//异步请求
function requestAjax(requestUrl, requestData, callback, errcallback) {
	$.ajax({
		type : "POST",
		url : requestUrl,
		data : requestData,
		success : function (msg) {
			var retobject = eval('(' + msg + ')');
			if (retobject.ret == 0) { //后台操作成功
				if (callback)
					callback(retobject.data);
			} else {
				if (errcallback)
					errcallback();
			}
			if (retobject.msg != '') {
				//alert("结果: " + retobject.msg);
				$.messager.alert('提示', "结果: " + retobject.msg, 'info');
			}
		}
	});
}
//Form提交数据
function formSubmit(formId, url, callback) {
	$(formId).form('submit', {
		url : url,
		onSubmit : function () {
			return $(formId).form("validate");
		},
		success : function (msg) {
			var retobject = eval('(' + msg + ')');
			if (retobject.ret == 0) { //后台操作成功
				if (callback)
					callback(retobject.data);
			}
			if (retobject.msg != '') {
				$.messager.alert('提示', "结果: " + retobject.msg, 'info');
			}
		}
	});
}

function formValidate(id) {
	var box = $(id + ' .validatebox-text');

	if (box.length) {
		box.validatebox("validate");
		box.trigger("blur");

		var ret = $('#' + id + ' .validatebox-invalid:first').focus();
		if (ret.length != 0)
			return false;
	}

	return true;
}

//键盘监听
function webpageKey(id) {
	$(window).keydown(function (event) {
		var currentRowIndex = $(id).datagrid("getRowIndex", $(id).datagrid("getSelected"));
		switch (event.keyCode) {
		case 38:
			$(id).datagrid("unselectAll");
			var allLins = $(id).datagrid("getRows").length;
			currentRowIndex = currentRowIndex == 0 ? allLins : currentRowIndex - 1;
			$(id).datagrid("selectRow", currentRowIndex);
			break;
		case 40:
			$(id).datagrid("unselectAll");
			var allLins = $(id).datagrid("getRows").length;
			currentRowIndex = currentRowIndex == allLins ? 0 : currentRowIndex + 1;
			$(id).datagrid("selectRow", currentRowIndex);
			break;
		}
	});
}

function parseParam(param, key) {
	var paramStr = "";
	if (param instanceof String || param instanceof Number || param instanceof Boolean) {
		paramStr += "&" + key + "=" + encodeURIComponent(param);
	} else {
		$.each(param, function (i) {
			var k = key == undefined ? i : key + (param instanceof Array ? "[" + i + "]" : "." + i);
			paramStr += "&" + parseParam(this, k);
		});
	}
	return paramStr.substr(1);
}

function jsonTostr(obj) {
	var arr = [];
	var fmt = function (s) {
		if (typeof s == 'object' && s != null)
			return jsonTostr(s);
		//return /^(String|Number)$/.test(typeof s)?"'"+s+"'":s;
		return s;
	}
	//for(var i in obj)arr.push("'"+i+"':"+fmt(obj[i]));
	for (var i in obj)
		arr.push(i + ":" + fmt(obj[i]));
	return '{' + arr.join(',') + '}';
}
