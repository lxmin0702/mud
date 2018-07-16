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
                    <strong class="tit"> 接入信息</strong>
				</div>
				<div class="bk">
					<div class="P-12 clear">
						<div class="searchBox fl" style="width:100%;">
						<form id="accessListForm" method="post" 	action="<%=basePath%>source/queryAccessList">
							<dl>
								<label class="tx fl">分析时间：</label>
								<input class="Wdate" type="text" name="analysisStartTime" id="analysisStartTime" readonly="readonly"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',qsEnabled:false,maxDate:'#F{$dp.$D(\'analysisEndTime\')}'})"
							value='<c:out value="${odata.ocreateStartTime}"/>' /> 到
							 <input class="Wdate" type="text" name="analysisEndTime" id="analysisEndTime" readonly="readonly"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',qsEnabled:false,minDate:'#F{$dp.$D(\'analysisStartTime\')}'})"
							value='<c:out value="${odata.ocreateEndTime}"/>' /> 
							</dl>
							<dl>
								<label class="tx fl">接入域名：</label>
								<input type="text" name="accessDomain" value="<c:out value='${PageInfo.accessDomain}'/>" class="in-T" placeholder="请输入内容" >
							</dl>
							<dl>
								<input type="button" name="button" id="search" class="btn btnF wWK backL Ml-0" value="查询" style="width:72px;margin-left:20px;">
								<input type="button" name="button" id="check" class="btn btnF wWK Ml-0" style="background:#fff;color:#555;border:1px solid #b4bbc2;width:72px;margin-left:20px;" value="审核">
							</dl>
						</div>
						<div class="import fl" style="width:100%;">
							<span class="">
								<a class="btnS"><i class="icon iconfont icon-shebeidaoru FsH6" title=""></i>导出接入信息</a>
								<a class="btnS"><i class="icon iconfont icon-shujudaochu FsH6" title=""></i>导入接入信息</a>
								<b>|</b>
								<a class="btnS"><i class="icon iconfont icon-shebeidaoru FsH6" title=""></i>导出DNS信息</a>
								<a class="btnS"><i class="icon iconfont icon-shujudaochu FsH6" title=""></i>导入DNS信息</a>
								<b>|</b>
								<a class="btnS"><i class="icon iconfont icon-shebeidaoru FsH6" title=""></i>导出HTTP信息</a>
								<a class="btnS"><i class="icon iconfont icon-shujudaochu FsH6" title=""></i>导入HTTP信息</a>
								<b>|</b>
								<a class="btnS"><i class="icon iconfont icon-xiazaidaorumoban FsH6" title=""></i>导入模板</a>
							</span>
						</div>
					</div>
				</div>
				
				<div class="">
					<table border="0" cellpadding="0" cellspacing="0" class="dateLisTable Mt-12">
					    <thead>
						    <tr >
						    	<td>序号</td>
						        <td>名称</td> 
						        <td>版本号</td> 
						        <td>文件签名</td> 
						        <td>接入域名</td> 
						        <td>二级域名</td> 
						        <td>分析时间</td> 
						        <td>人工核验结果</td>  
						        <td>人工核验时间</td>  
						        <td>附加信息</td>  
						        <td>自动核验结果</td>  
						        <td>自动核验时间</td>  
						        <td>附加信息</td>  
						        <td>接入来源</td>  
						        <td>接入备注</td>  
						        <td>抓包文件</td>  
						        <td>操作</td> 
						    </tr>
					    </thead>
					    <tbody>
					    <c:forEach items="${userlist}" var="item" varStatus="stauts">
						    <tr>
						        <td><input type="checkbox" class="forCheck" related="${item.aid}"/>${stauts.count}</td>
						        <!-- 名称是啥？ TODO -->
						        <td>待定</td>
						        <td>待定</td> 
						        <td>待定</td> 
						        <td>${item.accessdomain}</td> 
						        <td>${item.secondarydomain}</td>
						        <td>${item.analysistime}</td>
						        <td>${item.mvresult}</td>
						        <td>${item.mvtime}</td>
						        <td>${item.addinfo1}</td>
						        <td>${item.avresult}</td>
						        <td>${item.avtime}</td>
						        <td>${item.addinfo2}</td>
						        <td>${item.asource}</td>
						        <td>${item.anote}</td>
						        <td>${item.fileurl}</td>
						        <td style="font-size:11px; color:#001adf;width: 50px;"><a href="javascript:;" onclick="detail(${item.aid})">连接信息</a>
						        </br></br><a href="javascript:;" onclick="check(${item.aid})">审核</a></td>
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
				$('#accessListForm').submit();
			});
		$('#check').on('click',function(){
			var toBeCheckedSize = $("input.forCheck[type='checkbox']:checked").length;
			if(toBeCheckedSize == 0){
				layer.msg("请选择要审核的接入记录！",{time:2000});
				return false;
			}
			var toBeCheckedIds = new Array();
			var checkRes;
			$("input.forCheck[type='checkbox']:checked").each(function(){
				toBeCheckedIds.push($(this).attr('related'));
			}); 
			layer.open({
						  title: '审核',
		    			  type:2,
		    			  area: ['370px', '300px'],
		    			  offset: '25px',
		    			  btn: ['审核', '关闭'],
		    			  content: '<%=request.getContextPath()%>/source/toAccessCheck',
		    			  yes: function(index, layero){
		    				    var body = layer.getChildFrame('body', index); //取道弹出层的body
		    				   	checkRes = body.find("input[type='radio']:checked").val();
		    				   	layer.close(index);
								$.ajax({
					              type: 'POST',
					              url: '<%=request.getContextPath()%>/source/accessCheck',
					              data: {
					                  checkRes:checkRes,
					                  ids:toBeCheckedIds.join()
					              },
					              async:false,
					              dataType: 'text',
					              success: function (result) {
					                if(result == "success"){
					                	layer.msg('审批成功!',{time:5000});
					                	document.getElementById("accessListForm").submit();
					                }else{
					                  layer.msg('审批失败!',{time:3000});
					                }
					              },
					              error:function (response) {
					              	console.log("ajax error : " + response);
					              }
					            });
		    			  }
			})
			
		})
	});
	function doSearch(pasenum) {
		$("#number").val(pasenum);
		var form = document.getElementById("accessListForm");
		form.submit();// 提交搜索表单
	}
	function detail(id){
		var url="<%=request.getContextPath()%>/source/connectionDetail?id=" + id;
		//$('#isActive').val("1");
	    window.location.href=url;
	}
	function check(id){
		layer.open({
						  title: '审核',
		    			  type:2,
		    			  area: ['370px', '300px'],
		    			  offset: '25px',
		    			  btn: ['审核', '关闭'],
		    			  content: '<%=request.getContextPath()%>/source/toAccessCheck',
		    			  yes: function(index, layero){
		    				    var body = layer.getChildFrame('body', index); //取道弹出层的body
		    				   	var checkRes = body.find("input[type='radio']:checked").val();
		    				   	layer.close(index);
								$.ajax({
					              type: 'POST',
					              url: '<%=request.getContextPath()%>/source/accessCheck',
					              data: {
					                  checkRes:checkRes,
					                  ids:id
					              },
					              async:false,
					              dataType: 'text',
					              success: function (result) {
					                if(result == "success"){
					                	layer.msg('审批成功!',{time:5000});
					                	document.getElementById("accessListForm").submit();
					                }else{
					                  layer.msg('审批失败!',{time:3000});
					                }
					              },
					              error:function (response) {
					              	console.log("ajax error : " + response);
					              }
					            });
		    			  }
			})
	}
	</script>
</html>
