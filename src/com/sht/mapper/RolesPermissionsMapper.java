package com.sht.mapper;

import com.sht.po.RolesPermissions;
import com.sht.po.RolesPermissionsExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface RolesPermissionsMapper {
    long countByExample(RolesPermissionsExample example);

    int deleteByExample(RolesPermissionsExample example);

    int deleteByPrimaryKey(Object id);

    int insert(RolesPermissions record);

    int insertSelective(RolesPermissions record);

    List<RolesPermissions> selectByExample(RolesPermissionsExample example);

    RolesPermissions selectByPrimaryKey(Object id);

    int updateByExampleSelective(@Param("record") RolesPermissions record, @Param("example") RolesPermissionsExample example);

    int updateByExample(@Param("record") RolesPermissions record, @Param("example") RolesPermissionsExample example);

    int updateByPrimaryKeySelective(RolesPermissions record);

    int updateByPrimaryKey(RolesPermissions record);
}