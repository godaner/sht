package com.sht.mapper;

import com.sht.po.WanderLog;
import com.sht.po.WanderLogExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface WanderLogMapper {
    long countByExample(WanderLogExample example);

    int deleteByExample(WanderLogExample example);

    int deleteByPrimaryKey(Object id);

    int insert(WanderLog record);

    int insertSelective(WanderLog record);

    List<WanderLog> selectByExample(WanderLogExample example);

    WanderLog selectByPrimaryKey(Object id);

    int updateByExampleSelective(@Param("record") WanderLog record, @Param("example") WanderLogExample example);

    int updateByExample(@Param("record") WanderLog record, @Param("example") WanderLogExample example);

    int updateByPrimaryKeySelective(WanderLog record);

    int updateByPrimaryKey(WanderLog record);
}