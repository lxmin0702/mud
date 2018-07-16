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
		<title>APP资源管理平台</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/font/iconfont.css">
		<link href="<%=request.getContextPath()%>/css/xf-public.css" rel="stylesheet" />
		<link href="<%=request.getContextPath()%>/css/xf-page.css" rel="stylesheet" />
		<script src="<%=request.getContextPath()%>/css/font/iconfont.js"></script>
		<style type="text/css">
        
    	</style>
	</head>
	<body>
	<jsp:include  page="template/header.jsp"></jsp:include>
		<article class="pages">
			<div class="nrM">
				<div class="Tit-A">
					<button class="btn btnF btnWd back2">首页</button>
				</div>
				<div class="Tit-B Mt-24 Mb-12">
					<svg class="icon" aria-hidden="true">
                        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-xiangyou_dianji"></use>
                    </svg>
                    <strong class="tit"> 总体信息统计</strong>
				</div>
				<div class="box-x-auto">
					<div class="Wbox1">
						<div class="Mr-24 bk P-24 QT-hTJb">
							<dl class="Wn3">
								<dt class="Fc-B2" id="appTotalNum">${appTotalNum}</dt>
								<dd>APP总量</dd>
							</dl>
							<dl class="Wn1 D-Rt">
								<i class="icon iconfont icon-xiangyou Fs24 FsH6 D-XD t40p"></i>
							</dl>
							<dl class="Wn3">
								<dt class="Fc-B1" id="appAnalyzedNum">${appAnalyzedNum}</dt>
								<dd>已分析APP数量</dd>
								<dd>占比:<span class="Fc-TS" id="appRatio"></span></dd>
							</dl>
						</div>
					</div>
					<div class="Wbox1">
						<div class="Ml-24 bk P-24 QT-hTJb">
							<dl class="Wn3">
								<dt class="Fc-B2" id='appVersionTotalNum'>${appVersionTotalNum}</dt>
								<dd>APP版本总量</dd>
							</dl>
							<dl class="Wn1 D-Rt">
								<i class="icon iconfont icon-xiangyou Fs24 FsH6 D-XD t40p"></i>
							</dl>
							<dl class="Wn3">
								<dt class="Fc-B1" id='appAnalyzedVersionTotalNum'>${appAnalyzedVersionTotalNum}</dt>
								<dd>已分析APP版本数量</dd>
								<dd>占比:<span class="Fc-TS" id='versionRatio'></span></dd>
							</dl>
						</div>
					</div>
				</div>
				
				<div class="b-t-1e Mt-24 H1p"></div>
				<div class="Tit-B Mt-12 Mb-12 ">
					<svg class="icon" aria-hidden="true">
                        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-xiangyou_dianji"></use>
                    </svg>
                    <strong class="tit"> 今日信息统计</strong>
				</div>
				<div class="box-x-auto Mt-24">
					<div class="Wbox1 QT-hTJb">
						<dl class="Wn3">
								<dt class="Fc-B1" id="appIncrementToday">${appIncrementToday}</dt>
								<dd>今日APP新增量</dd>
						</dl>
						<dl class="Wn3">
								<dt class="Fc-B1" id='appAnalyzedIncrementToday'>${appAnalyzedIncrementToday}</dt>
								<dd>今日分析App数量</dd>
						</dl>
						<dl class="Wn3">
								<dt class="Fc-B1" id='appVersionIncrementToday'>${appVersionIncrementToday}</dt>
								<dd>今日APP版本新增量</dd>
						</dl>
						<dl class="Wn3">
								<dt class="Fc-B1" id='appAnalyzedVersionIncrementToday'>${appAnalyzedVersionIncrementToday}</dt>
								<dd>今日分析APP版本数量</dd>
						</dl>
					</div>
				</div>
			</div>
		</article>
	</body>
	<script>
		var ipage=1;
	</script>
	<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/layer/layer.js"></script>
	<script src="<%=request.getContextPath()%>/js/whg-public.js"></script>
	
	<script type="text/javascript">
		var loadingHtml = '<img id="load" src="<%=request.getContextPath()%>/img/ajax-loader.gif" />';
	$(function(){
		statisticsTotally('statistics/loadTotalAPPNumStatistics','appTotalNum','appAnalyzedNum','appTotalNum','appRatio')
		statisticsTotally('statistics/loadTotalAnalyzedAPPNumStatistics','appAnalyzedNum','appAnalyzedNum','appTotalNum','appRatio')
		statisticsTotally('statistics/loadTotalVersionNumStatistics','appVersionTotalNum','appAnalyzedVersionTotalNum','appVersionTotalNum','versionRatio')
		statisticsTotally('statistics/loadTotalAnalyzedVersionNumStatistics','appAnalyzedVersionTotalNum','appAnalyzedVersionTotalNum','appVersionTotalNum','versionRatio')
            
        statisticsForToday('statistics/loadAppIncrementTodayStatistics','appIncrementToday');   
        statisticsForToday('statistics/loadAppAnalyzedIncrementTodayStatistics','appAnalyzedIncrementToday');   
        statisticsForToday('statistics/loadAppVersionIncrementTodayStatistics','appVersionIncrementToday');   
        statisticsForToday('statistics/loadAppAnalyzedVersionIncrementTodayStatistics','appAnalyzedVersionIncrementToday');   
	});
	
	function statisticsTotally(action,myId,moleculeId,denominatorId,ratioId){
		$.ajax({
              type: 'POST',
              url: '<%=request.getContextPath()%>/' + action,
              dataType: 'json',
              beforeSend: function () {
			    $('#' + myId).html(loadingHtml);
			    $('#' + ratioId).html(loadingHtml);
			   },
              success: function (result) {
                if(result.retCode == 0){
                	$('#' + myId).html('');
                	$('#' + myId).text(result.data);
                	if($('#' + moleculeId).text() != '' && 
                			$('#' + denominatorId).text().trim() != '' && $('#' + ratioId).text().trim() == ''){
                		if(parseInt($('#' + denominatorId).text()) == 0){
							$('#' + ratioId).text('0.00%');
							return;
						}
                		$('#' + ratioId).html('');
                		$('#' + ratioId).text(Number(parseInt($('#' + moleculeId).text()) * 100 / parseInt($('#' + denominatorId).text())).toFixed(2) + '%');
                	}
                }else{
                	console.log(result.retCode);
                }
              },
              error:function (response) {
               	$('#' + ratioId).html('');
              	$('#' + myId).html('');
              	console.log("ajax error : " + response);
              }
            });
	}
	
	function statisticsForToday(action,tagId){
		$.ajax({
              type: 'POST',
              url: '<%=request.getContextPath()%>/' + action,
              dataType: 'json',
              beforeSend: function () {
			    $('#' + tagId).html(loadingHtml);
			   },
              success: function (result) {
               	$('#' + tagId).html('');
                 if(result.retCode == 0){
                	$('#' + tagId).text(result.data);
                }else{
                	console.log(result.retCode);
                }
              },
              error:function (response) {
              	$('#' + tagId).html('');
              	console.log("ajax error : " + response);
              }
            });
	}
	
	</script>
</html>
