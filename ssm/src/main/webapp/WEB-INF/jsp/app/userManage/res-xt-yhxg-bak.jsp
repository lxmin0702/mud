<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%  String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="description" content="" />
<meta name="keywords" content="" />
<title>互联网金融企业数据接入系统</title>
    <script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/layer/layer.js"></script>
<style type="text/css">

</style>
</head>
<body>

<input id="existName" type="hidden" name="existName" value="no"/>
<input id="samePassword" type="hidden" name="samePassword" value="no"/>	
<div class="M-20">
	<div class="tong1">
    	<label><font>*</font> 用户名</label>
    	<dl><input type="text" id="userName" value="${user.username}" name="userName" maxlength="15" class="tinput" onblur="ifName()" placeholder="请输入用户名">
        </dl>
    </div>
    <div class="tong1">
    	<label><font>*</font> 密码</label>
    	<dl><input type="password" id="password"  name="password" maxlength="15"  class="tinput" >
    	</dl>
	</div>
  <!--  <div id="level" class="pw-strength" style="margin-left: 27%;">           	
		<div class="pw-bar"></div>
		<div class="pw-bar-on"></div>
		<div class="pw-txt">
		<span>弱</span>
		<span>中</span>
		<span>强</span>
		</div>
   </div> -->
	<div class="tong1">
    	<label><font>*</font> 确认密码</label>
    	<dl><input type="password" id="repassword"  name="repassword" maxlength="15"  class="tinput" onchange="ifPassword()">
		</dl>
	</div>
	
	<div class="tong1">
    	<label>备注</label>
    	<dl><textarea type="textarea" id="remarks"  name="remarks" maxlength="1024" class="tinput" style="height:80px;resize:none;">${user.remark}</textarea>
    	</dl>
	</div>
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
function ifName() {
	if ($("#userName").val() != ""){
		$.ajax({
 				type: 'POST',
				url: '<%=request.getContextPath()%>/appUser/system/isUserNameExists',
				data: {
					userName:$("#userName").val()
				},
				async:false,
				dataType: 'text',
				success: function (result) {
					if(result == "success"){
						layer.msg('该用户名[' + $("#userName").val() + ']已存在！',{time:2000});
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
