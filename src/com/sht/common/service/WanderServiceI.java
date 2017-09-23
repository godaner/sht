package com.sht.common.service;

import com.sht.common.po.CustomWanderLog;

public interface WanderServiceI {
	/**
	 * 插入一条游客记录
	 * @param wanderLog
	 * @throws Exception
	 * 
	 */
	public void insertWanderLog(CustomWanderLog wanderLog) throws Exception;
}
