package com.sht.mapper;

import com.sht.po.Admins;
import com.sht.po.AdminsExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AdminsMapper {
    long countByExample(AdminsExample example);

    int deleteByExample(AdminsExample example);

    int deleteByPrimaryKey(String id);

    int insert(Admins record);

    int insertSelective(Admins record);

    List<Admins> selectByExample(AdminsExample example);

    Admins selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") Admins record, @Param("example") AdminsExample example);

    int updateByExample(@Param("record") Admins record, @Param("example") AdminsExample example);

    int updateByPrimaryKeySelective(Admins record);

    int updateByPrimaryKey(Admins record);
}