package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.WorkflowDefinition;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 工作流版本历史实体
 * <p>
 * 每次发布工作流时创建一个版本快照，记录发布时刻的名称、描述和定义。
 */
@Getter
public class WorkflowVersion {

    private Long id;
    private WorkflowId workflowId;
    private int version;
    private String name;
    private String description;
    private WorkflowDefinition definition;
    private String publishNote;
    private UserId publishedBy;
    private LocalDateTime createTime;

    private WorkflowVersion() {}

    /**
     * 创建新版本快照
     */
    public static WorkflowVersion create(WorkflowId workflowId, int version,
                                          String name, String description,
                                          WorkflowDefinition definition,
                                          String publishNote, UserId publishedBy) {
        WorkflowVersion wv = new WorkflowVersion();
        wv.workflowId = workflowId;
        wv.version = version;
        wv.name = name;
        wv.description = description;
        wv.definition = definition;
        wv.publishNote = publishNote;
        wv.publishedBy = publishedBy;
        wv.createTime = LocalDateTime.now();
        return wv;
    }

    /**
     * 从持久化数据重建实体
     */
    public static WorkflowVersion reconstruct(Long id, WorkflowId workflowId, int version,
                                               String name, String description,
                                               WorkflowDefinition definition,
                                               String publishNote, UserId publishedBy,
                                               LocalDateTime createTime) {
        WorkflowVersion wv = new WorkflowVersion();
        wv.id = id;
        wv.workflowId = workflowId;
        wv.version = version;
        wv.name = name;
        wv.description = description;
        wv.definition = definition;
        wv.publishNote = publishNote;
        wv.publishedBy = publishedBy;
        wv.createTime = createTime;
        return wv;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
