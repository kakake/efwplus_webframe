//初始化入口
$(function() {
    $('#worklistGird').datagrid('options').url = 'Controller.aspx?controller=WebUIFrame@WorkerController&method=GetWorker';
    $('#worklistGird').datagrid('reload');
});

function btn_start() {
    var selected = $('#worklistGird').datagrid('getSelected');
    if (selected) {
        var flag = 0;
        if (selected.DelFlag == "0") { flag = 1; }
        else if (selected.DelFlag == "1") { flag = 2; }
        else if (selected.DelFlag == "2") { flag = 1; }

        $.messager.confirm('询问', '是否进行此操作？', function(r) {
            if (r) {
                var data = { Workid: selected.WorkId, DeleteFlag: flag, Flag: selected.Delete_flag };
                requestAjax("Controller.aspx?controller=WebUIFrame@WorkerController&method=UpdateWorker", data, function(retobject) {
                    $('#worklistGird').datagrid('reload');
                });
            }
        });
    }
}