//初始化入口
$(function() {
    $('#dialog-dept').dialog('close');
    $('#dialog-searchEmployee').dialog('close');
    $('#dialog-employee').dialog('close');

    fn_layertreeInit();
    fn_deptInit();
    
});

//科室
function fn_layertreeInit() {
    $('#deptLayerTree').tree({
        url: "Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetDeptLayers",
        onDblClick: function(node) {
            $('#deptLayerTree').tree('beginEdit', node.target);
        },
        onClick: function(node) {
            var children = $('#deptLayerTree').tree('getChildren', node.target);
            var s = node.id;
            for (var i = 0; i < children.length; i++) {
                if (s != '') s += ',';
                s += children[i].id;
            }
            $('#deptGrid').datagrid('options').url = 'Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=SearchDeptData&layerId=' + s;
            $('#deptGrid').datagrid('reload');
        },
        onAfterEdit: function(node) {
            var parent = $('#deptLayerTree').tree('getParent', node.target);
            var data = { LayerId: node.id, Name: node.text, PId: parent ? parent.id : 0 };
            requestAjax("Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=SaveDeptLayer", data);
            $('#txtclass').combotree('reload');
        }
    });
}

function deptlayer_append() {
    var node = $('#deptLayerTree').tree('getSelected');
    if (node) {
        var para = { LayerId: 0, PId: node.id, Name: '新建分类' };
        requestAjax('Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=SaveDeptLayer', para, function (data) {
            $('#deptLayerTree').tree('append', {
                parent: (node ? node.target : null),
                data: [{ id: data, text: '新建分类' }]
            });
            fn_deptInit();
        });
    }
    else {
        $.messager.alert('提示', "请选节点" , 'info');
    }
}

function deptlayer_delete() {
    var node = $('#deptLayerTree').tree('getSelected');
    if (node) {
        $.messager.confirm('询问', '是否删除?', function(r) {
            if (r) {
                var data = { deptLayerId: node.id };
                requestAjax("Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=DeleteDeptLayer", data, function(retobject) {
                    $('#deptLayerTree').tree('reload');
                    fn_deptInit();
                });
             }
        });
    }
}
    
function fn_deptInit() {
    $('#deptGrid').datagrid('options').onDblClickRow=function(){
        dept_alter();
    }
}

function dept_refresh(){
    $('#deptGrid').datagrid('reload');
}

function dept_add(){
    $('#dialog-dept').dialog({ title: '添加科室' });
    $("#deptform").form('clear');
}

function dept_alter(){
    
    var selected = $('#deptGrid').datagrid('getSelected');
    if (selected) {
        $('#dialog-dept').dialog({ title: '修改科室' });
        $("#deptform").form("load", selected);
        if (selected.DelFlag == "1")
            $("#_DeleteBit").attr("checked", "true");
        else
            $("#_DeleteBit").removeAttr("checked"); 
    }
    else {
        $.messager.alert('提示', "请选数据行", 'info');
    }
}

function dept_save(){
    var check=$("#_DeleteBit").attr("checked");
    check=check=="checked"?1:0;
    $('#DeleteBit').val(check);
    formSubmit('#deptform', 'Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=SaveDept', function() {
                        $('#dialog-dept').dialog('close');
                        dept_refresh();
                    });
}