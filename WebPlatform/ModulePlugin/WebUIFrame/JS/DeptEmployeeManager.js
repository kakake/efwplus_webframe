//初始化入口
$(function() {
    $('#dialog-dept').dialog('close');
    $('#dialog-searchEmployee').dialog('close');
    $('#dialog-employee').dialog('close');

    fn_layertreeInit();
    fn_deptInit();
    fn_empInit();
    
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
        }
    });
    
   
}

function deptlayer_refresh() {
    $('#deptLayerTree').tree('reload');
}

function deptlayer_append() {
    var node = $('#deptLayerTree').tree('getSelected');
    if (node) {
        var para={LayerId:0,PId:node.id,Name:'新建分类'};
        requestAjax('Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=SaveDeptLayer',para,function(data){
            $('#deptLayerTree').tree('append',{
                 parent: (node?node.target:null),
                 data:[{ id:data,text:'新建分类'}]
            });
        });
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
                });
             }
        });
    }
}
    
function fn_deptInit(){
    $('#deptGrid').datagrid('options').onDblClickRow=function(){
        dept_alter();
    }
}

function dept_refresh(){
    $('#deptGrid').datagrid('reload');
}

function dept_add(){
    var node = $('#deptLayerTree').tree('getSelected');
        if (node) {
            $('#dialog-dept').dialog({ title: '添加科室' });

            $("#deptform").form('clear');
            $("#txtclass").combotree('setValue',node.id);
            $("#DeptId").val(0);
            $("#DeleteBit").val(0);
        }
}

function dept_alter(){
    $('#dialog-dept').dialog({ title: '修改科室' });
    var selected = $('#deptGrid').datagrid('getSelected');
    if (selected) {
        $("#deptform").form("load", selected);

        if (selected.DelFlag == "1")
            $("#_DeleteBit").attr("checked", "true");
        else
            $("#_DeleteBit").removeAttr("checked"); 
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

//人员
function fn_empInit(){
    $('#employeeGrid').datagrid('options').onDblClickRow = function() {
        emp_alter();
    };
    
    emp_refresh();
}


function emp_searchDlgShow(){
    $('#dialog-searchEmployee').dialog({ title: '查询人员' });
    $('#sdeptId').combobox('reload','Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetDeptTree');
}

function search_emp(){
    var deptid = $('#sdeptId').combobox('getValue');
    var empname = $('#sempName').val();
    
    $('#employeeGrid').datagrid('options').url = 'Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetEmployeeUserData&deptId=' + deptid + '&empName=' + empname;
    $('#employeeGrid').datagrid('reload');
    $('#dialog-searchEmployee').dialog('close');
    
    
}

function emp_refresh(){
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
        
        requestAjax('Controller.aspx?controller=WebUIFrame@DeptEmployeeController&method=GetEmpUserModel', { empId: selected.empid,userId: selected.userid }, function(data) {
            $('#dialog-employee').dialog({title:'修改用户信息'});
            //人员信息
            $("#employeeform").form("load", data.user);
            $("#employeeform").form("load", data.emp);
            $("#defaultDeptid").combobox('setValue',data.defaultdeptId);
            if (parseInt(data.emp.DelFlag,10) == 1)
                $("#Fempdel").attr("checked", "true");
            else
                $("#Fempdel").removeAttr("checked"); 
            //用户信息
            
            if (parseInt(data.user.Lock,10) == 1)
                $("#Flock").attr("checked", "true");
            else
                $("#Flock").removeAttr("checked");
            //角色    
            var groupids=[];
            for(var i=0;i<data.groupdt.length;i++){
                groupids.push(data.groupdt[i].GroupId);
            }
            $("#groupIds").combobox('setValues', eval("[" + groupids.join(',') + "]"));
            //管辖科室    
            $('#empdeptGrid').datagrid('clearSelections');
            for(var i=0;i<data.deptdt.length;i++){
                $('#empdeptGrid').datagrid('selectRecord',data.deptdt[i].DeptId);
            }
        });
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