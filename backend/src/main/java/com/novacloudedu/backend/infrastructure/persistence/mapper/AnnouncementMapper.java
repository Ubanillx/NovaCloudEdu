package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AnnouncementPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

/**
 * 公告Mapper
 */
@Mapper
public interface AnnouncementMapper extends BaseMapper<AnnouncementPO> {

    /**
     * 增加浏览量
     */
    @Update("UPDATE announcement SET view_count = view_count + 1 WHERE id = #{id} AND is_delete = 0")
    int incrementViewCount(@Param("id") Long id);
}
