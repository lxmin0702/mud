alertBox = art.dialog.through;
function addUser() {
	art.dialog
			.open("u/toAdd",
					{
						width : 550,
						height : 400,
						title : "新建用户",
						lock : true,
						drag : false,
						ok : function(iframeWin, topWin) {
							var existName=iframeWin.document.getElementById("existName");
							var userName = iframeWin.document.getElementById('userName').value;
							var password = iframeWin.document.getElementById('password').value;
							var repassword = iframeWin.document.getElementById('repassword').value;
							var company_id = iframeWin.document.getElementById('company_id').value;
							var remarks = iframeWin.document.getElementById('remarks').value;
							if (userName == "") {
								alertBox({
									content : '用户名不能为空！',
									lock : true,
									drag : false,
									ok : true
								});
								return false;
							}
							if(existName.style.display!=='none'){
								alertBox({
									content : '用户名已存在！',
									lock : true,
									drag : false,
									ok : true
								});
								return false;
							}
							if (password == "" || repassword == "") {
								alertBox({
									content : '密码不能为空！',
									lock : true,
									drag : false,
									ok : true
								});
								return false;
							}
							if (password != repassword) {
								alertBox({
									content : '两次密码不一致！',
									lock : true,
									drag : false,
									ok : true
								});
								return false;
							}
							if (remarks != "" && remarks.length > 1024) {
								alertBox({
									content : '备注信息过长！',
									lock : true,
									drag : false,
									ok : true
								});
								return false;
							}
							var checks = iframeWin.document.getElementsByClassName('formcheck');
							for (var i = 0; i < checks.length; i++) {
								if (checks[i].style.display != "none") {
									alertBox({
										content : '请正确填写用户信息！',
										lock : true,
										drag : false,
										ok : true
									});
									return false;
								}
							}
							var data = {
								name : userName,
								password : password,
								company_id : company_id,
								remarks : remarks
							}
							request(data, "u/save", "对不起，新建用户失败", page);

						},
						cancel : true
					});
}
function ifName() {
	if ($("#userName").val() == "") {
		$("#existName").html("用户名不能为空！");
		$("#existName").show();
	} else {
			var data = {
					user_code : $("#user_code").val(),
					name : $("#userName").val()
				};
				request(data, "u/ifName", "服务器异常！", nameOk);
		
	}
}
function nameOk(response) {
	if (response.obj == "no") {
		$("#existName").html("用户名已存在！");
		$("#existName").show();
	} else if (response.obj == "yes") {
		$("#existName").hide();
	}
}
function ifPassword() {
	if ($("#password").val() == "" || $("#repassword").val() == "") {
		$("#differentPassword").html("密码不能为空！");
		$("#differentPassword").show();
	} else {
		if ($("#password").val() != $("#repassword").val()) {
			$("#differentPassword").html("两次密码不一致！");
			$("#differentPassword").show();
		} else {
			$("#differentPassword").hide();
		}
	}
}
function ifCompanyId() {
	if ($("#company_id").val() == "") {
		$("#unexistSourceCode").html("企业Id不能为空！");
		$("#unexistSourceCode").show();
	} else {
		var data = {
			company_id : $("#company_id").val()
		};
		request(data, "company/ifCompanyId", "服务器异常！", CompanyOk);
	}
}
function CompanyOk(response) {
	if (response.obj == "no") {
		$("#unexistSourceCode").html("企业不存在！");
		$("#unexistSourceCode").show();
	} else if (response.obj == "yes") {
		$("#unexistSourceCode").hide();
	}
}
function ifOPassword() {
	if ($("#Opassword").val() == "") {
		$("#wrongPassword").html("原密码不能为空！");
		$("#wrongPassword").show();
	} else {
		var data = {
			name : $("#userName").val(),
			password : $("#Opassword").val()
		};
		request(data, "u/ifPassword", "服务器异常！", passwordOOk);
	}
}
function passwordOOk(response) {
	if (response.obj == "no") {
		$("#wrongPassword").html("原密码错误！");
		$("#wrongPassword").show();
	} else if (response.obj == "yes") {
		$("#wrongPassword").hide();
	}
}
function editUser(user_code) {
	art.dialog.open("u/toEdit?user_code=" + user_code,
	{
		width : 550,
		height : 250,
		title : "修改用户",
		lock : true,
		drag : false,
		ok : function(iframeWin, topWin) {
			var userName = iframeWin.document.getElementById('userName').value;
			var remarks = iframeWin.document.getElementById('remarks').value;
			if (userName == "") {
				alertBox({
					content : '用户名不能为空！',
					lock : true,
					drag : false,
					ok : true
				});
				return false;
			}
			if (remarks != "" && remarks.length > 1024) {
				alertBox({
					content : '备注信息过长！',
					lock : true,
					drag : false,
					ok : true
				});
				return false;
			}
			var checks = iframeWin.document.getElementsByClassName('formcheck');
			for (var i = 0; i < checks.length; i++) {
				if (checks[i].style.display != "none"
						&& checks[i].style.display != "") {
					alertBox({
						content : '请正确填写用户信息！',
						lock : true,
						drag : false,
						ok : true
					});
					return false;
				}
			}
			var data = {
				user_code : user_code,
				name : userName,
				remarks : remarks
			}
			request(data, "u/save", "对不起，修改用户失败", page);
	
		},
		cancel : true
	});
}
function editUser2(user_code) {
	art.dialog.open("u/toEdit?user_code=" + user_code,
	{
		width : 550,
		height : 250,
		title : "修改用户",
		lock : true,
		drag : false,
		ok : function(iframeWin, topWin) {
			var userName = iframeWin.document
					.getElementById('userName').value;
			var source_code = iframeWin.document
					.getElementById('source_code').value;
			// var cert_id =
			// iframeWin.document.getElementById('cert_id').value;
			// var eff_date =
			// iframeWin.document.getElementById('eff_date').value;
			// var exp_date =
			// iframeWin.document.getElementById('exp_date').value;
			var remarks = iframeWin.document
					.getElementById('remarks').value;
			if (userName == "") {
				alertBox({
					content : '用户名不能为空！',
					lock : true,
					drag : false,
					ok : true
				});
				return false;
			}
			if (source_code == "") {
				alertBox({
					content : '平台编号不能为空！',
					lock : true,
					drag : false,
					ok : true
				});
				return false;
			}
			if (remarks != "" && remarks.length > 1024) {
				alertBox({
					content : '备注信息过长！',
					lock : true,
					drag : false,
					ok : true
				});
				return false;
			}
			var checks = iframeWin.document
					.getElementsByClassName('formcheck');
			for (var i = 0; i < checks.length; i++) {
				if (checks[i].style.display != "none"
						&& checks[i].style.display != "") {
					alertBox({
						content : '请正确填写用户信息！',
						lock : true,
						drag : false,
						ok : true
					});
					return false;
				}
			}
			var data = {
				user_code : user_code,
				name : userName,
				source_code : source_code,
				// cert_id: cert_id,
				// eff_date: eff_date,
				// exp_date: exp_date,
				remarks : remarks
			}
			request(data, "u/save", "对不起，修改用户失败", donothing);

		},
		cancel : true
	});
}
function donothing() {
	window.location.href="logout";
}
function freezeUser(user_code) {
	art.dialog.open("u/toFreeze?user_code=" + user_code, {
		width : 460,
		height : 250,
		title : "冻结与解冻",
		lock : true,
		drag : false,
		ok : function(iframeWin, topWin) {
			var freezeType = "01";
			var freezes = iframeWin.document.getElementsByName('freezeType');
			for (var i = 0; i < freezes.length; i++) {
				if (freezes[i].checked == true) {
					freezeType = freezes[i].value;
				}
			}
			if (freezeType == "03" || freezeType == "04") {
				var startFreezeTime = iframeWin.document
						.getElementById('startFreezeTime').value;
				var endFreezeTime = iframeWin.document
						.getElementById('endFreezeTime').value;
				if (startFreezeTime == "" || endFreezeTime == "") {
					alertBox({
						content : '时间不能为空！',
						lock : true,
						drag : false,
						ok : true
					});
					return false;
				}
			}
			var data = {
				user_code : user_code,
				freeze_type : freezeType,
				start_freeze_time : startFreezeTime,
				end_freeze_time : endFreezeTime
			}
			request(data, "u/freeze", "对不起，冻结设置失败！", page);

		},
		cancel : true
	});
}
function adminPwd(user_code) {
	art.dialog.open("u/toAdminPwd", {
		width : 550,
		height : 150,
		title : "修改密码",
		lock : true,
		drag : false,
		ok : function(iframeWin, topWin) {
			var pwd = iframeWin.document.getElementById('password').value;
			var repwd = iframeWin.document.getElementById('repassword').value;
			if (pwd == "" || repwd == "") {
				alertBox({ content : '密码不能为空！', lock : true, drag : false, ok : true });
				return false;
			}
			if (pwd != repwd) {
				alertBox({ content : '两次密码输入不一致！', lock : true, drag : false, ok : true });
				return false;
			}
			var data = {
				user_code : user_code,
				password : pwd
			};
			request(data, "u/adminPwd", "对不起，密码设置失败！", page);

		},
		cancel : true
	});
}
function adminPwd2(user_code) {
	art.dialog.open("u/toAdminPwd?user_code=" + user_code, {
		width : 440,
		height : 220,
		title : "修改密码",
		lock : true,
		drag : false,
		ok : function(iframeWin, topWin) {
			var pwd = iframeWin.document.getElementById('password').value;
			var repwd = iframeWin.document.getElementById('repassword').value;
			if (pwd == "" || repwd == "") {
				alertBox({ content : '密码不能为空！', lock : true, drag : false, ok : true });
				return false;
			}
			if (pwd != repwd) {
				alertBox({ content : '两次密码输入不一致！', lock : true, drag : false, ok : true });
				return false;
			}
			var data = {
				user_code : user_code,
				password : pwd
			};
			request(data, "u/adminPwd", "对不起，密码设置失败！", page);

		},
		cancel : true
	});
}
function userPwd(user_code) {
	art.dialog.open("u/toUserPwd_admin?user_code=" + user_code,
	{
		width : 550,
		height : 300,
		title : "修改密码",
		lock : true,
		drag : false,
		ok : function(iframeWin, topWin) {
			var pwd = iframeWin.document
					.getElementById('password').value;
			var repwd = iframeWin.document
					.getElementById('repassword').value;
			var oppwd = iframeWin.document
					.getElementById('Opassword').value;
			if (pwd == "" || repwd == "" || oppwd == "") {
				alertBox({
					content : '密码不能为空！',
					lock : true,
					drag : false,
					ok : true
				});
				return false;
			}
			if (pwd == oppwd) {
				alertBox({
					content : '原密码和新密码不能相同！',
					lock : true,
					drag : false,
					ok : true
				});
				return false;
			}
			if (pwd != repwd) {
				alertBox({
					content : '两次密码输入不同！',
					lock : true,
					drag : false,
					ok : true
				});
				return false;
			}
			var checks = iframeWin.document
					.getElementsByClassName('formcheck');
			for (var i = 0; i < checks.length; i++) {
				if (checks[i].style.display != "none"
						&& checks[i].style.display != "") {
					alertBox({
						content : '请正确填写用户信息！',
						lock : true,
						drag : false,
						ok : true
					});
					return false;
				}
			}
			var data = {
				user_code : user_code,
				password : pwd
			};
			request(data, "u/adminPwd_admin", "对不起，密码设置失败！",
					donothing);

		},
		cancel : true
	});
}
function page(response) {
	// window.location.href = basePath+"u/page";
	$("#userListForm").submit();
}

