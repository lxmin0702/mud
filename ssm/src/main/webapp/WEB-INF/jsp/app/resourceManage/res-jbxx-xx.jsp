<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="utf-8" />
		<title>APP资源管理平台</title>
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/font/iconfont.css">
		<link href="<%=request.getContextPath()%>/css/xf-public.css" rel="stylesheet" />
		<link href="<%=request.getContextPath()%>/css/xf-page.css" rel="stylesheet" />
		<link href="<%=request.getContextPath()%>/css/jbxx-xx.css" rel="stylesheet" />
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
					<button class="btn btnF btnWd back2">基本信息 - 详情</button>
					<a href="javascript:history.go(-1)">返回</a>
				</div>
				<div class="Tit-B Mt-24 Mb-12">
					<svg class="icon" aria-hidden="true">
                        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-xiangyou_dianji"></use>
                    </svg>
                    <strong class="tit"> 基本信息</strong>
				</div>
				<ul class="Tit-B Mt-24 Mb-12 jjxx_con">
					<li>
						<h4>${appMain.appname}</h4>
					</li>
					<li class="clear">
						<div class="fl">
							<span>类&nbsp&nbsp&nbsp别：</span>
							<span>${appMain.apptype}</span>
						</div>
						<div class="fl">
							<span>入库时间：</span>
							<span>${appMain.createtime}</span>
						</div>
						<div class="fr">
							<span>更新时间：</span>
							<span>${appMain.updatetime}</span>
						</div>
					</li>
					<li class="clear">
						<div class="fl">
							<span>包&nbsp&nbsp&nbsp名：</span>
							<span>${appMain.packagename}</span>
						</div>
						<div class="fr">
							<span>签&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp名：</span>
							<span>${appMain.signature}</span>
						</div>
					</li>
					<li class="clear">
						<div class="fl">
							<span>开发者：</span>
							<span>${appMain.developers}</span>
						</div>
					</li>
				</ul>
				<div class="Tit-B Mt-24 Mb-12">
					<svg class="icon" aria-hidden="true">
                        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-xiangyou_dianji"></use>
                    </svg>
                    <strong class="tit"> 版本信息</strong>
				</div>
				<ul class="Tit-B Mt-24 Mb-12 bbxx_con clear">
				<c:forEach items="${appVersionList}" var="item" varStatus="stauts">
					<li class="fl">
						<h5>${stauts.count}</h5>
						<a href="#"><img src="<%=request.getContextPath()%>/img/aiqiyi.png" alt=""></a>
						<span>版本：${item.version}</span>
						<p>内部版本号：${item.iversion}</p>
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
