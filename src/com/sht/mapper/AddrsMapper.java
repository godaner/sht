package com.sht.mapper;

import com.sht.po.Addrs;
import com.sht.po.AddrsExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AddrsMapper {
    long countByExample(AddrsExample example);

    int deleteByExample(AddrsExample example);

    int deleteByPrimaryKey(Object id);

    int insert(Addrs record);

    int insertSelective(Addrs record);

    List<Addrs> selectByExample(AddrsExample example);

    Addrs selectByPrimaryKey(Object id);

    int updateByExampleSelective(@Param("record") Addrs record, @Param("example") AddrsExample example);

    int updateByExample(@Param("record") Addrs record, @Param("example") AddrsExample example);

    int updateByPrimaryKeySelective(Addrs record);

    int updateByPrimaryKey(Addrs record);
}