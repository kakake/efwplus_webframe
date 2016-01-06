<%@ Page Language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title></title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" href="/WebPlugin/jquery-easyui-1.4.2/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="/WebPlugin/jquery-easyui-1.4.2/themes/icon.css"/>
<script type="text/javascript" src="/WebPlugin/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="/WebPlugin/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/WebPlugin/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
<script src="/WebPlugin/JQueryCommon2.0.js" type="text/javascript"></script>

<script type="text/javascript" charset="utf-8">

    $(function() {

        requestAjax('Controller.aspx?controller=WebUIFrame@LoadingMenuController&method=GetOutLookMenu', {}, function(data) {
            var module = data.module;
            var result = data.menu;
            var html = '';
            for (var n = 0; n < module.length; n++) {
                html += '<ul>';
                for (var i = 0; i < result.length; i++) {
                    if (module[n].ModuleId == result[i].ModuleId) {
                        html += '<li><a href="/' + result[i].UrlName + '"><img src="' + result[i].Image + '" /><strong>' + result[i].Name + '</strong> ' + result[i].Memo + '<label id="menu_' + result[i].MenuId + '" style="font-size:22px; color:red"></label></a></li>';
                        if (result[i].BindSQL && result[i].BindSQL != '') {//如果菜单设置了BindSQL就执行SQL获取值显示在菜单上
                            requestAjax('Controller.aspx?controller=WebUIFrame@LoadingMenuController&method=ExecMenuBindSQL', { MenuId: result[i].MenuId }, function(valdata) {
                                if (valdata.Val.length > 0) {
                                    $('#menu_' + valdata.menuId + '').html(valdata.Val[0].num);
                                }
                            });
                        }
                    }
                }
                html += '</ul>';
            }
            $('#content').append(html);
            loadwrapper();
        });
    });

    function loadwrapper() {
        $('#content a').each(function() {
            $('<div class="fader" />').css('opacity', 0).prependTo(this);
        }).hover(function() {
            $('img', this).stop().animate({
                marginLeft: 5
            }, 250);

            $('.fader', this).stop().animate({
                opacity: 0.15
            });

        }, function() {
            $('img', this).stop().animate({
                marginLeft: 10
            }, 250);

            $('.fader', this).stop().animate({
                opacity: 0
            });
        }).find('img').css('marginLeft', 10);
    }
</script>

<style type="text/css" media="screen">
body {
  font-family: "Lucida Grande",Verdana,sans-serif;
  font-size: 11px;
  line-height: 24px;
  padding: 10px;
}

h2 {
  margin-top: 0;
}

#wrapper {
  width: 900px;
  margin: 30px 30px 30px 30px;
}

#content {
  padding: 0 10px;
  background: url(images/content.png) repeat-y;
}

#content ul {
  float: left;
  display: block;
  width: 900px;
  margin: 0;
  padding: 0;
  background: url(images/networks.png) repeat;
  list-style: none;

}

#content li {
  float: left;
  height: 80px;
  width: 300px;
  position: relative;

}

#content a {
  font-size: 1em;
  color: #666;
  text-decoration: none;
  padding: 10px 0 5px;
  display: block;
  width: 300px;
  height: 45px;
  position: relative;
  z-index: 2;
}

a img {
  border: 0;
  float: left;
  margin: 0 10px;
}

.fader {
  opacity: 0;
  -moz-opacity: 0;
  filter:alpha(opacity=0);
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 60px;
  background-color: #158144;
}

a:hover img {
  margin-left: 5px;
}

a strong {
  display: block;
  font-size: 24px;
  color: #006633;
}

.clear {
  clear: left;
}
</style>
</head>
<body style="background:url(images/envelope.png) repeat">
<div id="wrapper">
  <div id="content">
    
    <div class="clear"></div>
  </div>
  
</div>

</body>
</html>










