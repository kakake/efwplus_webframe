<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>机构维护</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/bootstrap/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/icon.css"/>
	<script type="text/javascript" src="../../../WebPlugin/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
    <script src="../../../WebPlugin/JQueryCommon2.0.js" type="text/javascript"></script>
    <script src="../JS/WorkerSetup.js" type="text/javascript"></script>
</head>
<body class="easyui-layout">
<div region="center" style="overflow:hidden;">
    <div id="grid-tool">
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="btn_start();">启用</a>
    </div>
    <table id="worklistGird"  class="easyui-datagrid" toolbar="#grid-tool" fit="true" border="false"  singleSelect="true">
         <thead>
            <tr>
	            <th field="WorkId" width="100">机构号</th>
	            <th field="WorkNo" width="80">机构编码</th>
	            <th field="WorkName" width="120">机构名称</th>
	            <th field="Memo" width="200">机构描述</th>
	            <th field="DelFlag" width="80">标识</th>
            </tr>
        </thead>
   </table>
</div>
</body>
</html>
