package com.sht.mapper;

import com.sht.po.Clazzs;
import com.sht.po.ClazzsExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ClazzsMapper {
    long countByExample(ClazzsExample example);

    int deleteByExample(ClazzsExample example);

    int deleteByPrimaryKey(Object id);

    int insert(Clazzs record);

    int insertSelective(Clazzs record);

    List<Clazzs> selectByExample(ClazzsExample example);

    Clazzs selectByPrimaryKey(Object id);

    int updateByExampleSelective(@Param("record") Clazzs record, @Param("example") ClazzsExample example);

    int updateByExample(@Param("record") Clazzs record, @Param("example") ClazzsExample example);

    int updateByPrimaryKeySelective(Clazzs record);

    int updateByPrimaryKey(Clazzs record);
}