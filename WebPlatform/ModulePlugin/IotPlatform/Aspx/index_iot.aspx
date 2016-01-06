<%@ Page Language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>物联网在线平台-调试界面</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	
	<script type="text/javascript" src="../../../WebPlugin/jquery-1.8.0.min.js"></script>

    <link href="../../../WebPlugin/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="../../../WebPlugin/bootstrap/js/bootstrap.min.js"></script>

    <script src="../JS/index_iot.js" type="text/javascript"></script>
    <style>
        body {
        font-family: "Helvetica Neue", Helvetica, Microsoft Yahei, Hiragino Sans GB, WenQuanYi Micro Hei, sans-serif;
        }
        .bs-docs-header {
        padding-top: 10px;
        padding-bottom: 5px;
        font-size: 15px;
        text-align: left;
        background-color: #5c87b2;
        color: #fff;
        }
        .bs-docs-header h2 {
        margin-top: 0;
        }
        .bs-docs-container {
            padding-right: 10px;
            padding-left: 10px;
        }
		.msg-fontcolor-red{
			color:red;
		}
		.msg-fontcolor-blue{
			color:blue;
		}
    </style>
</head>
<body>
    <div class="bs-docs-header" id="content" tabindex="-1">
      <div class="container">
        <h2>物联网在线平台-调试界面</h2>
        <p>通过访问www.efwplus.cn网站来控制raspberryPI主机，操作相关设备，如：遥控器、温度湿度传感器、摄像头等</p>
      </div>
    </div>
    
    <div class="container bs-docs-container">
    <div class="row">
    <div class="col-md-3">
    <div class="left" style="padding-top:20px;padding-left:5px;padding-right:5px;">
    <input id="hostid" type="hidden" />
    <input id="devid" type="hidden" />
    <div id="pilist" class="list-group" >
      <a href="#" class="list-group-item active">树莓派主机1号</a>
      <a href="#" class="list-group-item">树莓派主机2号</a>
      <a href="#" class="list-group-item">树莓派主机3号</a>
      <a href="#" class="list-group-item">树莓派主机4号</a>
    </div>
    <div id="pidev" class="list-group">
      <a href="#" class="list-group-item active">监视主机</a>
      <a href="#" class="list-group-item">控制GPIO</a>
    </div>
    </div>
    </div>
    <div class="col-md-9">
    <div class="right" style="padding-top:20px;padding-left:5px;padding-right:5px;">
    <ul><li><h3>往树莓派主机发送数据</h3></li></ul>
    <div style="padding:5px;">
        <textarea id="cmdtext" class="form-control" rows="10"></textarea>
        <br/>
		<span id="showmsg" class="msg-fontcolor-red"></span>
		<br/>
        <input class="btn btn-success" type="button" value="  发 送  " onclick="setpidata();"/>
    </div>
    <div class="row"><div class="col-md-9"><span style="font-size:15px;font-weight:bold;">接收树莓派回传的数据</span></div><div class="col-md-3" style="text-align:right;"><a href="javascript:void();" onclick="startoutput(this);" value="0">开启</a>|<a href="javascript:void();" onclick="clearoutput();">清空</a>|<a href="javascript:void();" onclick="alloutput();">取出所有</a></div></div>
    <div id="output" style="padding:5px;height:200px;overflow-y:scroll;background-color:#eee">
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
        <span>{"cmdname":"replygpio","setup":{"1":"out","4":"out"},"loop":[{"pinval":[1,0]},{"sleep":1},{"pinval":[1,1]}],"reply":[1,4]}</span>
    </div>
    </div>
    </div>
    </div>
    </div>
</body>
</html>
