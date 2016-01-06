//初始化入口
$(function() {
    $('#dialog-book').dialog('close');
    //加载网格数据
    $('#bookGird').datagrid('options').url = 'Controller.aspx?controller=Books_Web@bookController&method=SearchBook&schar=&flag=0';
    $('#bookGird').datagrid('reload');
});
//添加
function btn_add(){
    $('#dialog-book').dialog({ title: '新增书籍' });
    $("#bookform").form('clear');
    $("#book_id").val(0);
    $("#book_flag").val(0);
    $("#_flag").removeAttr("checked");
}
//修改
function btn_alter(){
    $('#dialog-book').dialog({ title: '修改书籍' });
    var selected = $('#bookGird').datagrid('getSelected');
    if (selected) {
         $("#bookform").form("load", selected);
          
         if (selected.Flag == "1")
            $("#_flag").attr("checked", "true");
        else
            $("#_flag").removeAttr("checked");           
    }
}
//保存
function btn_save() {
    var ckval=$("#_flag").attr("checked")=="checked"?1:0;
    $('#book_flag').val(ckval);
    formSubmit('#bookform', 'Controller.aspx?controller=Books_Web@bookController&method=SaveBook', function () {
                        $('#dialog-book').dialog('close');
                        $('#bookGird').datagrid('reload');
                    });
}