package com.novacloudedu.backend.domain.ppt.entity;

import com.novacloudedu.backend.domain.ppt.valueobject.PptTemplateId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * PPT模板聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PptTemplate {

    private PptTemplateId id;
    private String name;
    private String description;
    private String coverUrl;
    private String templateUrl;
    private int slideCount;
    private String structureJson;
    private Long uploaderId;
    private boolean enabled;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新模板
     */
    public static PptTemplate create(String name, String description,
                                      String templateUrl, Long uploaderId) {
        validateName(name);
        validateTemplateUrl(templateUrl);

        PptTemplate t = new PptTemplate();
        t.name = name;
        t.description = description != null ? description : "";
        t.coverUrl = "";
        t.templateUrl = templateUrl;
        t.slideCount = 0;
        t.structureJson = "";
        t.uploaderId = uploaderId;
        t.enabled = true;
        t.createTime = LocalDateTime.now();
        t.updateTime = LocalDateTime.now();
        return t;
    }

    /**
     * 从持久化数据重建
     */
    public static PptTemplate reconstruct(PptTemplateId id, String name, String description,
                                           String coverUrl, String templateUrl, int slideCount,
                                           String structureJson, Long uploaderId, boolean enabled,
                                           LocalDateTime createTime, LocalDateTime updateTime) {
        PptTemplate t = new PptTemplate();
        t.id = id;
        t.name = name;
        t.description = description;
        t.coverUrl = coverUrl;
        t.templateUrl = templateUrl;
        t.slideCount = slideCount;
        t.structureJson = structureJson;
        t.uploaderId = uploaderId;
        t.enabled = enabled;
        t.createTime = createTime;
        t.updateTime = updateTime;
        return t;
    }

    public void assignId(PptTemplateId id) {
        if (this.id != null) {
            throw new IllegalStateException("模板ID已分配");
        }
        this.id = id;
    }

    /**
     * 更新解析后的结构信息
     */
    public void updateStructure(String structureJson, String coverUrl, int slideCount) {
        this.structureJson = structureJson;
        this.coverUrl = coverUrl != null ? coverUrl : this.coverUrl;
        this.slideCount = slideCount;
        this.updateTime = LocalDateTime.now();
    }

    public void enable() {
        this.enabled = true;
        this.updateTime = LocalDateTime.now();
    }

    public void disable() {
        this.enabled = false;
        this.updateTime = LocalDateTime.now();
    }

    public void update(String name, String description) {
        validateName(name);
        this.name = name;
        this.description = description != null ? description : this.description;
        this.updateTime = LocalDateTime.now();
    }

    private static void validateName(String name) {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("模板名称不能为空");
        }
        if (name.length() > 128) {
            throw new IllegalArgumentException("模板名称不能超过128个字符");
        }
    }

    private static void validateTemplateUrl(String url) {
        if (url == null || url.isBlank()) {
            throw new IllegalArgumentException("模板文件URL不能为空");
        }
    }
}
