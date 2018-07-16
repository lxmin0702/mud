<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<html>
	<head>
		<meta charset="utf-8" />
		<title>APP资源管理平台</title>
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/font/iconfont.css">
		<link href="<%=request.getContextPath()%>/css/xf-public.css" rel="stylesheet" />
		<link href="<%=request.getContextPath()%>/css/xf-page.css" rel="stylesheet" />
		<link href="<%=request.getContextPath()%>/css/jrxx-xx.css" rel="stylesheet" />
		<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
		<script src="<%=request.getContextPath()%>/js/layer/layer.js"></script>
		<script src="<%=request.getContextPath()%>/js/whg-public.js"></script>
		<script src="<%=request.getContextPath()%>/css/font/iconfont.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
		<link href="<%=request.getContextPath()%>/js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
		<script src="<%=request.getContextPath()%>/js/less.js"></script>
		<style type="text/css">
        

    </style>
	</head>
	<body>
		<jsp:include  page="../template/header.jsp"></jsp:include>
		<article class="pages">
			<div class="nrM">
				<div class="Tit-A">
					<button class="btn btnF btnWd back2">接入信息 - DNS信息&HTTP信息</button>
					<a href="javascript:history.go(-1)">返回</a>
				</div>
				<ul class="Tit-B Mt-24 Mb-12 dns_con">
					<li>
						<h4>DNS解析过程</h4>
					</li>
					<c:forEach items="${dnses}" var="item" varStatus="stauts">
						<li>
							<p>${stauts.count}、${item.dnsinfo}</p>
						</li>
					</c:forEach>
				</ul>
				<ul class="Tit-B Mt-24 Mb-12 dns_con">
					<li>
						<h4>HTTP连接头部</h4>
					</li>
					<c:forEach items="${https}" var="item" varStatus="stauts">
						<li>
							<p>${stauts.count}、${item.httpinfo}</p>
						</li>
					</c:forEach>
				</ul>
			</div>
		</article>
	</body>
	<script>
		var ipage=2;
	</script>
</html>

