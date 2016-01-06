<%@ Page Language="C#"%>
<%
    // 注销登录用户信息
    Session.Abandon();
%>
<SCRIPT language="javascript">
  document.location = "/ModulePlugin/WebUIFrame/Aspx/login.html";
</SCRIPT>