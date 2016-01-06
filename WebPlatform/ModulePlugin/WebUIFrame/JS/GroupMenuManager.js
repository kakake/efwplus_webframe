//初始化入口
$(function() {

    fn_menuTree();
    fn_groupGrid();
    
    $('#dlg-binduser').dialog('close');
});

//2.初始化界面展示方法
function fn_menuTree() {
    $('#GroupMenus').tree({
    checkbox: true,
    url: "Controller.aspx?controller=WebUIFrame@GroupMenuController&method=GetGroupMenu&groupId=-1",
        
        onClick: function(node) {
            $(this).tree('toggle', node.target);
        },
        onLoadSuccess:function(node,data){
            $('#GroupMenus').tree('collapseAll');
        }
    });
}

function fn_groupGrid() {
    $('#groupGrid').datagrid('options').url='Controller.aspx?controller=WebUIFrame@GroupMenuController&method=GetGroupList';
    $('#groupGrid').datagrid('reload');
    
    $('#groupGrid').datagrid('options').onSelect=function(rowIndex, rowData) {
        var selected = rowData;
        if (selected) {
            $('#GroupMenus').tree('options').url="Controller.aspx?controller=WebUIFrame@GroupMenuController&method=GetGroupMenu&groupId="+selected.GroupId;
            $('#GroupMenus').tree('reload');
        }
    }
}


//4.页面方法
function menugroup_save(){
    var selected = $('#groupGrid').datagrid('getSelected');
    if (selected) {
        var nodes = $('#GroupMenus').tree('getChecked');
        var s = '';
			for(var i=0; i<nodes.length; i++){
			if(nodes[i].attributes==null || nodes[i].attributes.ismodule==false){
				if (s != '') s += ',';
				s += nodes[i].id;
				}
			}
        var check={groupId:selected.GroupId,checkid:s};
        requestAjax('Controller.aspx?controller=WebUIFrame@GroupMenuController&method=SaveUserWorkGroup',check);
    }
}
var isgroupuser = false;
function btn_binduser(){
    var selected = $('#groupGrid').datagrid('getSelected');
    if (selected) {
        $('#dlg-binduser').dialog({title:'绑定用户'});
        $('#dlg_save').linkbutton('enable');
        $('#dlg_delete').linkbutton('disable');
        $('#txtgroupId').val(selected.GroupId);
        isgroupuser = false;
        $('#userlistGird').datagrid('options').url='Controller.aspx?controller=WebUIFrame@GroupMenuController&method=GetAllUserList';
        $('#userlistGird').datagrid('reload');
    }
}

function btn_showuser(){
    var selected = $('#groupGrid').datagrid('getSelected');
    if (selected) {
        $('#dlg-binduser').dialog({title:'查看用户'});
        $('#dlg_save').linkbutton('disable');
        $('#dlg_delete').linkbutton('enable');
        $('#txtgroupId').val(selected.GroupId);
        isgroupuser = true;
        $('#userlistGird').datagrid('options').url='Controller.aspx?controller=WebUIFrame@GroupMenuController&method=GetGroupUserList&groupId='+selected.GroupId;
        $('#userlistGird').datagrid('reload');
    }
}

function dlg_save(){
    var selected = $('#userlistGird').datagrid('getSelections');
    if (selected.length>0) {
        var ids = [];		 
		for(var i=0;i<selected.length;i++){
			ids.push(selected[i].userid);
		}
        requestAjax('Controller.aspx?controller=WebUIFrame@GroupMenuController&method=GroupAddUser', { groupId:$('#txtgroupId').val(),userids: ids.join(',') }, function(data) {
                $('#dlg-binduser').dialog('close');
            });
    }
}
function dlg_delete(){
    var selected = $('#userlistGird').datagrid('getSelections');
    if (selected.length>0) {
        var ids = [];		 
		for(var i=0;i<selected.length;i++){
			ids.push(selected[i].userid);
		}
        requestAjax('Controller.aspx?controller=WebUIFrame@GroupMenuController&method=GroupDeleteUser', { groupId:$('#txtgroupId').val(),userids: ids.join(',') }, function(data) {
                $('#dlg-binduser').dialog('close');
            });
    }
}

function searchUser(val) {
    if (isgroupuser == false) {
        $('#userlistGird').datagrid('options').url = 'Controller.aspx?controller=WebUIFrame@GroupMenuController&method=GetAllUserList&key=' + val;
        $('#userlistGird').datagrid('reload');
    } else {
        var selected = $('#groupGrid').datagrid('getSelected');
        if (selected) {
            $('#userlistGird').datagrid('options').url = 'Controller.aspx?controller=WebUIFrame@GroupMenuController&method=GetGroupUserList&key=' + val + '&groupId=' + selected.GroupId;
            $('#userlistGird').datagrid('reload');
        }
    }
}