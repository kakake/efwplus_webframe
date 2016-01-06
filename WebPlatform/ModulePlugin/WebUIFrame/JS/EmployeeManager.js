//初始化入口
$(function() {
    $('#dialog-dept').dialog('close');
    $('#dialog-searchEmployee').dialog('close');
    $('#dialog-employee').dialog('close');

    fn_empInit();
});

//人员
function fn_empInit(){
    $('#employeeGrid').datagrid('options').onDblClickRow = function() {
        emp_alter();
    };
    
    emp_refresh();
}

function search_emp(){
    var deptid = $('#sdeptId').combobox('getValue');
    var empname = $('#sempName').val();
    
    $('#employeeGrid').datagrid('options').url = 'Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetEmployeeUserData&deptId=' + deptid + '&empName=' + empname;
    $('#employeeGrid').datagrid('reload');
    $('#dialog-searchEmployee').dialog('close');
}

function emp_refresh() {
    $('#sdeptId').combobox('reload', 'Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetDeptTree');

    $('#employeeGrid').datagrid('reload');
    $('#defaultDeptid').combobox('reload','Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetDeptTree');
    $('#empdeptGrid').datagrid('options').url ='Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetDeptTree';
    $('#empdeptGrid').datagrid('reload');
}

function emp_add(){
    $('#dialog-employee').dialog({title:'添加用户信息'});
    $("#employeeform").form('clear');
    $('#HempId').val(0);
    $('#Hempdel').val(0);
    $('#HUserId').val(0);
    $('#Hlock').val(0);
    $('#HempdeptIds').val('');
}

function emp_save(){
    var ck_empdel=$("#Fempdel").attr("checked")=="checked"?1:0;
    $('#Hempdel').val(ck_empdel);
    var ck_userlock=$("#Flock").attr("checked")=="checked"?1:0;
    $('#Hlock').val(ck_userlock);

    var ids = [];
	var rows = $('#empdeptGrid').datagrid('getSelections');
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].DeptId);
	}

    $('#HempdeptIds').val(ids.join(','));
    
    formSubmit('#employeeform', 'Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=SaveEmployeeUser', function() {
                        $('#dialog-employee').dialog('close');
                        emp_refresh();
                    });
}

function emp_alter(){
    
    var selected = $('#employeeGrid').datagrid('getSelected');
    if (selected) {
        requestAjax('Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetEmpUserModel', { empId: selected.empid, userId: selected.userid }, function (data) {
            $('#dialog-employee').dialog({ title: '修改用户信息' });
            //人员信息
            $("#employeeform").form("load", data.user);
            $("#employeeform").form("load", data.emp);
            $("#defaultDeptid").combobox('setValue', data.defaultdeptId);
            if (parseInt(data.emp.DelFlag, 10) == 1)
                $("#Fempdel").attr("checked", "true");
            else
                $("#Fempdel").removeAttr("checked");
            //用户信息

            if (parseInt(data.user.Lock, 10) == 1)
                $("#Flock").attr("checked", "true");
            else
                $("#Flock").removeAttr("checked");
            //角色    
            var groupids = [];
            for (var i = 0; i < data.groupdt.length; i++) {
                groupids.push(data.groupdt[i].GroupId);
            }
            $("#groupIds").combobox('setValues', eval("[" + groupids.join(',') + "]"));
            //管辖科室    
            $('#empdeptGrid').datagrid('clearSelections');
            for (var i = 0; i < data.deptdt.length; i++) {
                $('#empdeptGrid').datagrid('selectRecord', data.deptdt[i].DeptId);
            }
        });
    }
    else {
        $.messager.alert('提示', "请选数据行", 'info');
    }
}

function emp_reset(){
    var selected = $('#employeeGrid').datagrid('getSelected');
    if (selected) {
        $.messager.confirm('询问', '是否需要重置密码?', function(r) {
            if (r) {
                requestAjax('Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=ResetPassword', { userId: selected.userid });
            }
        });
    }
}