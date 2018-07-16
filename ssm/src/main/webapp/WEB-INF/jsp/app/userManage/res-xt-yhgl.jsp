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
                    <strong class="tit"> 中心用户管理</strong>
                    <a href="javascript:;" onclick="createUser()" style="float:right;width:48px;padding-left:19px;background: url(img/add.png) no-repeat center left;vertical-align: middle;font-size:11px;color:#4a4a4a;">新建</a>
				</div>
				<form id="userListForm" method="post" 	action="<%=request.getContextPath()%>/appUser/system/queryUserList">
				
				<div class="">
					<table border="0" cellpadding="0" cellspacing="0" class="dateLisTable Mt-12">
					    <thead>
						    <tr >
						    	<td>序号</td>
						    	<td>用户名</td>
						        <td>角色</td> 
						        <td>创建时间</td>
						        <td>修改时间</td> 
						        <td>备注</td> 
						        <td>操作</td> 
					    </thead>
					    <tbody>
						    <c:forEach items="${userlist}" var="item" varStatus="stauts">
							    <tr>
							        <td>${stauts.count}</td>
							        <td>${item.username}</td>
							        <c:choose>
				                    	<c:when test="${item.userType == 1}"><td>系统管理员</td></c:when>
				                    	<c:when test="${item.userType == 0}"><td>普通用户</td></c:when>
				                    	<c:otherwise><td>-</td></c:otherwise>
				                    </c:choose>
							        <td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							        <td><fmt:formatDate value="${item.updateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							        <td>${item.remark}</td>
							        <td>
							        	<a style="font-size:11px; color:#001adf; margin-left:14px;" href="javascript:;" onclick="updateUser('${item.username}')" class="fl">修改</a>
							        	<a style="font-size:11px; color:#001adf; margin-left:14px;" href="javascript:;" onclick="delUser(${item.id})" class="fl">删除</a>
							        </td>
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
		var ipage=3;
	</script>
	<script type="text/javascript">
	function createUser(){
		layer.open({
						  title: '用户创建',
		    			  type:2,
		    			  area: ['480px', '390px'],
		    			  offset: '100px',
		    			  btn: ['确定', '关闭'],
		    			  content: '<%=request.getContextPath()%>/appUser/system/toCreateUser',
		    			  yes: function(index, layero){
		    				    var reg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8}$/ 
								var body = layer.getChildFrame('body', index); 
								var usrid = body.find("#usrid").val();
								var password = body.find("#password").val();
								var repassword = body.find("#repassword").val();
								var userName = body.find("#userName").val();
								var existName = body.find("#existName").val();
								var remarks = body.find("#remarks").val();
								if (userName == "") {
		    				   		layer.msg('用户名不能为空！',{time:2000});
									return false;
								}
								if (existName != null && existName == "yes") {
									layer.msg('该用户名已存在！',{time:2000});
									return false;
								}
								if (password == "" || repassword == "") {
									layer.msg('密码不能为空！',{time:2000});
									return false;
								}
								if(!reg.test(password)){
									layer.msg('新密码不符合规则！',{time:2000});
									return false;
								} 
								if(!reg.test(repassword)){
									layer.msg('确认密码不符合规则！',{time:2000});
									return false;
								} 
								if (password != repassword){
									layer.msg('两次密码输入不一致！',{time:2000});
									return false;
								}
								if (remarks != "" && remarks.length > 1024) {
									layer.msg('备注信息过长！',{time:2000});
									return false;
								}
								layer.close(index);
								$.ajax({
									type: 'POST',
									url: '<%=request.getContextPath()%>/appUser/system/createUser',
									data: {
					                  userName:userName,
					                  password:password,
					                  remark:remarks
					             	},
									async:false,
									dataType: 'json',
									success: function (result) {
							               if(result.retCode == 0){
							                	if(result.data = false){
							                		layer.msg('创建用户[' + userName + ']失败!',{time:3000});
													return false;
							                	}else{
								                	layer.msg('创建用户[' + userName + ']成功!',{
								                		 icon: 1,	
								                		 time:1000,
								                		 end:function(){
								                			document.getElementById("userListForm").submit();
								                		 }});
							                	}
							                }else{
							                	console.log(result.retCode);
							                }
							        },
									error:function (response) {
										console.log("ajax error : " + response);
									}
								});
								}
			})
	}
	function updateUser(name){
		layer.open({
						  title: '用户修改',
		    			  type:2,
		    			  area: ['480px', '390px'],
		    			  offset: '100px',
		    			  btn: ['确定', '关闭'],
		    			  content: '<%=request.getContextPath()%>/appUser/system/toUpdateUser?name=' + name,
		    			  yes: function(index, layero){
		    				     var reg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8}$/ 
								var body = layer.getChildFrame('body', index); 
								var usrid = body.find("#usrid").val();
								var userName = body.find("#userName").val();
								var remarks = body.find("#remarks").val();
								var validatepwd = body.find("#validatepwd").val();
								var password = body.find("#password").val();
								var repassword = body.find("#repassword").val();
								var existName = body.find("#existName").val();
								if (userName == "") {
		    				   		layer.msg('用户名不能为空！',{time:2000});
									return false;
								}
								if (existName != null && existName == "yes") {
									layer.msg('该用户名已存在！',{time:2000});
									return false;
								}
								if (validatepwd == "no") {
									layer.msg('原有密码匹配失败！',{time:2000});
									return false;
								}
								if (password == "" || repassword == "") {
									layer.msg('密码不能为空！',{time:2000});
									return false;
								}
								if(!reg.test(password)){
									layer.msg('新密码不符合规则！',{time:2000});
									return false;
								} 
								if(!reg.test(repassword)){
									layer.msg('确认密码不符合规则！',{time:2000});
									return false;
								} 
								if (password != repassword){
									layer.msg('两次密码输入不一致！',{time:2000});
									return false;
								}
								if (remarks != "" && remarks.length > 1024) {
									layer.msg('备注信息过长！',{time:2000});
									return false;
								}
								layer.close(index);
		    				   	$.ajax({
									type: 'POST',
									url: '<%=request.getContextPath()%>/appUser/system/updateUser',
									data: {
										id:usrid,
					                    userName:userName,
					                    password:password,
					                    remark:remarks
									},
									async:false,
									dataType: 'json',
									success: function (result) {
							               if(result.retCode == 0){
							                	if(result.data = false){
							                		layer.msg('修改用户[' + name + ']失败!',{time:3000});
													return false;
							                	}else{
							                		layer.msg('修改用户[' + userName + ']成功!',{
								                		 icon: 1,	
								                		 time:1000,
								                		 end:function(){
								                			document.getElementById("userListForm").submit();
								                		 }});
							                	}
							                }else{
							                	console.log(result.retCode);
							                }
							        },
									error:function (response) {
										console.log("ajax error : " + response);
									}
								});
		    			  }
			})
	}
	function delUser(id){
		layer.confirm('是否确定删除该用户？', {
			  title :'操作确认',
			  btn: ['确定','取消'] //按钮
			}, function(){
				$.ajax({
									type: 'POST',
									url: '<%=request.getContextPath()%>/appUser/system/delUser',
						              data: {
						                  id:id
						              },
						              async:false,
						              dataType: 'text',
						              success: function (result) {
						                if(result == "success"){
						                	layer.msg('用户删除成功!',{
								                		 icon: 1,	
								                		 time:1500,
								                		 end:function(){
								                			document.getElementById("userListForm").submit();
								                		 }});
						                }else{
						                  layer.msg('删除用户失败!',{time:3000});
						                }
						              },
						              error:function (response) {
						              	console.log("ajax error : " + response);
						              }
						            });											              					              	
			});
	}
	</script>
</html>
