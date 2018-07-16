<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=0">
<meta name="description" content= " 网页描述 " />
<meta name="keywords" content= " 关键字 " />
<title>APP资源管理平台</title>
<link rel="stylesheet" href=""/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/xf-public.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css">
<style>

</style>
<script src=""></script>
<script>

</script>
</head>
<body onkeydown="keyLogin();">
	<div class="title">
		<h1>APP资源管理平台</h1>
	</div>
	<div class="con-bg">
		<div class="con-bgimg"></div>
		<div class="login_box">
			<h3>用户登录</h3>
			<input id="username" type="text" placeholder="账号/用户名">
			<input id="password" type="password" placeholder="密码">
			<input id="chb" type="checkbox">
			<label for="chb">记住密码</label>
			<a id="submit" href="javascript:void(0)">登录</a>
		</div>
	</div>
	<p>建议使用IE8及以上版本的浏览器&nbsp&nbsp&nbsp&nbsp&nbsp建议分辨率为 1280*800以上</p>
	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	$('#submit').on('click',function(){
        goLogin();
    });
	
});

function goLogin(){
	$.ajax({
              type: 'POST',
              url: '<%=request.getContextPath()%>/appUser/login',
              data: {
                  userName:$("#username").val(),
                  password:$("#password").val()
              },
              async:false,
              dataType: 'text',
              success: function (result) {
               <%--  if(result == "success_admin"){
                	layer.msg('登录成功!',{time:5000});
                	window.location.href="<%=request.getContextPath()%>/statistics/summary"; 
                }else if(result == "success_user"){
                	layer.msg('登录成功!',{time:5000});
                	window.location.href="<%=request.getContextPath()%>/statistics/summary"; 
                }else{
                  layer.msg('登录失败!',{time:3000});
                } --%>
                if(result == "success_admin" || result == "success_user"){
                	layer.msg('登录成功,正在跳转...',{
													icon: 1,	
								                	time:1500,
								                	end:function(){
								                		window.location.href="<%=request.getContextPath()%>/appUser/system/queryUserList"; 
								                	}});								                		 
                }else{
                  layer.msg('登录失败!',{time:3000});
                }
              },
              error:function (response) {
              	console.log("ajax error : " + response);
              }
            });
}

function keyLogin(){  
	   if (event.keyCode==13){
	        goLogin();
	    }  
	} 
</script>
</body>
</html>
