//1.初始化入口
$(function () {
	fn_load_rootMenu();
	//fn_menuTree();
	fn_dialog_changeDept();

	//setInterval("getMessageCount()", 10000);
});

function getMessageCount() {
    /*
    requestAjax('Controller.aspx?controller=WebUIFrame@LoadingMenuController&method=GetNotReadMessageCount', {}, function (data) {
		$('#messageText').html(data);
	});
    */
}
//2.初始化界面展示方法
/*
function fn_menuTree() {
	$('#menuTree').tree({
		url : "Controller.aspx?controller=LoadingMenuController&method=LoadMenus",
		onClick : function (node) {
			$(this).tree('toggle', node.target);
			if (!node.attributes)
				return false;
			if (node.attributes && node.attributes.ismodule)
				return false;
			var url = node.attributes.opurl;
			var eventtypeid = node.id;
			if (typeof url == "undefined")
				return false;

			if (url.indexOf("/Index/") != -1) { //展示CMS前台页面，直接打开新页面
				default_url = encodeURI(url);
				window.open(default_url);
				return false;
			}

			if (url.indexOf("?") == -1)
				url += "?workId=" + workId;
			else
				url += "&workId=" + workId;

			url += "&empId=" + empId + "&userId=" + userId + "&deptId=" + deptId;
			if (sessionId != "")
				url += "&ASP.NET_SessionId=" + sessionId + "";

			//防止IE不刷新
			var datNow = new Date();
			var sRandom = datNow.getUTCFullYear() + datNow.getUTCMonth() +
				datNow.getUTCDate() + datNow.getUTCHours() + datNow.getUTCMinutes() +
				datNow.getMinutes() + datNow.getUTCSeconds() + datNow.getUTCMilliseconds();

			url += "&txtEventTypeID=" + eventtypeid + "&random=" + sRandom;

			if (url) {

				//var index=url.indexOf("?");
				//url=url.slice(index);
				//url="http://localhost:4864/Web_HIS/LoadPages.aspx"+url;
				default_url = encodeURI(url);
				window.open(default_url, "famRMain");
			}

		},
		onLoadSuccess : function (node, data) {
			$('#menuTree').tree('collapseAll');
		}
	});
}*/

function fn_dialog_changeDept() {

	$('#dialog_changeDept').dialog({
		modal : true,
		buttons : [{
				text : '确定',
				iconCls : 'icon-ok',
				handler : function () {
					FormSubmit($('#frmData'), 'Controller.aspx?controller=WebUIFrame@LoadingMenuController&method=ChangeDept', function () {
						$('#dialog_changeDept').dialog('close');
						window.location.href = 'Login.aspx';
					});
				}
			}, {
				text : '取消',
				handler : function () {
					$('#dialog_changeDept').dialog('close');
				}
			}
		]
	});

	$('#dialog_changeDept').dialog('close');
}

function selectModule(val) {

	var moduleId = val;
	$('.top_menu').removeClass("on");
	$('#_M' + moduleId).addClass("on");
	requestAjax('Controller.aspx?controller=WebUIFrame@LoadingMenuController&method=GetLoginFirstMenu', {
		ModuleId : moduleId
	}, function (data) {
		var menudata = data;
		var _html = '<div class="easyui-accordion" fit="true" border="false">';
		for (var i = 0; i < menudata.length; i++) { //添加一级菜单
			_html += '<div title="' + menudata[i].FirstMenu.Name + '" iconCls="icon-reload" style="overflow:auto;">';
			_html += '<ul>';
			for (var k = 0; k < menudata[i].SecondMenu.length; k++) { //添加二级菜单
				_html += '<li><div><a target="famRMain" href="/' + menudata[i].SecondMenu[k].UrlName + '"><span class="icon icon-nav" ></span>' + menudata[i].SecondMenu[k].Name + '</a></div></li> ';
			}
			_html += '</ul></div>';
		}
		_html += '</div>';
		$('#menuDiv').empty(); //先清空
		$('#menuDiv').append(_html); //
		$('.easyui-accordion li a').click(function () {
			var menu_name = $(this).text();
			$('#current_page').html(menu_name);
			$('.easyui-accordion li div').removeClass("selected");
			$(this).parent().addClass("selected");
		}).hover(function () {
			$(this).parent().addClass("hover");
		}, function () {
			$(this).parent().removeClass("hover");
		});

		$.parser.parse($('#menuDiv')); //重新渲染

	});
}

function fn_load_rootMenu() {
	requestAjax('Controller.aspx?controller=WebUIFrame@LoadingMenuController&method=GetLoginModuleData', {}, function (data) {
		var moduledata = data;
		var _html = '<div class="log white cut_line" style="height:40px;"></div><ul class="nav white ">';
		for (var i = moduledata.length - 1; i > 0; i--)
			{
			_html += '<li id="_M' + moduledata[i].ModuleId + '" class="top_menu"><a href="#" hidefocus="true" style="outline:none;"  name="' + moduledata[i].ModuleId + '" onclick="selectModule(' + moduledata[i].ModuleId + ');"> ' + moduledata[i].Name + '</a></li>';
		}
		_html += '<li id="_M' + moduledata[0].ModuleId + '" class="on top_menu"><a href="#" hidefocus="true" style="outline:none;" name="' + moduledata[0].ModuleId + '" onclick="selectModule(' + moduledata[0].ModuleId + ');"> ' + moduledata[0].Name + '</a></li>';
		_html += '</ul>';

		$('#moduleDiv').append(_html); //加载模块

		selectModule(moduledata[0].ModuleId);
	});
}

function fn_backpage() {

	$('#current_page').html("");
}

function MessageRequest() {
	alert((new Date()).toString());
}

//4.页面方法
