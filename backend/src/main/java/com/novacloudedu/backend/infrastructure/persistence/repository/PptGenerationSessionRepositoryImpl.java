package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.ppt.entity.PptGenerationSession;
import com.novacloudedu.backend.domain.ppt.repository.PptGenerationSessionRepository;
import com.novacloudedu.backend.infrastructure.persistence.converter.PptGenerationSessionConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PptGenerationSessionMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PptGenerationSessionPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * PPT生成会话仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PptGenerationSessionRepositoryImpl implements PptGenerationSessionRepository {

    private final PptGenerationSessionMapper mapper;
    private final PptGenerationSessionConverter converter;

    @Override
    public PptGenerationSession save(PptGenerationSession session) {
        PptGenerationSessionPO po = converter.toPO(session);
        if (session.getId() == null) {
            mapper.insert(po);
            session.assignId(po.getId());
        } else {
            mapper.updateById(po);
        }
        return session;
    }

    @Override
    public Optional<PptGenerationSession> findById(Long id) {
        PptGenerationSessionPO po = mapper.selectById(id);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<PptGenerationSession> findByUserId(Long userId) {
        LambdaQueryWrapper<PptGenerationSessionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PptGenerationSessionPO::getUserId, userId)
                .orderByDesc(PptGenerationSessionPO::getUpdateTime);
        return mapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteById(Long id) {
        mapper.deleteById(id);
    }
}
