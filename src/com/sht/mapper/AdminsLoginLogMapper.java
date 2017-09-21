package com.sht.mapper;

import com.sht.po.AdminsLoginLog;
import com.sht.po.AdminsLoginLogExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AdminsLoginLogMapper {
    long countByExample(AdminsLoginLogExample example);

    int deleteByExample(AdminsLoginLogExample example);

    int deleteByPrimaryKey(Object id);

    int insert(AdminsLoginLog record);

    int insertSelective(AdminsLoginLog record);

    List<AdminsLoginLog> selectByExample(AdminsLoginLogExample example);

    AdminsLoginLog selectByPrimaryKey(Object id);

    int updateByExampleSelective(@Param("record") AdminsLoginLog record, @Param("example") AdminsLoginLogExample example);

    int updateByExample(@Param("record") AdminsLoginLog record, @Param("example") AdminsLoginLogExample example);

    int updateByPrimaryKeySelective(AdminsLoginLog record);

    int updateByPrimaryKey(AdminsLoginLog record);
}