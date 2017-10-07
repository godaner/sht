package com.sht.goods.service;

import java.util.List;

import com.sht.goods.po.GMessages;

public interface MessagesServiceI {
	/**
	 * selectAllMssages
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public List<GMessages> selectAllMssages(String id) throws Exception;
	
	/**
	 * 插入留言信息
	 * @throws Exception
	 */
	public int insertMessages(GMessages messages) throws Exception;
}
