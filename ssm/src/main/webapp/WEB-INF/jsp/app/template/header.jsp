<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>APP资源管理平台</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/font/iconfont.css">
		<link href="<%=request.getContextPath()%>/css/xf-public.css" rel="stylesheet" />
		<link href="<%=request.getContextPath()%>/css/xf-page.css" rel="stylesheet" />
		<script src="<%=request.getContextPath()%>/css/font/iconfont.js"></script>
		<style type="text/css">
        
    	</style>
	</head>
	<body>
		<header class="headBox">
			<em class="logo"></em>
			<span class="logoSN">
				<cite class="curP">
					<i class="icon iconfont icon-yuandian FsH6" title="圆点"></i>
				</cite>
			</span>
			<span class="logoSN">
				<cite  class="curP"><i class="icon iconfont icon-yonghu1 FsH6"></i> <shiro:principal/></cite>
				<ul class="logoNav">
					<shiro:lacksRole name="1">
						<li class="JQ-editPassword" related="<shiro:principal/>">修改密码</li>
					</shiro:lacksRole>
					<li><a href="<%=request.getContextPath()%>/appUser/logout">退出</a></li>
				</ul>
			</span>
			<ul class="headNav">
				<li><a href="<%=request.getContextPath()%>/statistics/summary">首页</a></li>
				<li><a href="#">APP资源管理</a><ul><li><a href="<%=request.getContextPath()%>/source/toBaisicInfoList">基本信息</a></li>
				<li><a href="<%=request.getContextPath()%>/source/toDistributeList">分发信息</a></li>
				<li><a href="<%=request.getContextPath()%>/source/toAccessList">接入信息</a></li></ul></li>
				<shiro:hasRole name="1">
					<li><a href="#">系统管理</a>	
						<ul><li><a href="<%=request.getContextPath()%>/appUser/system/queryUserList">用户管理</a></li></ul>
					</li>
				</shiro:hasRole>
			</ul>
			<ul class="xtgl">
				
			</ul>
		</header>
</body>
</html>