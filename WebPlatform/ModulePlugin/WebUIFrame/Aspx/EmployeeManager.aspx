<%--用户管理--%>
<%@ Page Language="C#"  %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>用户管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

    <link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/bootstrap/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/icon.css"/>
	<script type="text/javascript" src="../../../WebPlugin/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
    <script src="../../../WebPlugin/JQueryCommon2.0.js" type="text/javascript"></script>
    <script src="../JS/EmployeeManager.js" type="text/javascript"></script>
</head>
<body class="easyui-layout">
<%--初始化界面--%>
<div region="center" style="overflow:hidden;"  border="false">
			<div class="easyui-layout" fit="true" border="false">
			    <div id="tool1">
                    <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-reload" onclick="search_emp();">刷新</a>
                    <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="emp_add();">添加</a>
                    <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="emp_alter();">修改</a>
                    <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="emp_reset();">重置密码</a>
                </div>
                <div id="tool2">
                    科室：<input id="sdeptId" class="easyui-combobox" type="text" textField="Name" valueField="DeptId" style="width:200px;"></input>
                    姓名：<input id ="sempName" class="easyui-validatebox" type="text" name="Name" style="width:200px;"></input>
                    <input id ="btnSearch" type ="button" value ="查询" onclick ="search_emp();" />
                </div>
	            <table id="employeeGrid" idField="empid" toolbar="#tool1,#tool2" class="easyui-datagrid" fit="true" border="false"  singleSelect="true" pagination="true" fitColumns="true">
	                <thead>
			                <tr>
				                <%--<th field="empid" width="80">EmpId</th>
				                <th field="userid" width="80">UserId</th>--%>
				                <th field="Name" width="100" >姓名</th>
				                <th field="Code" width="100" >用户名</th>
				                <th field="SexText" width="100" >性别</th>
				                <th field="DeptName" width="200" >所在科室</th>
				                <th field="LockText" width="100" >用户是否禁用</th>
			                </tr>
	                </thead>
	            </table>
	        </div>
</div>
<%--弹出窗界面--%>
<div id="dialog-employee" class="easyui-dialog" icon="icon-save" style="background:#fafafa;padding:0px;width:400px;height:400px;" buttons="#dlg-buttons3" resizable="true" modal="true">
<form id="employeeform" method="post">
	<div id="employee-tabs" class="easyui-tabs" style="padding:1px;width:380px;height:310px;">
	 
    
        <div title="基本信息" iconCls="icon-reload" style="padding:2px;" fit="true" closable="false" >         
            <table>
		    <tr>
                <td><label>姓名:</label></td>
                <td><input class="easyui-validatebox" type="text" name="Name"  style="width:200px;" required="true"></input></td>
            </tr>
            <tr>
                <td><label>性别:</label></td>
                <td><input class="easyui-combobox"  type="text"  name="Sex"  style="width:200px;" valueField="Id"  textField="Name" url="Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetSexData" ></input></td>
            </tr>
            <tr>
                <td><label>所在科室:</label></td>
                <td><input id="defaultDeptid" class="easyui-combobox" textField="Name" valueField="DeptId" name="defaultDeptid" style="width:200px;"  required="true"></td>
            </tr>
            <tr>
                <td><label>是否删除:</label></td>
                <td><input id="Fempdel" type="checkbox"/></td>
            </tr>
            </table>
            <input id="HempId" type="hidden" name="EmpId" ></input>
            <input id="Hempdel" type="hidden" name="DelFlag" ></input>
        </div>
        <div title="用户" iconCls="icon-reload" style="padding:2px;" fit="true" closable="false" >
            <table>
		    <tr>
                <td><label>用户名:</label></td>
                <td><input class="easyui-validatebox" type="text" name="Code" style="width:200px;" required="true"></input></td>
            </tr>
            <tr>
                <td><label>角色:</label></td>
                <td><input id="groupIds" class="easyui-combobox"  type="text"  name="groupIds"  style="width:200px;" valueField="GroupId"  textField="Name" multiple="true" url="Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetGroupData" ></input></td>
            </tr>
            <tr>
                <td><label>是否禁用:</label></td>
                <td><input id="Flock" type="checkbox"/></td>
            </tr>
            </table>
            <input id="HUserId" type="hidden" name="UserId" ></input>
            <input id="Hlock" type="hidden" name="Lock" ></input>
       </div>   
       <div title="管辖科室" iconCls="icon-reload" style="padding:2px;" fit="true" closable="false" >
           <table id="empdeptGrid" idField="DeptId" class="easyui-datagrid" fit="true" border="false" fitColumns="true">
                 <thead>
	                    <tr>
	                        <th field="ck" checkbox="true"></th>
		                    <th field="DeptId" width="80">编码</th>
		                    <th field="Name" width="250" >科室名称</th>
	                    </tr>
                </thead>
            </table>
            <input id="HempdeptIds" type="hidden" name="empdeptIds" ></input>
       </div>
    </div>
</form>
</div>
<div id="dlg-buttons3">
    <a href="#" class="easyui-linkbutton" onclick="emp_save();">确定</a>
    <a href="#" class="easyui-linkbutton" onclick="$('#dialog-employee').dialog('close');">取消</a>
</div>
</body>
</html>


