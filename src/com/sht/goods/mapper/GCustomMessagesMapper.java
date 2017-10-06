package com.sht.goods.mapper;

import java.util.List;

import com.sht.goods.po.GMessages;

public interface GCustomMessagesMapper {
	
	/**
	 * 查询所有留言信息
	 * @param id
	 * @return
	 */
	public List<GMessages> selectAllMessages(String id);

}
