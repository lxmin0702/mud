package cn.com.app.service;

import java.util.HashMap;
import java.util.List;

import cn.com.app.pojo.AppUser;

public interface AppUserService {
	
	public AppUser findByUsername(String name);
	
	public AppUser findById(int id);

	public List<AppUser> page(HashMap<String, Object> param);

	public int getUserInfoCount(HashMap<String, Object> param);

	public boolean insertUser(AppUser appUser);
	
	boolean updateByAppUser(AppUser appUser);
}
