package cn.com.app.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.com.app.dao.AppUserMapper;
import cn.com.app.pojo.AppUser;
import cn.com.app.service.AppUserService;


@Service
public class AppUserServiceImpl implements AppUserService {
	
	@Autowired AppUserMapper appUserMapper;

	@Override
	public AppUser findByUsername(String name) {
		// TODO Auto-generated method stub
		return appUserMapper.selectByUserName(name);
	}

	@Override
	public List<AppUser> page(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return appUserMapper.page(param);
	}

	@Override
	public int getUserInfoCount(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return appUserMapper.getUserInfoCount(param);
	}

	@Override
	public boolean insertUser(AppUser appUser) {
		// TODO Auto-generated method stub
		if(appUserMapper.insertSelective(appUser) != 1)
			throw new RuntimeException("error for update artificial check status.");
		return true;
	}

	@Override
	public AppUser findById(int id) {
		// TODO Auto-generated method stub
		return appUserMapper.selectByPrimaryKey(id);
	}

	@Override
	public boolean updateByAppUser(AppUser appUser) {
		// TODO Auto-generated method stub
		if(appUserMapper.updateByPrimaryKeySelective(appUser) == 1)
			return true;
		throw new RuntimeException("error for update user info.");
	}

}
