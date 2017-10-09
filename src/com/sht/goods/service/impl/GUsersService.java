package com.sht.goods.service.impl;

import java.sql.Timestamp;

import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.GCustomClazzsMapper;
import com.sht.goods.mapper.GCustomGoodsMapper;
import com.sht.goods.mapper.GCustomUsersMapper;
import com.sht.goods.po.GGoods;
import com.sht.goods.po.GUser;
import com.sht.goods.service.UsersServiceI;
import com.sht.mapper.UsersMapper;
import com.sht.po.Users;

@Service
public class GUsersService extends GBaseService implements UsersServiceI {
	@Autowired
	private GCustomGoodsMapper customGoodsMapper;
	
	@Autowired
	private GCustomUsersMapper coustomUsersMapper;
	
	@Autowired
	private UsersMapper usersMapper;
	
	@Autowired
	private GCustomClazzsMapper customClazzsMapper;
	
	@Override
	public int updateUsersMoney(GUser user) throws Exception {
		
		Users users = usersMapper.selectByPrimaryKey(user.getId());
		
		Double money = users.getMoney();//获取用户余额
		
		int result  = -1 ;
		if(money < 0 || (money - user.getPrice()) < 0){
			result = 3;//表示余额不足
		}else{
			Double rest = money - user.getPrice();
			
			user.setMoney(rest);
			
			result = coustomUsersMapper.updateUsersMoney(user);
			
			//修改商品购买信息
			GGoods goods = new GGoods();
			
			short status = 1;
			goods.setStatus(status);
			
			goods.setId(user.getGoodsId());
			
			goods.setBuyer(user.getId());
			
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			goods.setBuytime(timestamp);
			
			goods.setTorealname(user.getTorealname());
			
			String addr[] = user.getAddr().split("-");
			
			goods.setToprovince(addr[0]);
			
			goods.setTocity(addr[1]);
			
			goods.setTocounty(addr[2]);
			
			goods.setTodetail(user.getTodetail());

			goods.setPhone(user.getPhone());
			
			result = customGoodsMapper.updateGoodsPurchaseInfo(goods);
			
			//修改商品总类别信息
			String clazzsId = customClazzsMapper.selectGoodsClazz(user.getGoodsId());
			
			result = customClazzsMapper.updateClazzNum(clazzsId);
		}
		
		return result;
	}

	@Override
	public Users selectUsersInfo(String id) throws Exception {
		
		Users users = usersMapper.selectByPrimaryKey(id);
		
		return users;
	}
}
