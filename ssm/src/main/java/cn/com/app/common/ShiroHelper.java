package cn.com.app.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.SessionKey;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.apache.shiro.web.session.mgt.WebSessionKey;

import cn.com.app.pojo.AppUser;

public class ShiroHelper {
	
	 public static AppUser getUserInfo(String sessionID,HttpServletRequest request,HttpServletResponse response){
	        SessionKey key = new WebSessionKey(sessionID,request,response);
	        try{
	            Session se = SecurityUtils.getSecurityManager().getSession(key);
	            Object obj = se.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
	            SimplePrincipalCollection coll = (SimplePrincipalCollection) obj;
	            return (AppUser)coll.getPrimaryPrincipal();
	        }catch(Exception e){
	            e.printStackTrace();
	        }finally{
	        }
	        return null;
	    }
	 
}
