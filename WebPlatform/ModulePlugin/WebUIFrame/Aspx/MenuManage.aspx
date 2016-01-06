<%--菜单维护--%>
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>菜单维护</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/bootstrap/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/icon.css"/>
	<script type="text/javascript" src="../../../WebPlugin/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>

    <script src="../../../WebPlugin/JQueryCommon2.0.js" type="text/javascript"></script>
    <script src="../JS/MenuManage.js" type="text/javascript"></script>
</head>
<body class="easyui-layout">

<div region="west" title="系统菜单" split="true" style="width:400px;padding:0px;">
    <div style="padding:0px;background:#EFEFEF;">
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-up" onclick="btn_treeup()">上移</a>
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-down" onclick="btn_treedown()">下移</a>
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-reload" onclick="btn_treereload()">刷新</a>
    </div>
    <ul id="menustree" animate="true"></ul>
</div>		
<div region="center"  title="编辑菜单" >
    <div style="padding:0px;background:#EFEFEF;">
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="btn_menuadd()">新增</a>
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="btn_menusave()">保存</a>
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-cancel" onclick="btn_menudel()">删除</a>
        
    </div>
    <form id="frmPost" method="post" style="padding:10px;">
    <div align="center">
         <table >
         <tr>
         <td><label>菜单名</label></td>
         <td><input name="Name" class="easyui-validatebox" style="width:300px;" type="text"  required="true"/></td>
         </tr>
         <tr>
         <td><label>Win程序集名</label></td>
         <td><input name="DllName" class="easyui-validatebox" style="width:300px;" type="text" /></td>
         </tr>
         <tr>
         <td><label>Win函数名</label></td>
         <td><input name="FunName" class="easyui-validatebox" style="width:300px;" type="text" /></td>
         </tr>
         <tr>
         <td><label>Web启动页面</label></td>
         <td><input name="UrlName" class="easyui-validatebox" style="width:300px;" type="text" /></td>
         </tr>
         <tr>
         <td><label>是否在Win工具栏显示</label></td>
         <td>
             <input id="cktoolbar" type="checkbox" /></td>
         </tr>
         <tr>
         <td><label>是否在首页显示</label></td>
         <td><input id="ckoutlookbar" type="checkbox" /></td>
         </tr>
          <tr>
         <td><label>首页显示图片路径</label></td>
         <td><input name="Image" class="easyui-validatebox" style="width:300px;" type="text" /></td>
         </tr>
         <tr>
         <td><label>首页显示备注</label></td>
         <td><input name="Memo" class="easyui-validatebox" style="width:300px;" type="text" /></td>
         </tr>
         <tr>
         <td><label>绑定SQL语句</label></td>
         <td><textarea name="BindSQL" style="width:300px; height:200px;"></textarea></td>
         </tr>
         </table>
     </div>
     <input id="MenuId" type="hidden" name="MenuId" />
     <input id="ModuleId" type="hidden" name="ModuleId" />
     <input id="PMenuId" type="hidden" name="PMenuId" />
     <input id="SortId" type="hidden" name="SortId" />
     <input id="toolbar" type="hidden" name="MenuToolBar" />
     <input id="outlookbar" type="hidden" name="MenuLookBar" />
    </form>
</div>
</body>
</html>
