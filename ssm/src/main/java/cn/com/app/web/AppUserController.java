package cn.com.app.web;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.com.app.common.AES;
import cn.com.app.common.CodeMsg;
import cn.com.app.common.Result;
import cn.com.app.common.FieldEnum.UserStatusEnum;
import cn.com.app.common.FieldEnum.UserTypeEnum;
import cn.com.app.pojo.AppUser;
import cn.com.app.service.AppUserService;

@Controller
@RequestMapping(value = "/appUser")
public class AppUserController {
	@Autowired
	AppUserService appUserService;

	private static Logger logger = Logger.getLogger(AppUserController.class);
	
	@RequestMapping(value = "/login")
    public @ResponseBody String login(@RequestParam(value = "userName")String userName, @RequestParam(value = "password")String password) throws Exception{
        try {
            if (!userName.equals("") && !password.equals("")) {
            	logger.debug("controller ori password"+ password);
            	password = AES.encrypt(password);
            	logger.debug("controller encrypt password"+ password);
                SecurityUtils.getSubject().login(new UsernamePasswordToken(userName,password));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                logger.info("用户[" + userName + "]于[" + sdf.format(new Date())+"]登录系统");
                Session session = SecurityUtils.getSubject().getSession();
                int userType = (int) session.getAttribute("userType");
                if(userType == 1){
                    return "success_admin";
                } else if (userType == 0){
                    return "success_user";
                } else {
                    logger.error("there is no correct user type matched.");
                }
            }
        } catch (AuthenticationException e) {
        	logger.error(e);
        } 
        
        return "fail";
    }	
	
	@RequestMapping(value="/logout")
    public String logout(RedirectAttributes redirectAttributes){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Session session = SecurityUtils.getSubject().getSession();
        logger.info("用户[" + session.getAttribute("userName") + "]于[" + sdf.format(new Date())+"]登出系统");
        SecurityUtils.getSubject().logout();
        return "/";
    }
	
	@RequestMapping("/system/toCreateUser")
	public ModelAndView toCreateUser(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("userManage/res-xt-yhxz");
		return mav;
	}
	@RequestMapping("/system/toUpdateUser")
	public ModelAndView toUpdateUser(@RequestParam(value = "name")String userName){
		ModelAndView mav = new ModelAndView();
		try {
			AppUser user = appUserService.findByUsername(userName);
			mav.addObject("user", user);
		} catch (Exception e) {
			// TODO: handle exception
		}
		mav.setViewName("userManage/res-xt-yhxg");
		return mav;
	}
	
