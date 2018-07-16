package cn.com.app.dao;

import java.util.HashMap;
import java.util.List;

import cn.com.app.pojo.AppUser;

public interface AppUserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(AppUser record);

    int insertSelective(AppUser record);

    AppUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AppUser record);

    int updateByPrimaryKey(AppUser record);

	AppUser selectByUserName(String name);

	List<AppUser> page(HashMap<String, Object> param);

	int getUserInfoCount(HashMap<String, Object> param);
}