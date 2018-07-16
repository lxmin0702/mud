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
		<link href="<%=request.getContextPath()%>/css/xf-data.css" rel="stylesheet" />
		<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
		<script src="<%=request.getContextPath()%>/js/layer/layer.js"></script>
		<script src="<%=request.getContextPath()%>/js/whg-public.js"></script>
		<script src="<%=request.getContextPath()%>/css/font/iconfont.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
		<link href="<%=request.getContextPath()%>/js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
		<style type="text/css">
        

    </style>
	</head>
	<body>
		<jsp:include  page="../template/header.jsp"></jsp:include>
		<article class="pages">
			<div class="nrM">
				<div class="Tit-B Mt-24 Mb-12">
					<svg class="icon" aria-hidden="true">
                        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-xiangyou_dianji"></use>
                    </svg>
                    <strong class="tit"> 基本信息</strong>
				</div>
				<div class="bk">
					<div class="P-12">
						<div class="searchBox">
							<span class="fr">
								<a class="btnS"><i class="icon iconfont icon-shebeidaoru FsH6" title=""></i>导出</a>
								<a class="btnS"><i class="icon iconfont icon-shujudaochu FsH6" title=""></i>导入</a>
								<a class="btnS"><i class="icon iconfont icon-xiazaidaorumoban FsH6" title=""></i>导入模板</a>
							</span>
							<form id="basicListForm" method="post" 	action="<%=basePath%>source/queryBaisicInfoList">
							<dl>
							<input class="Wdate" type="text" name="updateStartTime" id="updateStartTime" readonly="readonly"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',qsEnabled:false,maxDate:'#F{$dp.$D(\'updateEndTime\')}'})"
							value='<c:out value="${odata.ocreateStartTime}"/>' /> 到
							 <input class="Wdate" type="text" name="updateEndTime" id="updateEndTime" readonly="readonly"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',qsEnabled:false,minDate:'#F{$dp.$D(\'updateStartTime\')}'})"
							value='<c:out value="${odata.ocreateEndTime}"/>' /> 
							</dl>
							<dl>
								<label class="tx fl">名称：</label>
								<input type="text" name="name" value="<c:out value='${PageInfo.name}'/>" class="in-T" placeholder="请输入内容">
							</dl>
							<dl>
								<label class="tx fl">开发者：</label>
								<input type="text" name="developer" value="<c:out value='${PageInfo.developer}'/>" class="in-T" placeholder="请输入内容">
							</dl>
							<dl>
								<input type="button" name="button" id="search" class="btn btnF wWK backL Ml-0" value="搜索">
							</dl>
						</div>
						<div class="seaTag">
							分类:
							<span class="active">全部</span>
							<span class="">动作</span>
							<span class="">主题</span>
							<span class="">桌面</span>
							<span class="">壁纸</span>
							<span class="">其它</span>
							<span class="">动作</span>
							<span class="">主题</span>
							<span class="">桌面</span>
							<span class="">壁纸</span>
							<span class="">其它</span>
						</div>
					</div>
				</div>
				
				<div class="">
					<table border="0" cellpadding="0" cellspacing="0" class="dateLisTable Mt-12">
					    <thead>
					    <tr >
					    	<td>序号</td>
					        <td>名称</td> 
					        <td>包名</td> 
					        <td>开发者</td> 
					        <td>签名</td> 
					        <td>类别</td> 
					        <td>更新时间</td> 
					        <td>版本数量</td> 
					    </tr>
					    </thead>
					    <tbody>
					    <c:forEach items="${userlist}" var="item" varStatus="stauts">
					    <tr> 
					        <td>${stauts.count}</td>
					        <td><a href="javascript:;" onclick="detail(${item.appid})" class="Fc-B1">${item.appname}</a></td>
					        <td>${item.packagename}</td> 
					        <td>${item.developers}</td>
					        <td>${item.signature}</td> 
					        <td>${item.apptype}</td>
					        <td>${item.updatetime}</td>
					        <td>待定</td>
					    </tr>
					    </c:forEach> 
					    </tbody>
					</table>
					<div class="ListPage clearfix">
					<div class="left">
						<span> <span>共</span><em>${PageInfo.totalCount}</em><span>条</span>&nbsp;&nbsp;&nbsp;&nbsp;
				<span>当前第</span><em>${PageInfo.pageNum==null || PageInfo.totalCount==0 ?0:PageInfo.pageNum}</em><span>页</span><span>/</span><span>共</span><em>${PageInfo.totalPages==null?0:PageInfo.totalPages}</em><span>页</span>
				<select class="sele2" name="size" id="size" onchange="doSearch(1)">
					<c:choose>
						<c:when test="${PageInfo.pageSize == '10'}">
							<option value="10" selected>10</option>
						</c:when>
						<c:otherwise>
							<option value="10">10</option>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${PageInfo.pageSize == '20'}">
							<option value="20" selected>20</option>
						</c:when>
						<c:otherwise>
							<option value="20">20</option>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${PageInfo.pageSize == '50'}">
							<option value="50" selected>50</option>
						</c:when>
						<c:otherwise>
							<option value="50">50</option>
						</c:otherwise>
					</c:choose>
			</select> &nbsp;条
			</span>
					</div>
					<input id="number" type="hidden" name="number"
				value='${PageInfo.pageNum}' />
					<ul class="right clearfix">
						<li><a href="javascript:;" onclick="doSearch(1)" 
							<c:if test="${PageInfo.pageNum<=1}">disabled="disabled"</c:if>>首页</a></li>
						<li><a href="javascript:;" onclick="doSearch(${PageInfo.pageNum-1})" 
							<c:if test="${PageInfo.pageNum<=1}">disabled="disabled"</c:if>>上一页</a></li>
						<li><a href="javascript:;" onclick="doSearch(${PageInfo.pageNum+1})"
						<c:if test="${PageInfo.pageNum==PageInfo.totalPages}">disabled="disabled"</c:if>>下一页</a></li>
						<li class="last"><a href="javascript:;" onclick="doSearch(${PageInfo.totalPages})" 
							<c:if test="${PageInfo.pageNum==PageInfo.totalPages}">disabled="disabled"</c:if>>末页</a></li>
					</ul>
				</div>
				</div>
			</div>
			</form>
		</article>
	</body>
	<script>
		var ipage=2;
	</script>
	<script type="text/javascript">
	$(function(){
		$('#search').on('click',function(){
			var index = layer.load(2, {
			  shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
			$('#basicListForm').submit();
		});
		
	});
	
	function detail(id){
		var url="<%=request.getContextPath()%>/source/basicDetail?id=" + id;
		//$('#isActive').val("1");
	    window.location.href=url;
	}
	function doSearch(pasenum) {
		$("#number").val(pasenum);
		var form = document.getElementById("basicListForm");
		form.submit();// 提交搜索表单
	}
	</script>
	
</html>
