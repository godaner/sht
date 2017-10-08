package com.sht.mapper;

import com.sht.po.UsersLoginLog;
import com.sht.po.UsersLoginLogExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UsersLoginLogMapper {
    long countByExample(UsersLoginLogExample example);

    int deleteByExample(UsersLoginLogExample example);

    int deleteByPrimaryKey(Object id);

    int insert(UsersLoginLog record);

    int insertSelective(UsersLoginLog record);

    List<UsersLoginLog> selectByExample(UsersLoginLogExample example);

    UsersLoginLog selectByPrimaryKey(Object id);

    int updateByExampleSelective(@Param("record") UsersLoginLog record, @Param("example") UsersLoginLogExample example);

    int updateByExample(@Param("record") UsersLoginLog record, @Param("example") UsersLoginLogExample example);

    int updateByPrimaryKeySelective(UsersLoginLog record);

    int updateByPrimaryKey(UsersLoginLog record);
}