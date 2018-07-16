package cn.com.app.service;

import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import cn.com.app.pojo.AppUser;
import cn.com.app.web.AppUserController;

public class UserProfileShiro extends AuthorizingRealm{
    @Autowired
    private AppUserService userService;
    
    /**
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String loginName=(String) principalCollection.fromRealm(getName()).iterator().next();
        AppUser user=userService.findByUsername(loginName);
        if(user!=null){
            SimpleAuthorizationInfo info=new SimpleAuthorizationInfo();
            Set<String> roles = new HashSet<String>();
            roles.add(user.getUserType() + "");
            info.setRoles(roles);
            return info;
        }
        return null;
    }

    /**
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token=(UsernamePasswordToken) authenticationToken;
        try {
    		AppUser user=userService.findByUsername(token.getUsername());
    		if (user!=null && user.getPassword()!=null 
    				&& new String(token.getPassword()).equals(user.getPassword())){
    			Session session = SecurityUtils.getSubject().getSession();
    			session.setAttribute("userName",user.getUsername());
    			session.setAttribute("id",user.getId());
    			session.setAttribute("userType",user.getUserType());
    			return new SimpleAuthenticationInfo(user.getUsername(), user.getPassword(), getName());
    		}
		} catch (InvalidSessionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
        return null;
    }
}