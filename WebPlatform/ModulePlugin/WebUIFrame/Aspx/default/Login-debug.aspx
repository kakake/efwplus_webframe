<%@ Page Language="C#" %>

<!DOCTYPE html "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<title></title>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/zh-cn-system.css" rel="stylesheet" type="text/css" />
<link href="css/maineasyui.css" rel="stylesheet" type="text/css" />


<link rel="stylesheet" type="text/css" href="/WebPlugin/jquery-easyui-1.4.2/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="/WebPlugin/jquery-easyui-1.4.2/themes/icon.css"/>
<script type="text/javascript" src="/WebPlugin/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="/WebPlugin/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/WebPlugin/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
<script src="/WebPlugin/JQueryCommon2.0.js" type="text/javascript"></script>


<script src="Login-debug.js" type="text/javascript"></script>



<script type="text/javascript">

var default_url;

var empId = '0';
var userId = '0';
var deptId = '0';
var workId = '0';
var empName='调试用户';
var deptName = '调试科室';
var workName = '调试机构';

// 显示任务

function welcome() {
    $('#famRMain').attr('src', 'task.aspx');
}

function changepassword() {
    $('#famRMain').attr('src', '/ModulePlugin/WebUIFrame/Aspx/SetPassWord.aspx');
}

// 退出
function doQuit()
{
    document.location = "/ModulePlugin/WebUIFrame/Aspx/LogOff.aspx";
}


function OpenDefaultUrl() {
    if(default_url!=null)
        window.open(default_url, 'newwindow', 'toolbar=no,resizable=yes ,menubar=no,location=n o, status=no')
}

function ChargeDept() {
    $('#dialog_changeDept').dialog('open');
}


function showMessage(){
    ShowParentAppDialog({title:'查看消息'},'/ModulePlugin/SysMessage/PageUI/LookMessage.aspx');
}

</script>
<style>
.tree {
    font-size:14px;
}
.bold
{
	font-weight:bold;
}
.accord{font-size:12px; font-family:Tahoma,Verdana,微软雅黑,新宋体}
a{ color:Black; text-decoration:none;}
a:hover{ color:Red; text-decoration:underline;}
.easyui-accordion ul{list-style-type:none;margin:0px; padding:10px;}
.easyui-accordion ul li{ padding:0px;}
.easyui-accordion ul li a{line-height:24px;}
.easyui-accordion ul li div{margin:2px 0px;padding-left:10px;padding-top:2px;}
.easyui-accordion ul li div.hover{border:1px dashed #99BBE8; background:#E0ECFF;cursor:pointer;}
.easyui-accordion ul li div.hover a{color:#416AA3;}
.easyui-accordion ul li div.selected{border:1px solid #99BBE8; background:#E0ECFF;cursor:default;}
.easyui-accordion ul li div.selected a{color:#416AA3; font-weight:bold;}

.icon{padding:2px 9px; background:url(images/tabicons.png) no-repeat; }
.icon-nav{background-position: -100px -20px;}
</style>

</HEAD>
<BODY class="easyui-layout" >
 <div region="north" style="overflow: hidden; height: 92px; line-height: 20px;color: #fff;">
		<div class="header">
			<div class="logo lf"></div>
		    <div class="rt-col">
		    	<div class="tab_style white cut_line text-r">
				您好,调试用户<span>| </span><a href="#" onclick="showMessage();">消息<label id="messageText" style="color:Red"></label></a><span> | </span><a href="#" onclick="changepassword();" id="editpass">修改密码</a><span> | </span><a href="#" onclick="doQuit();"><img src="images/lockscreen.png" border=0>[退出]</a>
		        </div>
		    </div>
		    <div class="col-auto" id="moduleDiv">
		    </div>
		</div>
	</div>
<div region="west" title="二级菜单导航"  split="true" style="width:210px;padding:0px;"  border="false" >
    <div class="easyui-layout" fit="true" style="background:#ccc;" border="false" >
      <div  region="center" id="menuDiv"  border="false"   style="overflow:hidden;"  class="accord" >
    </div>
</div>
</div>
 <div region="center">
 <div  class="easyui-layout" border="false" fit="true">
    <div region="north" border=false style="height:30px;overflow:hidden;"> 
         <div class="home">当前位置：<a target="famRMain" href="task.aspx" onclick="fn_backpage();">回主界面</a> > <label id="current_page">当前页面</label></div>
    </div>
  
    <div id="main" region="center" border="false" style="overflow:hidden;">
       <iframe id="famRMain" name="famRMain" frameborder="no" height="100%" width="100%" src="task.aspx" scrolling="yes"></iframe>
    </div>
   </div>
</div>
    <!-- window开始 -->
<div id="dialog_changeDept" title="切换部门" icon="icon-save" style="background:#fafafa;padding:10px;width:350px;height:200px;">    
     <form id="frmData" method="post">
      <table>
        <tr>
        <td>用户名称</td>
        <td >调试用户</td>
        </tr>
        <tr>
        <td>部门名称</td>
        <td></td>
        </tr>
      </table>
      </form>
</div>
 <!-- window结束 -->
<%--<script language="javascript">
    $(function() {
        $('#dialog-parentApp').dialog('close');
    });

    function ShowParentAppDialog(dlgobj, url) {
        $('#IframeApp').empty();
        if (url)
            $('#IframeApp').attr('src', url);

        if (dlgobj)
            $('#dialog-parentApp').dialog(dlgobj);
        else
            $('#dialog-parentApp').dialog('open');

    }

    function PdlgClose(callbackfun) {
        $('#dialog-parentApp').dialog('close');
        if (callbackfun)
            eval('window.famRMain.' + callbackfun + '();');
    }
</script>
<div id="dialog-parentApp" class="easyui-dialog" icon="icon-edit" style="background:#fafafa;padding:0px;width:900px;height:550px; overflow:hidden;" resizable="true" modal="true">  
    <iframe id="IframeApp" name="IframeApp" src="#" width="100%" height="100%" frameborder="0" scrolling="yes"></iframe>
</div>--%>
</BODY>
</HTML>