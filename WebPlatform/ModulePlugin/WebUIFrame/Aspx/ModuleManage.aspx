<%--科室管理--%>
<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>科室管理</title>
    <link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/bootstrap/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/icon.css"/>
	<script type="text/javascript" src="../../../WebPlugin/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
    <script src="../../../WebPlugin/JQueryCommon2.0.js" type="text/javascript"></script>
    <script src="../JS/DeptManager.js" type="text/javascript"></script>
</head>
<body class="easyui-layout">
<%--初始化界面--%>
<div region="center" style="overflow:hidden;"  border="false">
		<div class="easyui-layout" fit="true" border="false">
            <div region="west" split="true" title="科室类别" style="width:400px;padding:0px;" border="false">
	            <div style="padding:0px;background:#EFEFEF;">
		            <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-reload" onclick="deptlayer_refresh()">刷新</a>
		            <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="deptlayer_append()">添加</a>
		            <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-cancel" onclick="deptlayer_delete()">删除</a>
	            </div>
	            <ul id="deptLayerTree" animate="true"></ul>
	        </div>	 
	        <div region="center" title="科室列表" border="false">
	            <div id="tool1">
                    <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="dept_add();">添加</a>
                    <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="dept_alter();">修改</a>
                </div>
	            <table id="deptGrid" idField="DeptId" toolbar="#tool1" class="easyui-datagrid" fit="true" border="false"  singleSelect="true" pagination="true" fitColumns="true">
	                <thead>
			                <tr>
				                <th field="DeptId" width="80">编码</th>
				                <th field="Name" width="250" >科室名称</th>
				                <th field="DelFlagText" width="100" >是否停用</th>
			                </tr>
	                </thead>
	            </table>
	        </div>			
		</div>
</div>
<%--弹出窗界面--%>

<div id="dialog-dept" class="easyui-dialog" icon="icon-save" style="background:#fafafa;padding:0px;width:400px;height:400px;" buttons="#dlg-buttons1" resizable="true" modal="true"> 
    <form id="deptform" method="post">        
            <table>
	            <tr>
                    <td><label>名称:</label></td>
                    <td><input class="easyui-validatebox" type="text" name="Name" required="true" style="width:200px;"></input></td>
                </tr>
                <tr>
                    <td><label>分类:</label></td>
                    <td><input id="txtclass" class="easyui-combotree" name="Layer"  style="width:200px;" url="Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetDeptLayers" required="true">
                </tr>
                <tr>
                    <td><label>是否停用:</label></td>
                    <td><input id="_DeleteBit" type="checkbox" name="_DeleteBit"/></td>
                </tr>
                </table>
            <input id="DeptId" type="hidden" name="DeptId" ></input>
            <input id="DeleteBit" type="hidden" name="DelFlag" value="0"></input>
    </form>
</div>
<div id="dlg-buttons1">
    <a href="#" class="easyui-linkbutton" onclick="dept_save();">确定</a>
    <a href="#" class="easyui-linkbutton" onclick="$('#dialog-dept').dialog('close');">取消</a>
</div>
</body>
</html>
