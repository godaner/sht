package com.sht.mapper;

import com.sht.po.GoodsImgs;
import com.sht.po.GoodsImgsExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GoodsImgsMapper {
    long countByExample(GoodsImgsExample example);

    int deleteByExample(GoodsImgsExample example);

    int deleteByPrimaryKey(Object id);

    int insert(GoodsImgs record);

    int insertSelective(GoodsImgs record);

    List<GoodsImgs> selectByExample(GoodsImgsExample example);

    GoodsImgs selectByPrimaryKey(Object id);

    int updateByExampleSelective(@Param("record") GoodsImgs record, @Param("example") GoodsImgsExample example);

    int updateByExample(@Param("record") GoodsImgs record, @Param("example") GoodsImgsExample example);

    int updateByPrimaryKeySelective(GoodsImgs record);

    int updateByPrimaryKey(GoodsImgs record);
}