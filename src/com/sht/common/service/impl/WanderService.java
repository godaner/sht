package com.sht.common.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.common.po.CustomWanderLog;
import com.sht.common.service.WanderServiceI;
import com.sht.mapper.WanderLogMapper;
import com.sht.service.impl.BaseService;

/**
 * 访客记录业务实现
 * @author tom
 *
 */
@Service
public class WanderService extends BaseService implements WanderServiceI {

	
	@Autowired
	private WanderLogMapper wanderLogMapper;
	
	@Override
	public void insertWanderLog(CustomWanderLog wanderLog) throws Exception {
		wanderLog.setId(uuid());
		wanderLog.setTime(new Date());
		
		wanderLogMapper.insert(wanderLog);
	}

}
