
$(function(){
	var location = (window.location+'').split('/'); 
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	//layui.use('table', function(){});
	
	//导航内容  - 此处定义不同角色的导航栏，以及当前页面对应的菜单
/*	$(".headNav").append('<li><a href="' + basePath + '/statistics/summary">首页'
			+'</a></li><li><a href="#">APP资源管理</a><ul><li><a href="' + basePath + '/source/toBaisicInfoList">基本信息</a></li>'
			+'<li><a href="' + basePath + '/source/toDistributeList">分发信息</a></li>'
			+'<li><a href="' + basePath + '/source/toAccessList">接入信息</a></li></ul></li>'
			+'<shiro:hasRole name="1"><li>' 
			+'<a href="#">系统管理</a>'	
			+'<ul><li><a href="' + basePath + '/res-xt-yhgl.html">用户管理</a></li></ul>'
			+'</li>'
			+'</shiro:hasRole>'
			);*/
	switch(ipage){
		case 1:
		  $(".headNav").children("li").eq(0).addClass('active');
		  break;
		case 2:
		  $(".headNav").children("li").eq(1).addClass('active');
		  break;
		case 3:
		  $(".headNav").children("li").eq(2).addClass('active');
		  break;
		default:
		  //n 与 case 1 和 case 2 不同时执行的代码
	}
	//页签切换
	$(".TAB-Main .TAB-abbr abbr").click(function(){
		//$(".TAB-Main .TAB-abbr abbr").removeClass(" active");
		//$(this).parents(".TAB-Main").children(".TAB-abbr").children("abbr").removeClass(" active");
		$(this).addClass('active').siblings().removeClass('active');
		$(this).siblings().each(function(){
		    $("#"+$(this).data("mid")).hide();
		});
		$("#"+$(this).data("mid")).show();
	}); 
	//点击列表选择
	$(".sxLisTz li").click(function(){
		$(this).addClass('active').siblings().removeClass('active');
	});
	
	//点击列表选择,多级属性唯一选择
	$(".JQ-sxLisTz-DJ").find("li").click(function(){
		$(".JQ-sxLisTz-DJ").find("li").removeClass('active');
		$(this).addClass('active');
	});
	
	//通用点击单个DIV列表样式
	$(".JQ-lbdx .lb").click(function(){
		$(this).addClass('active').siblings().removeClass('active');
	})
	
	//返回或取消
	$(".JQ-return").click(function(){
		history.back(-1);
	});
	
	$(".JQ-editPassword").click(function(){
		layer.open({
			type: 2,
			closeBtn: true,
			area: ['480px', '320px'],
			shift: 7,
			title: '修改密码',
			shadeClose: true,
			btn: ['确定', '取消'],
			content: basePath + '/appUser/system/toUpdateUser?name=' + $(this).attr('related'),
			yes: function(index, layero){
				var reg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8}$/ 
				var body = layer.getChildFrame('body', index); 
				var usrid = body.find("#usrid").val();
				var validatepwd = body.find("#validatepwd").val();
				var password = body.find("#password").val();
				var repassword = body.find("#repassword").val();
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
					layer.msg('两次密码输入不匹配！',{time:2000});
					return false;
				}
				layer.close(index);
				$.ajax({
					type: 'POST',
					url: basePath + '/appUser/system/updatePwdOnly',
					data: {
						id:usrid,
						password:password
					},
					async:false,
					dataType: 'json',
					success: function (result) {
			               if(result.retCode == 0){
			                	if(result.data = false){
			                		layer.msg('修改密码失败!',{time:3000});
									return false;
			                	}else{
				                	layer.msg('修改密码成功,自动跳转后重新登录!',{
				                		 icon: 1,	
				                		 time:3000,
				                		 end:function(){
				                			window.location.href = basePath + '/appUser/logout';
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
	});
	
	/*$(".JQ-editPassword").click(function(){
		var iedmm = '<div class="D-bBox"><div class="Frm-fromLisBox Mt-24">';
		iedmm += '<div class="Frm-formD"><abbr><font>*</font>用户名：</abbr><dl><input class="in-T W6b"  placeholder="请输入帐号" /><span class="Ml-8 Fc-HS"> 不能为空</span></dl></div>';
		iedmm += '<div class="Frm-formD"><abbr><font>*</font>原密码：</abbr><dl><input class="in-T W6b"  placeholder="请输入帐号" /><span class="Ml-8 Fc-HS"> </span></dl></div>';
		iedmm += '<div class="Frm-formD"><abbr><font>*</font>新密码：</abbr><dl><input class="in-T W6b"  placeholder="请输入帐号" /><span class="Ml-8 Fc-H9"> 8位数字+字母</span></dl></div>';
		iedmm += '<div class="Frm-formD"><abbr><font>*</font>确认密码：</abbr><dl><input class="in-T W6b"  placeholder="请输入帐号" /><span class="Ml-8 Fc-HS"> </span></dl></div>';
		iedmm += '</div></div>';
		iedmm += '<div class="D-fBox"><button class="btn btnF btnWd back2 JQ-addEnt">确定</button><button class="btn JQ-qut">取消</button></div>';
		layer.open({
			type: 1,
			closeBtn: true,
			area: ['480px', '320px'],
			shift: 7,
			title: '修改密码',
			shadeClose: true,
			content:iedmm,
			success: function(layero, index) {
				$('.JQ-btneditBj').click(function() {
					layer.close(index);
				});
				$('.JQ-qut').click(function() {
					layer.close(index);
				});
			}
		});
	});*/
	
	
});

//$(document).ready(function() {
//	$.ajax( {url: "header.html",type: "GET",success: function(data){$("#headNav").html(data);}})
//});