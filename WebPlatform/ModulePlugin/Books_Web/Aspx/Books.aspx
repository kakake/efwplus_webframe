<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>书籍管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" type="text/css" href="/WebPlugin/jquery-easyui-1.4.2/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="/WebPlugin/jquery-easyui-1.4.2/themes/icon.css"/>
	<script type="text/javascript" src="/WebPlugin/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="/WebPlugin/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/WebPlugin/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
    <script src="/WebPlugin/JQueryCommon2.0.js" type="text/javascript"></script>
    <script src="../JS/Books.js" type="text/javascript"></script>
</head>
<body class="easyui-layout">
<div region="center" style="overflow:hidden;">
    <div id="grid-tool">
        <table cellpadding="0" cellspacing="0" style="width:100%">
			<tr>
				<td style="padding-left:2px">
				  <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="btn_add();">新增</a>
                  <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="btn_alter();">修改</a>
				</td>
				<td style="text-align:right;padding-right:2px">
					<input class="easyui-searchbox" data-options="prompt:'请输入书籍名称'" style="width:250px"></input>
				</td>
			</tr>
		</table>
    </div>
    <table id="bookGird"  class="easyui-datagrid" toolbar="#grid-tool" fit="true" border="false"  singleSelect="true">
         <thead>
            <tr>
	            <th field="Id" width="100">序号</th>
	            <th field="BookName" width="80">书籍名称</th>
	            <th field="BuyPrice" width="120">购书价格</th>
	            <th field="BuyDate" width="200">购书时间</th>
	            <th field="Flag" width="80">是否丢失</th>
            </tr>
        </thead>
   </table>
</div>

<%--弹出窗界面--%>
<div id="dialog-book" title="新增书籍" class="easyui-dialog" icon="icon-save" style="background:#fafafa;padding:10px;width:350px;height:250px;" buttons="#dlg-buttons1" resizable="true" modal="true">
    <form id="bookform" method="post">
        <table>
        <tr>
            <td><label>书籍名称:</label></td>
            <td><input name="BookName" class="easyui-validatebox" style="width:200px;" type="text"  required="true"></input></td>
        </tr>
        <tr>
            <td><label>购书价格:</label></td>
            <td><input name="BuyPrice" class="easyui-validatebox" style="width:200px;" type="text"  required="true"></input></td>
        </tr>
        <tr>
            <td><label>购书日期:</label></td>
            <td><input name="BuyDate" class="easyui-datebox" style="width:200px;" type="text"  required="true"></input></td>
        </tr>
        <tr>
            <td><label>是否丢失:</label></td>
            <td><input id="_flag" type="checkbox"/></td>
        </tr>
       </table>
       <input id="book_id" type="hidden" name="Id" ></input>
       <input id="book_flag" type="hidden" name="Flag" ></input>
    </form>
</div>
<div id="dlg-buttons1">
    <a href="#" class="easyui-linkbutton" onclick="btn_save();">确定</a>
    <a href="#" class="easyui-linkbutton" onclick="$('#dialog-book').dialog('close');">取消</a>
</div>
</body>
</html>
