/***********定义变量************/
var baseurl_init = "Controller.aspx?controller=IotPlatform@RaspberryPiController&method=GetRaspberryPiList";
var baseurl_send = "Controller.aspx?controller=IotPlatform@RaspberryPiController&method=SetRaspberryPiData";
var baseurl_get = "Controller.aspx?controller=IotPlatform@RaspberryPiController&method=GetRaspberryPiData";
var baseurl_getall = "Controller.aspx?controller=IotPlatform@RaspberryPiController&method=GetRaspberryPiDataAll";

/***********初始化入口**********/
$(function () {
    $('#output').empty();
    //initdata();
    window.setInterval(initdata, 2000);
});

function initdata() {
    GetAjax(baseurl_init, function (data) {
        $('#pilist').empty();
        $('#pidev').empty();
        var host = $('#hostid').val();
        var dkey = $('#devid').val();
        if (data.dicPiList) {
            $.each(data.dicPiList, function (i, n) {//n[0]名称 n[1]在线/掉线 n[2]时间
				var cls=(i == host ? " active" : "") + (n[1] == "0" ? " disabled" : "");
                $('#pilist').append('<a href="javascript:void();" class="list-group-item '+cls+'" value=' + i + ' data='+n[1]+'>' + '[' + (n[1] == "0" ? "掉线" : "在线") + ']' + n[0] + '</a>')
            });
            $('#pilist').find('a').click(function () {
				if($(this).attr('data')=="1"){
					$('#pilist').find('a').removeClass('active');
					$(this).addClass('active');
					$('#hostid').val($(this).attr('value'));
				}
            });
        }
        if (data.dicPiDev) {
            $.each(data.dicPiDev, function (i, n) {
                $('#pidev').append('<a href="javascript:void();" class="list-group-item ' + (i == dkey ? " active" : "") + '" value=' + i + '>' + n + '</a>')
            });
            $('#pidev').find('a').click(function () {
                $('#pidev').find('a').removeClass('active');
                $(this).addClass('active');
                $('#devid').val($(this).attr('value'));
            });
        }


    });
}
/***********方法实现************/
function setpidata() {
	try{
		var host = $('#hostid').val();
		var dkey = $('#devid').val();
		var data=$('#cmdtext').val();
		data= JSON.parse(data);
		data=JSON.stringify(data);
	}catch(err){
		var txt="此页面存在一个错误。\n\n";
		txt+="错误描述: 输入的内容不是正确的JSON字符串\n\n";
		showmsg(1,txt);
		return;
	}
	if (host=="") {
		showmsg(1,"请先选择树莓派主机");
		return;
	}
	if (dkey=="") {
		showmsg(1,"请先选择主机设备");
		return;
	}
	if (data == "") {
		showmsg(1,"发送数据不能为空");
		return;
	}
	var url = baseurl_send + "&authkey=" + host + "&dkey=" + dkey;
	var data = { data: data };
	showmsg(0,"sending to Pi.");
	PostAjax(url, data, function (data) {
		//getpidata();
	});
	
}

function getpidata() {
    var host = $('#hostid').val();
    var dkey = $('#devid').val();
    var url = baseurl_get + "&authkey=" + host + "&dkey=" + dkey;
    GetAjax(url, function (data) {
        var text = JSON.stringify(data);
        if (text != '{}') {
            $('#output').prepend('<p><span>' + JSON.stringify(data) + '</span></p>');
        }
    });
}
function getpidataall() {
    var host = $('#hostid').val();
    var dkey = $('#devid').val();
    var url = baseurl_getall + "&authkey=" + host + "&dkey=" + dkey;
    GetAjax(url, function (data) {
        var text = JSON.stringify(data);
        if (text != '{}') {
            $('#output').prepend('<p><span>' + JSON.stringify(data) + '</span></p>');
        }
    });
}
var time1;
function startoutput(n) {
    if ($(n).attr('value') == "0") {
        var host = $('#hostid').val();
        var dkey = $('#devid').val();
        if (host == "") {
            showmsg(1,"请先选择树莓派主机");
            return;
        }
        if (dkey == "") {
            showmsg(1,"请先选择主机设备");
            return;
        }
        time1 = window.setInterval(getpidata, 1000);
        $(n).attr('value', 1);
        $(n).text("停止");
    } else {
        window.clearInterval(time1);
        $(n).attr('value', 0);
        $(n).text("启动");
    }
}

function clearoutput() {
    $('#output').empty();
}

function alloutput() {
    var host = $('#hostid').val();
    var dkey = $('#devid').val();
    if (host == "") {
        showmsg(1,"请先选择树莓派主机");
        return;
    }
    if (dkey == "") {
        showmsg(1,"请先选择主机设备");
        return;
    }
    getpidataall();
}
/***********公共方法************/
function showmsg(flag,txt){
	if (txt != '') {
		if (flag == 0) { //后台操作成功
			//alert("结果: " + txt);
			$('#showmsg').removeClass("msg-fontcolor-red msg-fontcolor-blue").addClass("msg-fontcolor-blue").html(txt);
		}else{
			//alert("结果: " + txt);
			$('#showmsg').removeClass("msg-fontcolor-red msg-fontcolor-blue").addClass("msg-fontcolor-red").html(txt);
		}
	}
}

function simpleAjax(requestUrl) {
    $.ajax({
        type: "GET",
        url: requestUrl,
        success: function (msg) {
            var retobject = eval('(' + msg + ')');
			showmsg(retobject.ret,retobject.msg)
        }
    });
}

function GetAjax(requestUrl, callback) {
    $.ajax({
        type: "GET",
        url: requestUrl,
        success: function (msg) {
            var retobject = eval('(' + msg + ')');
            if (retobject.ret == 0) { //后台操作成功
                if (callback)
                    callback(retobject.data);
            }
            showmsg(retobject.ret,retobject.msg)
        }
    });
}

function PostAjax(requestUrl, requestData, callback) {
    $.ajax({
        type: "POST",
        url: requestUrl,
        data: requestData,
        success: function (msg) {
            var retobject = eval('(' + msg + ')');
            if (retobject.ret == 0) { //后台操作成功
                if (callback)
                    callback(retobject.data);
            }
            showmsg(retobject.ret,retobject.msg)
        }
    });
}