package com.sht.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.GCustomMessagesMapper;
import com.sht.goods.po.GMessages;
import com.sht.goods.service.MessagesServiceI;
import com.sht.mapper.MessagesMapper;
@Service
public class GMessagesService extends GBaseService implements MessagesServiceI {
	
	@Autowired
	private GCustomMessagesMapper customMessagesMapper;
	
	@Autowired
	private MessagesMapper messagesMapper;
	
	@Override
	public List<GMessages> selectAllMssages(String id) throws Exception{
		
		List<GMessages> list = customMessagesMapper.selectAllMessages(id);
		
		return list;
		
	}


	@Override
	public int insertMessages(GMessages messages) throws Exception {
		// TODO Auto-generated method stub
		int result = messagesMapper.insert(messages);
		return result;
	}
	
	
}
