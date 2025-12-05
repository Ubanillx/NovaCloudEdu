package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.social.entity.PrivateChatSession;
import com.novacloudedu.backend.domain.social.repository.PrivateChatSessionRepository;
import com.novacloudedu.backend.domain.social.valueobject.SessionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.PrivateChatSessionConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PrivateChatSessionMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PrivateChatSessionPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 私聊会话仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PrivateChatSessionRepositoryImpl implements PrivateChatSessionRepository {

    private final PrivateChatSessionMapper privateChatSessionMapper;
    private final PrivateChatSessionConverter privateChatSessionConverter;

    @Override
    public PrivateChatSession save(PrivateChatSession session) {
        PrivateChatSessionPO po = privateChatSessionConverter.toPO(session);
        privateChatSessionMapper.insert(po);
        session.assignId(SessionId.of(po.getId()));
        return session;
    }

    @Override
    public Optional<PrivateChatSession> findById(SessionId id) {
        PrivateChatSessionPO po = privateChatSessionMapper.selectById(id.value());
        if (po == null || po.getIsDelete() == 1) {
            return Optional.empty();
        }
        return Optional.of(privateChatSessionConverter.toDomain(po));
    }

    @Override
    public Optional<PrivateChatSession> findByUsers(UserId userId1, UserId userId2) {
        // 确保 userId1 < userId2
        Long id1 = Math.min(userId1.value(), userId2.value());
        Long id2 = Math.max(userId1.value(), userId2.value());

        LambdaQueryWrapper<PrivateChatSessionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PrivateChatSessionPO::getUserId1, id1)
                .eq(PrivateChatSessionPO::getUserId2, id2)
                .eq(PrivateChatSessionPO::getIsDelete, 0);

        PrivateChatSessionPO po = privateChatSessionMapper.selectOne(wrapper);
        if (po == null) {
            return Optional.empty();
        }
        return Optional.of(privateChatSessionConverter.toDomain(po));
    }

    @Override
    public PrivateChatSession getOrCreate(UserId userId1, UserId userId2) {
        return findByUsers(userId1, userId2)
                .orElseGet(() -> {
                    PrivateChatSession session = PrivateChatSession.create(userId1, userId2);
                    return save(session);
                });
    }

    @Override
    public List<PrivateChatSession> findByUserId(UserId userId) {
        LambdaQueryWrapper<PrivateChatSessionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w
                .eq(PrivateChatSessionPO::getUserId1, userId.value())
                .or()
                .eq(PrivateChatSessionPO::getUserId2, userId.value())
        );
        wrapper.eq(PrivateChatSessionPO::getIsDelete, 0);
        wrapper.orderByDesc(PrivateChatSessionPO::getLastMessageTime);

        return privateChatSessionMapper.selectList(wrapper).stream()
                .map(privateChatSessionConverter::toDomain)
                .toList();
    }

    @Override
    public void update(PrivateChatSession session) {
        PrivateChatSessionPO po = privateChatSessionConverter.toPO(session);
        privateChatSessionMapper.updateById(po);
    }

    @Override
    public void delete(SessionId id) {
        PrivateChatSessionPO po = privateChatSessionMapper.selectById(id.value());
        if (po != null) {
            po.setIsDelete(1);
            privateChatSessionMapper.updateById(po);
        }
    }
}
