package com.novacloudedu.backend.domain.ppt.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * PPT项目聚合根
 * 一个项目包含多个参考文档，可关联多个生成会话
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PptProject {

    private Long id;
    private Long userId;
    private String name;
    private String description;
    private List<PptProjectDocument> documents = new ArrayList<>();
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static PptProject create(Long userId, String name, String description) {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("项目名称不能为空");
        }
        PptProject p = new PptProject();
        p.userId = userId;
        p.name = name;
        p.description = description;
        p.createTime = LocalDateTime.now();
        p.updateTime = LocalDateTime.now();
        return p;
    }

    public static PptProject reconstruct(Long id, Long userId, String name, String description,
                                          List<PptProjectDocument> documents,
                                          LocalDateTime createTime, LocalDateTime updateTime) {
        PptProject p = new PptProject();
        p.id = id;
        p.userId = userId;
        p.name = name;
        p.description = description;
        p.documents = documents != null ? documents : new ArrayList<>();
        p.createTime = createTime;
        p.updateTime = updateTime;
        return p;
    }

    public void assignId(Long id) {
        if (this.id != null) throw new IllegalStateException("项目ID已分配");
        this.id = id;
    }

    public void updateInfo(String name, String description) {
        if (name != null && !name.isBlank()) this.name = name;
        this.description = description;
        this.updateTime = LocalDateTime.now();
    }

    public void verifyOwner(Long userId) {
        if (!this.userId.equals(userId)) {
            throw new IllegalStateException("无权操作此项目");
        }
    }
}
