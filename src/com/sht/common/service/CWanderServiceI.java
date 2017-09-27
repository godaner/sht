package com.sht.common.service;

import com.sht.common.po.CWanderLog;

public interface CWanderServiceI {
	/**
	 * 插入一条游客记录
	 * @param wanderLog
	 * @throws Exception
	 * 
	 */
	public void insertWanderLog(CWanderLog wanderLog) throws Exception;
}
