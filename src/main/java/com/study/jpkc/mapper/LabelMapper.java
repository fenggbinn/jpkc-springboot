package com.study.jpkc.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.study.jpkc.entity.Label;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author isharlan.hu@gmail.com
 * @since 2020-12-18
 */
@Mapper
public interface LabelMapper extends BaseMapper<Label> {

    /**
     * 查询所有标签
     * @return 所有标签
     */
    @Select("select * from t_label")
    List<Label> selectAll();

}