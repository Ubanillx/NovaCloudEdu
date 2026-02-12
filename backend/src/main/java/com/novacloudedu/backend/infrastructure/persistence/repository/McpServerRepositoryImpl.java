package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.ai.entity.McpServer;
import com.novacloudedu.backend.domain.ai.repository.McpServerRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.McpServerMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.McpServerPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class McpServerRepositoryImpl implements McpServerRepository {

    private final McpServerMapper mapper;

    @Override
    public McpServer save(McpServer mcpServer) {
        McpServerPO po = toPO(mcpServer);
        if (mcpServer.getId() == null) {
            po.setCreateTime(LocalDateTime.now());
            po.setUpdateTime(LocalDateTime.now());
            po.setIsDelete(0);
            mapper.insert(po);
            mcpServer.assignId(po.getId());
        } else {
            po.setUpdateTime(LocalDateTime.now());
            mapper.updateById(po);
        }
        return mcpServer;
    }

    @Override
    public Optional<McpServer> findById(Long id) {
        McpServerPO po = mapper.selectById(id);
        if (po == null || po.getIsDelete() != null && po.getIsDelete() == 1) {
            return Optional.empty();
        }
        return Optional.of(toDomain(po));
    }

    @Override
    public List<McpServer> findByCreatorId(UserId creatorId) {
        LambdaQueryWrapper<McpServerPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(McpServerPO::getCreatorId, creatorId.value())
               .orderByDesc(McpServerPO::getCreateTime);
        return mapper.selectList(wrapper).stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<McpServer> findByIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) {
            return Collections.emptyList();
        }
        LambdaQueryWrapper<McpServerPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(McpServerPO::getId, ids);
        return mapper.selectList(wrapper).stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<McpServer> findAllEnabled() {
        LambdaQueryWrapper<McpServerPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(McpServerPO::getEnabled, 1)
               .orderByDesc(McpServerPO::getCreateTime);
        return mapper.selectList(wrapper).stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Long id) {
        mapper.deleteById(id);
    }

    private McpServerPO toPO(McpServer server) {
        McpServerPO po = new McpServerPO();
        if (server.getId() != null) {
            po.setId(server.getId());
        }
        po.setName(server.getName());
        po.setDescription(server.getDescription());
        po.setUrl(server.getUrl());
        po.setConfigJson(server.getConfigJson());
        po.setEnabled(Boolean.TRUE.equals(server.getEnabled()) ? 1 : 0);
        po.setCreatorId(server.getCreatorId() != null ? server.getCreatorId().value() : null);
        po.setCreateTime(server.getCreateTime());
        po.setUpdateTime(server.getUpdateTime());
        return po;
    }

    private McpServer toDomain(McpServerPO po) {
        return McpServer.reconstruct(
                po.getId(),
                po.getName(),
                po.getDescription(),
                po.getUrl(),
                po.getConfigJson(),
                po.getEnabled() != null && po.getEnabled() == 1,
                po.getCreatorId() != null ? UserId.of(po.getCreatorId()) : null,
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
