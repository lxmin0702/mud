package cn.com.app.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;

public class RootFilter extends AccessControlFilter {
	
	
	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue)
			throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpServletRequest servletRequest = (HttpServletRequest) request;
		HttpServletResponse servletResponse = (HttpServletResponse) response;
		/*String prePath = servletRequest.getHeader("Referer");
		String path = servletRequest.getRequestURI();*/
		try {
			Subject subject = getSubject(request, response);

			if (subject.getPrincipal() != null){
				/*if(path.indexOf("statistics/summary") > -1)
					return false;*/
//				servletResponse.sendRedirect(servletRequest.getContextPath()+"/statistics/summary");
				// home page filter
				servletResponse.sendRedirect(servletRequest.getContextPath()+"/appUser/system/queryUserList");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
		return true;
	}

}