	@SuppressWarnings("serial")
	@RequestMapping("/system/delUser")
	public @ResponseBody String delUser(@RequestParam(value = "id")String id){
		try {
			if(appUserService.updateByAppUser(new AppUser(){
				public Integer getId() {
        	        return Integer.parseInt(id);
        	    }
				public Integer getUserState() {
			        return UserStatusEnum.USER_STATUS_VALID.getStatus();
			    }
        		public Date getUpdateTime() {
					return new Date();
				}
			}))
				return "success";
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "fail";
    }	
	
	@RequestMapping("/system/queryUserList")
	public ModelAndView userListPage(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("userManage/res-xt-yhgl");
		try {
			String pageNum = request.getParameter("number");
			String pageSize = request.getParameter("size");
			String sortField = request.getParameter("sortField");
			String sortDirection = request.getParameter("sortDirection");
			pageNum = (pageNum == null ? "1" : ("".equals(pageNum) ? "1" : pageNum));
			pageSize = (pageSize == null ? "10" : ("".equals(pageSize) ? "10" : pageSize));
			sortField = (sortField == null ? "create_time" : ("".equals(sortField) ? "create_time" : sortField));
			sortDirection = (sortDirection == null ? "desc" : ("".equals(sortDirection) ? "desc" : sortDirection));
			
			HashMap<String, Object> param = new HashMap<String,Object>();
			param.put("pageNum", pageNum);
			param.put("pageSize", pageSize);
			String rowstart = (Integer.parseInt(pageNum) - 1) * Integer.parseInt(pageSize) + "";
			param.put("rowstart", rowstart);
			param.put("sortField", sortField);
			param.put("sortDirection", sortDirection);
			List<AppUser> list = appUserService.page(param);
			int totalPage = 0;
			int size = Integer.parseInt(pageSize);
			int totalCount = appUserService.getUserInfoCount(param);
			if (totalCount % size == 0) {
				totalPage = totalCount / size;
			} else {
				totalPage = totalCount / size + 1;
			}
			HashMap<String, Object> map = new HashMap<String,Object>();
			param.put("totalCount", totalCount);
			param.put("totalPages", totalPage);
			mav.addObject("userlist", list);
			mav.addObject("PageInfo", param);
			mav.addObject("odata", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@SuppressWarnings("serial")
	@RequestMapping("/system/createUser")
    public @ResponseBody Result<Boolean> createUser(@RequestParam(value = "userName")String userName, 
    		@RequestParam(value = "password")String password,
    		@RequestParam(value = "remark")String remark){
        try {
            if (!userName.equals("") && !password.equals("")) {
            	final String pwdEncrypted = AES.encrypt(password);
            	if(appUserService.insertUser(new AppUser(){
            		public String getUsername() {
            	        return userName;
            	    }
            		public String getPassword() {
            	        return pwdEncrypted;
            	    }
            		public String getRemark() {
            			return remark;
            		}
            		public Integer getUserType() {
            			return UserTypeEnum.USER_TYPE_USER.getType();
            		}
            		public Date getCreateTime() {
            	        return new Date();
            	    }
            	}))
            		return Result.success(true);
            }
        } catch (Exception e) {
        	logger.error(e);
        	return Result.error(CodeMsg.SERVER_EXCEPTION);
        } 
        return Result.success(false);
    }	
	
	@SuppressWarnings("serial")
	@RequestMapping("/system/updateUser")
	public @ResponseBody Result<Boolean> updateUser(@RequestParam(value = "id")String id,@RequestParam(value = "userName")String userName, 
			@RequestParam(value = "password")String password,
			@RequestParam(value = "remark")String remark){
		try {
			if (!userName.equals("") && !password.equals("")) {
				final String pwdEncrypted = AES.encrypt(password);
				if(appUserService.updateByAppUser(new AppUser(){
					public Integer getId() {
	        	        return Integer.parseInt(id);
	        	    }
					public String getUsername() {
						return userName;
					}
					public String getPassword() {
						return pwdEncrypted;
					}
					public String getRemark() {
						return remark;
					}
					public Date getUpdateTime() {
						return new Date();
					}
				}))
					return Result.success(true);
			}
		} catch (Exception e) {
			logger.error(e);
			return Result.error(CodeMsg.SERVER_EXCEPTION);
		} 
		
		return Result.success(false);
	}	
	
	@SuppressWarnings("serial")
	@RequestMapping("/system/updatePwdOnly")
	public @ResponseBody Result<Boolean> updatePwdOnly(@RequestParam(value = "id")String id, 
			@RequestParam(value = "password")String password){
		try {
			if (!id.equals("") && !password.equals("")) {
				final String pwdEncrypted = AES.encrypt(password);
				if(appUserService.updateByAppUser(new AppUser(){
					public Integer getId() {
						return Integer.parseInt(id);
					}
					public String getPassword() {
						return pwdEncrypted;
					}
					public Date getUpdateTime() {
						return new Date();
					}
				}))
					return Result.success(true);
			}
		} catch (Exception e) {
			return Result.error(CodeMsg.SERVER_EXCEPTION);
		} 
		
		return Result.success(false);
	}	
	
	
	@RequestMapping("/system/isUserNameExists")
	public @ResponseBody String isUserNameExists(@RequestParam(value = "currName")String currName,
													@RequestParam(value = "userName")String userName){
		try {
			if (!StringUtils.isEmpty(userName) && !currName.equals(userName)) {
				AppUser existUser = appUserService.findByUsername(userName);
				if(existUser != null && existUser instanceof AppUser)
					return "success";
			}
		} catch (Exception e) {
			logger.error(e);
		} 
		
		return "fail";
	}	
	
	@RequestMapping(value = "/system/validatePassword")
	@ResponseBody
	public Result<Boolean> validatePassword(@RequestParam(value = "currpassword")String currpassword,
										@RequestParam(value = "passwordinput")String passwordinput){
		boolean isMatched = false;
		try {
			if(!StringUtils.isEmpty(currpassword) && !StringUtils.isEmpty(passwordinput))
				isMatched = AES.decrypt(currpassword).equals(passwordinput);
		} catch (Exception e) {
			return Result.error(CodeMsg.SERVER_EXCEPTION);
		}
		return Result.success(isMatched);
	}	
	 
}
