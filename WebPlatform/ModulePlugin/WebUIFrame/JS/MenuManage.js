//初始化入口
$(function() {
    fn_InitCheckBox();
    $('#menustree').tree({
        url: "Controller.aspx?controller=WebUIFrame@MenuManageController&method=GetMenuTree",
        onClick: function(node) {
            $(this).tree('toggle', node.target);
            if (node.attributes && node.attributes.ismodule) return false;

            requestAjax('Controller.aspx?controller=WebUIFrame@MenuManageController&method=SelectMenuManage', { menuId: node.id }, function(data) {
                $("#frmPost").form("load", data);

                if (data.MenuToolBar == "1")
                    $("#cktoolbar").attr("checked", "true");
                else
                    $("#cktoolbar").removeAttr("checked");

                if (data.MenuLookBar == "1")
                    $("#ckoutlookbar").attr("checked", "true");
                else
                    $("#ckoutlookbar").removeAttr("checked");
            });
        },
        onLoadSuccess: function(node, data) {
            //$('#menustree').tree('collapseAll');
        }
    });

});
function btn_treeup(){
    var selected=$('#menustree').tree('getSelected');
    if(selected){
        if(selected.attributes && selected.attributes.ismodule){
             requestAjax('Controller.aspx?controller=WebUIFrame@MenuManageController&method=SortModuleUp', { moduleid: selected.id }, function(data) {
                    $('#menustree').tree('reload');
                });
        }else{
             requestAjax('Controller.aspx?controller=WebUIFrame@MenuManageController&method=SortMenuUp', { menuid: selected.id }, function(data) {
                    $('#menustree').tree('reload');
                });
        }
    }
}
function btn_treedown(){
    var selected=$('#menustree').tree('getSelected');
    if(selected){
        if(selected.attributes && selected.attributes.ismodule){
             requestAjax('Controller.aspx?controller=WebUIFrame@MenuManageController&method=SortModuleDown', { moduleid: selected.id }, function(data) {
                    $('#menustree').tree('reload');
                });
        }else{
             requestAjax('Controller.aspx?controller=WebUIFrame@MenuManageController&method=SortMenuDown', { menuid: selected.id }, function(data) {
                    $('#menustree').tree('reload');
                });
        }
    }
}
function btn_treereload(){
    $('#menustree').tree('reload');
}
function btn_menuadd(){
    var node=$('#menustree').tree('getSelected');
    if(node){
        if(node.attributes && node.attributes.ismenu){
            $.messager.alert('提示', "菜单下不能添加子菜单!", 'info');
            return false;
        }
        $("#frmPost").form("clear");
        $("#MenuId").val(0);
        $("#ModuleId").val(node.attributes.moduleid);
        $("#PMenuId").val(node.attributes.ismodule?-1:node.id);
        $("#SortId").val($('#menustree').tree('getChildren',node.target)?$('#menustree').tree('getChildren',node.target).length:-1);
    }
}
function btn_menusave(){
    formSubmit($('#frmPost'), 'Controller.aspx?controller=WebUIFrame@MenuManageController&method=SaveMenu', function () {
        $('#menustree').tree('reload');
    });
}
function btn_menudel(){
    var selected=$('#menustree').tree('getSelected');
    if(selected){
        if(selected.attributes && selected.attributes.ismodule){
            $.messager.alert('提示', "模块不能删除!", 'info');
            return false;
        }
        $.messager.confirm('询问', '是否真的需要删除选定菜单?', function(r) {
            if (r) {
                requestAjax('Controller.aspx?controller=WebUIFrame@MenuManageController&method=DeleteMenu', { menuId: selected.id }, function(data) {
                    $('#menustree').tree('reload');
                });
            }
        });
    }
}

function fn_InitCheckBox() {
    $("#cktoolbar").click(function() {
        if ($("#cktoolbar").attr("checked")) {
            $("#toolbar").val(1);
        }
        else {
            $("#toolbar").val(0);
        }
    });
    $("#ckoutlookbar").click(function() {
        if ($("#ckoutlookbar").attr("checked")) {
            $("#outlookbar").val(1);
        }
        else {
            $("#outlookbar").val(0);
        }
    });
}
