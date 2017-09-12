package com.sht.users.realm;

import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.sht.users.po.CustomUsers;
import com.sht.users.service.UsersServiceI;
/**
 * Title:UsersRealm
 * <p>
 * Description:自定义realm
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月11日 下午4:02:10
 * @version 1.0
 */
public class UsersRealm extends AuthorizingRealm {

	@Autowired
	private UsersServiceI usersService;
	
	@Override
	public void setName(String name) {
		super.setName("UsersRealm");
	}

	//reaml认证方法
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		
		String username = (String) token.getPrincipal();
		
		//查询user
		CustomUsers user = usersService.selectUserByUsername(username);

		if(user == null){
			return null;
		}

		
		String password = (String) user.getPassword();
		
		String salt = (String) user.getSalt();
		
		
		//将activeUser设置simpleAuthenticationInfo
		SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(
				username, password,ByteSource.Util.bytes(salt), this.getName());

		return simpleAuthenticationInfo;
	}

	// 外部认证成功后,根据用户的身份(唯一标识符,主键)返回授权信息供外部的org.apache.shiro.authz.ModularRealmAuthorizer
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		//principals获取主身份信息,即SimpleAuthenticationInfo的principal
		String principal = (String) principals.getPrimaryPrincipal();
		
		//模拟通过根据用户的身份获取数据库中该身份的权限信息
		List<String> permissions = new ArrayList<String>();
		permissions.add("users:create");
		permissions.add("items:create");

		SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
		
		simpleAuthorizationInfo.addStringPermissions(permissions);;
		return simpleAuthorizationInfo;  
	}

}
