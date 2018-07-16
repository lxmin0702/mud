<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%  String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="description" content="" />
<meta name="keywords" content="" />
<title>互联网金融企业数据接入系统</title>
	<link href="<%=request.getContextPath()%>/css/xf-public.css" rel="stylesheet" />
	<link href="<%=request.getContextPath()%>/css/xf-page.css" rel="stylesheet" />
    <script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/layer/layer.js"></script>
<style type="text/css">

</style>
</head>
<body>
<input id="existName" type="hidden" name="existName" value="no"/>
<input id="usrid" type="hidden" name="usrid" value="${user.id}"/>
<input id="validatepwd" type="hidden" name="validatepwd" value="yes"/>

<div class="D-bBox"><div class="Frm-fromLisBox Mt-24">
<div class="Frm-formD"><abbr><font>*</font>用户名：</abbr>
	<dl><input class="in-T W6b"  id="userName" value="${user.username}" onblur="ifName()" <shiro:lacksRole name="1">disabled</shiro:lacksRole> /></dl></div>
<shiro:lacksRole name="1">
	<div class="Frm-formD"><abbr><font>*</font>原密码：</abbr>
		<dl><input class="in-T W6b"  id="currpassword" onblur="validatePassword()" placeholder="请输入原密码" /><span class="Ml-8 Fc-HS"> </span></dl></div>
</shiro:lacksRole>
<div class="Frm-formD"><abbr><font>*</font>新密码：</abbr>
	<dl><input class="in-T W6b" id="password" placeholder="请输入新密码" /><span class="Ml-8 Fc-H9"> 8位数字+字母</span></dl></div>
<div class="Frm-formD"><abbr><font>*</font>确认密码：</abbr>
	<dl><input class="in-T W6b" id="repassword" onchange="ifPassword()" placeholder="请确认新密码" /><span class="Ml-8 Fc-HS"> </span></dl></div>
</div>
<shiro:hasRole name="1">
	<div class="Frm-formD"><abbr>备注：</abbr>
		<dl><textarea type="textarea" id="remarks"  name="remarks" maxlength="1024" placeholder="请输入备注信息" class="in-T W6b" style="height:80px;resize:none;">${user.remark}</textarea>
	</div>
</shiro:hasRole>
</div>
</body>
<script type="text/javascript">
function ifPassword() {
	if ($("#password").val() == "" || $("#repassword").val() == "") {
		layer.msg('密码不能为空！',{time:2000});
		return false;
	} else {
		if ($("#password").val() != $("#repassword").val()) {
			layer.msg('两次密码不一致！',{time:2000});
			return false;
		}
	}
}
function validatePassword() {
	if ($("#currpassword").val() != ""){
		$.ajax({
 				type: 'POST',
				url: '<%=request.getContextPath()%>/appUser/system/validatePassword',
				data: {
					currpassword:'${user.password}',
					passwordinput:$("#currpassword").val()
				},
				async:false,
				dataType: 'json',
				success: function (result) {
	                if(result.retCode == 0){
	                	if(result.data == false){
	                		layer.msg('原密码错误！',{time:2000});
							$("#validatepwd").val("no");
							return false;
	                	}else
		                	$("#validatepwd").val("yes");
	                }else{
	                	$("#validatepwd").val("no");
	                	console.log(result.retCode);
	                }
	             },
				error:function (response) {
					console.log("ajax error : " + response);
				}
			});					             
	}
}
function ifName() {
	if ($("#userName").val() != ""){
		$.ajax({
 				type: 'POST',
				url: '<%=request.getContextPath()%>/appUser/system/isUserNameExists',
				data: {
					currName:'${user.username}',
					userName:$("#userName").val()
				},
				async:false,
				dataType: 'text',
				success: function (result) {
					if(result == "success"){
						layer.msg('用户名[' + $("#userName").val() + ']已存在！',{time:2000});
						$("#existName").val("yes");
						return false;
					}else
						$("#existName").val("no");
				},
				error:function (response) {
					console.log("ajax error : " + response);
				}
			});					             
		
	}
}
</script>
</html>
