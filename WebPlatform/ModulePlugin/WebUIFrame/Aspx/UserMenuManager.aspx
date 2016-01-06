
<%--角色权限管理--%>
<%@ Page Language="C#"  %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/bootstrap/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/icon.css"/>
	<script type="text/javascript" src="../../../WebPlugin/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>

    <script src="../../../WebPlugin/JQueryCommon2.0.js" type="text/javascript"></script>
    <script src="../JS/GroupMenuManager.js" type="text/javascript"></script>
</head>
<body class="easyui-layout">
<%--初始化界面--%>
 
<div region="west" title="角色列表" split="true" style="width:400px;padding:0px;">
    <div id="grid-tool">
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-reload" onclick="btn_binduser();">绑定用户</a>
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-reload" onclick="btn_showuser();">查看用户</a>
    </div>
    <table id="groupGrid" class="easyui-datagrid" fit="true" border="false" toolbar="#grid-tool" idField="GroupId" rownumbers="true" singleSelect="true" fitColumns="true">
        <thead>
                <tr>
                    <th field="GroupId" width="80">编码</th>
                    <th field="Name" width="150" >角色名称</th>                   
                    <th field="IsSuperAdmin" width="100" >是否超级用户</th>
                    <th field="Memo" width="100" >说明</th>
                </tr>
        </thead>
    </table>
</div>		
<div region="center"  title="维护权限菜单" >
    <div style="padding:0px;background:#EFEFEF;">
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="menugroup_save()">保存</a>
    </div>
    <ul id="GroupMenus" animate="true"></ul>
</div>	 

</body>

<div id="dlg-button" style="display:none">           
	<a id="dlg_save" href="#" class="easyui-linkbutton" onclick="dlg_save();">保存</a>
	<a id="dlg_delete" href="#" class="easyui-linkbutton" onclick="dlg_delete();">删除</a>
	<a href="#" class="easyui-linkbutton" onclick="$('#dlg-binduser').dialog('close');">取消</a>   
</div>
<div id="dlg-binduser" class="easyui-dialog" buttons="#dlg-button" title="绑定用户" style="width:400;height:400px;padding:0px" resizable="true" modal="true">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" >
            <div id="toolbar1" style="padding:2px 0">
		        <table cellpadding="0" cellspacing="0" style="width:100%">
			        <tr>
				        <td style="text-align:right;padding-right:2px">
					        <input class="easyui-searchbox" searcher="searchUser" prompt="输入用户名或姓名"></input>
				        </td>
			        </tr>
		        </table>
	        </div>
            <table id="userlistGird"  class="easyui-datagrid" toolbar="#toolbar1" fit="true" border="false" fitColumns="true" pagination="true">
	             <thead>
		            <tr>
		                <th field="ck" checkbox="true"></th>
			            <th field="empid" width="80">EmpId</th>
	                    <th field="userid" width="80">UserId</th>
	                    <th field="Name" width="100" >姓名</th>
	                    <th field="Code" width="100" >用户名</th>
	                    <th field="sex" width="100" >性别</th>
		            </tr>
	            </thead>
	       </table>
	       <input id="txtgroupId" type="hidden" />
        </div>
    </div>
</div>

</html>



