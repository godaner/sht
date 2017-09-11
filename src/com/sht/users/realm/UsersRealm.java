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

	// 用于认证
	@Override
	public void setName(String name) {
		super.setName("UsersRealm");
	}

	
	//通过用户的身份(唯一标识符,主键)返回正确的认证信息供外部调用org.apache.shiro.authc.pam.ModularRealmAuthenticator
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		// 从token取出用户信息

		String usercode = (String) token.getPrincipal();

		String passowrd = "123";

		// 封装正确的源数据中的数据

		SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(
				usercode, passowrd, this.getName());

		
		// 查询不到返回null查询到返回AuthenticationInfo

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
