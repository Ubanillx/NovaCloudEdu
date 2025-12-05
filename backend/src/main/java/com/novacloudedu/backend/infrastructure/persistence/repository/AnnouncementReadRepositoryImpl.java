package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.announcement.entity.AnnouncementRead;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementReadRepository;
import com.novacloudedu.backend.infrastructure.persistence.converter.AnnouncementReadConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AnnouncementReadMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AnnouncementReadPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 公告阅读记录仓储实现
 */
@Repository
@RequiredArgsConstructor
public class AnnouncementReadRepositoryImpl implements AnnouncementReadRepository {

    private final AnnouncementReadMapper announcementReadMapper;
    private final AnnouncementReadConverter announcementReadConverter;

    @Override
    public AnnouncementRead save(AnnouncementRead read) {
        AnnouncementReadPO po = announcementReadConverter.toPO(read);
        if (read.getId() == null) {
            announcementReadMapper.insert(po);
            read.assignId(po.getId());
        } else {
            announcementReadMapper.updateById(po);
        }
        return read;
    }

    @Override
    public Optional<AnnouncementRead> findByAnnouncementIdAndUserId(Long announcementId, Long userId) {
        LambdaQueryWrapper<AnnouncementReadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnnouncementReadPO::getAnnouncementId, announcementId)
               .eq(AnnouncementReadPO::getUserId, userId);
        AnnouncementReadPO po = announcementReadMapper.selectOne(wrapper);
        return Optional.ofNullable(announcementReadConverter.toDomain(po));
    }

    @Override
    public boolean existsByAnnouncementIdAndUserId(Long announcementId, Long userId) {
        LambdaQueryWrapper<AnnouncementReadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnnouncementReadPO::getAnnouncementId, announcementId)
               .eq(AnnouncementReadPO::getUserId, userId);
        return announcementReadMapper.selectCount(wrapper) > 0;
    }

    @Override
    public List<Long> findReadAnnouncementIdsByUserId(Long userId) {
        LambdaQueryWrapper<AnnouncementReadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnnouncementReadPO::getUserId, userId)
               .select(AnnouncementReadPO::getAnnouncementId);
        return announcementReadMapper.selectList(wrapper).stream()
                .map(AnnouncementReadPO::getAnnouncementId)
                .toList();
    }

    @Override
    public long countByAnnouncementId(Long announcementId) {
        LambdaQueryWrapper<AnnouncementReadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnnouncementReadPO::getAnnouncementId, announcementId);
        return announcementReadMapper.selectCount(wrapper);
    }

    @Override
    public List<Long> findReadAnnouncementIds(Long userId, List<Long> announcementIds) {
        if (announcementIds == null || announcementIds.isEmpty()) {
            return List.of();
        }
        LambdaQueryWrapper<AnnouncementReadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnnouncementReadPO::getUserId, userId)
               .in(AnnouncementReadPO::getAnnouncementId, announcementIds)
               .select(AnnouncementReadPO::getAnnouncementId);
        return announcementReadMapper.selectList(wrapper).stream()
                .map(AnnouncementReadPO::getAnnouncementId)
                .toList();
    }
}
