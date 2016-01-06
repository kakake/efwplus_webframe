<%@ Page Language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="/WebPlugin/jquery-easyui-1.4.2/themes/bootstrap/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="/WebPlugin/jquery-easyui-1.4.2/themes/icon.css"/>
	<script type="text/javascript" src="/WebPlugin/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="/WebPlugin/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/WebPlugin/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
    <script src="/WebPlugin/JQueryCommon2.0.js" type="text/javascript"></script>
    <script language="JavaScript">
        function doSubmit() {
            //window.parent.ShowParentAppDialog({ title: '查看消息', width: 800, height: 600 }, '/ModulePlugin/SysMessage/PageUI/LookMessage.aspx');
            var newpasswd = $("#newpasswd").val();
            var newpasswd2 = $("#newpasswd2").val();
            if (newpasswd!= newpasswd2) {
                $("#newpasswd").val("");
                $("#newpasswd2").val("");
                $("#newpasswd").focus();
                $.messager.alert('提示', '输入的两个口令不一致，请重新输入！');
                return false;
            }
            FormSubmit($('#frmPost'), 'Controller.aspx?controller=LoggingController&method=ChangePassWord');
        }
    </script>
</head>
<body class="easyui-layout">
<div region="center" title="密码重置" style="overflow:hidden;" align="center">
<div class="easyui-panel"  
        style="width:500px;height:180px;padding:10px;" 
        align="center">
	
 <form id="frmPost" method="post">
 <table>
 <tr>
 <td><label>旧的口令</label></td>
 <td><input id="oldpasswd" name="oldpasswd" class="easyui-validatebox" style="width:200px;" type="password"  required="true"/></td>
 </tr>
 <tr>
 <td><label>新的口令</label></td>
 <td><input id="newpasswd" name="newpasswd" class="easyui-validatebox" style="width:200px;" type="password"  required="true"/></td>
 </tr>
 <tr>
 <td><label>再次确认新口令</label></td>
 <td><input id="newpasswd2" name="newpasswd2" class="easyui-validatebox" style="width:200px;" type="password"  required="true"/></td>
 </tr>
 </table>
 </form>
 
 <div class="toolbar">
    <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="doSubmit()">确 定</a>
    </div>
 </div>

	                
</div>
</body>
</html>
