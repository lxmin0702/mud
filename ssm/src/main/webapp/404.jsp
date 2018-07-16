<%@ page language="java" import="java.util.*" pageEncoding="utf-8"  isErrorPage="true"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">

<title>互联网金融管理系统</title>

<meta charset="utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="网贷，互金，中心，异常">
<meta http-equiv="description" content="互联网金融企业管理系统">

<link href="<%=basePath%>css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=basePath%>js/artDialog/skins/idialog.css" />
<script src="<%=basePath%>js/jquery.min.js"></script>
<% 
response.setStatus(HttpServletResponse.SC_OK);
%>
<style type="text/css">
<!--
a { color:#555}
html { height: 100%; width: 100%; background: url(bj.png) repeat; }
body {margin: 0px auto;}
.cw505 { width:755px; margin: 0px auto; }
.cw505_nr { height: 284px; width: 750px; background: #e5e5e5; border: 1px solid #aaaaaa; margin: 0px auto; }
.cw505_top { height: 200px; width: 750px; margin: 0px auto; }
.top_left { float: left; height: 150px; width: 150px; }
.top_right { font-size: 100px; line-height: 150px; text-align: center; float: left; height: 150px; width: 600px; color: #3f8bc7; font-family: "微软雅黑"; font-weight: bold; }
.nr_top { font-size: 25px; line-height: 40px; height: 40px; margin-right: 5px; margin-left: 5px; border-bottom: 1px solid #aaaaaa; text-align: center; font-weight: bold; color: #555555; }
.nr_min { height: 200px; border-top: 1px solid #FFFFFF; margin-right: 5px; margin-left: 5px; border-bottom: 1px solid #aaaaaa; }
.nr_foot { font-size: 12px; line-height: 40px; background: #eaeaea; height: 40px; border-top: 1px solid #FFFFFF; color: #555; margin-right: 5px; margin-left: 5px; }
.min_top { font-size: 14px; line-height: 30px; height: 30px; }
.min_choose { height: 30px; width: 100px; border: 1px solid #aaa; font-size: 12px; line-height: 30px; text-align: center; background: #eaeaea; }
.else { height: 30px; font-size:12px; line-height:30px; display:inline;color: #555; }
div#errorText{ color:#39351e; padding:146px 0 0 446px }
a:link { text-decoration: none; }
a:visited { text-decoration: none; }
a:hover { text-decoration: none; }
a:active { text-decoration: none; }
-->
</style>
</head>

<body>
<div class="cw505">
  <div class="cw505_top">
    <div class="top_left"><img src="images/cw4.png"></div>
    
    <div class="top_right">404</div>
  </div>
  <div class="cw505_nr">
    <div class="nr_top">Sorry..页面没有找到！</div>
  	
	<div class="nr_min">
      
      <div class="else">似乎你所寻找的网页已移动或丢失了。</div>
    <br/>
      <div class="else">
    或者也许你只是键入错误了一些东西。
      </div>
    <br/>
      <div class="else">
  请不要担心，这没事。如果该资源对你很重要，请与在线客服人员联系。
      </div>      
      
    </div>
      
    <div class="nr_foot">如有问题请联系在线客服人员</div>
  </div>
</div>
</body>
</html>