// 删除用户
function deleteUser(userId, userName) {
	alertBox({
		content : "确定删除用户 " + userName + " ？",
		lock : true,
		drag : false,
		ok : function() {
			var data = {
				"id" : userId
			};
			request(data, "u/delete", "删除用户失败！", page);
		},
		cancel : true
	});

}

function deleteAll() {

	var el = document.getElementsByName('userCheck');
	var sList = [];
	for (var i = 0; i < el.length; i++) {
		if (el[i].checked == true) {
			sList.push(el[i].value);
		}
	}
	if (sList.length > 0) {
		alertBox({
			content : "确定删除这 " + sList.length + " 个用户？",
			lock : true,
			drag : false,
			ok : function() {
				var data = {
					deleteList : JSON.stringify(sList)
				};
				request(data, "u/deleteAll", "对不起，删除用户失败", page);
			},
			cancel : true
		});
	} else {
		alertBox({
			content : "您未选中任何用户",
			lock : true,
			drag : false,
			ok : true
		});
	}

}
function doSearch(pasenum) {
	$("#number").val(pasenum);
	var form = document.getElementById("userListForm");
	form.submit();// 提交搜索表单
}
function doSearch1(fieldname) {

	$("#sortField").val(fieldname);

	if ($("#sortDirection").val() == "asc") {
		$("#sortDirection").val("desc");
	} else {
		$("#sortDirection").val("asc");
	}
	var form = document.getElementById("userListForm");
	form.submit();// 提交搜索表单
}
/* 全选 */
function selectAll() {
	if (this.checked == true) {
		checkAll('test');
	} else {
		clearAll('test');
	}
}
function checkAll(name) {
	var el = document.getElementsByTagName('input');
	var len = el.length;
	for (var i = 0; i < len; i++) {
		if ((el[i].type == "checkbox") && (el[i].name == name)) {
			el[i].checked = true;
		}
	}
}
function clearAll(name) {
	var el = document.getElementsByTagName('input');
	var len = el.length;
	for (var i = 0; i < len; i++) {
		if ((el[i].type == "checkbox") && (el[i].name == name)) {
			el[i].checked = false;
		}
	}
}
function checkone() {
	var el = document.getElementsByTagName('input');
	var all = document.getElementById("allchoose");
	var len = el.length;
	for (var i = 0; i < len; i++) {
		if (el[i].type == "checkbox") {
			if (el[i].checked == false) {
				all.checked = false;
				break;
			}
		}
	}
}