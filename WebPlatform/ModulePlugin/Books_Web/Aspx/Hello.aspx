<%@ Page Language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	
	<script type="text/javascript" src="../../../WebPlugin/jquery-1.8.0.min.js"></script>

    <link href="../../../WebPlugin/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="../../../WebPlugin/bootstrap/js/bootstrap.min.js"></script>

	<link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="../../../WebPlugin/jquery-easyui-1.4.2/themes/icon.css"/>
	<script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../../WebPlugin/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
    <script src="../JS/Hello.js" type="text/javascript"></script>
    <style>
        body {
        font-family: "Helvetica Neue", Helvetica, Microsoft Yahei, Hiragino Sans GB, WenQuanYi Micro Hei, sans-serif;
        }
        .bs-docs-header {
        padding-top: 60px;
        padding-bottom: 60px;
        font-size: 24px;
        text-align: left;
        background-color: #5c87b2;
        }
        .bs-docs-header h1 {
        margin-top: 0;
        color: #fff;
        }
        .bs-docs-container {
            padding-right: 50px;
            padding-left: 50px;
        }
    </style>
</head>
<body>
    <div class="bs-docs-header" id="content" tabindex="-1">
      <div class="container">
        <h1>Hello，Web插件项目</h1>
        <p>Ajax+HttpHandle</p>
      </div>
    </div>
    
    <div class="container bs-docs-container">
    <h3>页面通过Ajax访问后台控制器对象返回数据</h3>
    <div style="padding:5px;">
        <input class="btn btn-default" type="button" value="点击，从后台获取数据" onclick="gethello();"/>
    </div>
    <div class="highlight"><pre>
        <code class="language-bash" data-lang="bash">
/***********JS方法实现************/
function gethello(){
    $.ajax({
		type : "POST",
		url : "Controller.aspx?controller=WebTest01@HelloController&method=GetHello",
		data : {},
		success : function (msg) {
			var retobject = eval('(' + msg + ')');
			if (retobject.ret == 0) { //后台操作成功
				//
			} else {
			    //
			}
			if (retobject.msg != '') {
				//alert("结果: " + retobject.msg);
				$.messager.alert('提示', "结果: " + retobject.msg, 'info');
			}
		}
	});
}
        </code></pre></div>
        <div class="highlight"><pre>
        <code class="language-bash" data-lang="bash">
/***********后台控制器实现************/
[WebController]
public class HelloController : JEasyUIController
{
    [WebMethod]
    public void GetHello()
    {
		//代码实现
        JsonResult = RetSuccess("hello world");
    }
}
        </code></pre></div>


    </div>
</body>
</html>
