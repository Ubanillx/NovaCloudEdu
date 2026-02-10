package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 工作流节点类型
 */
public enum NodeType {
    // 触发节点
    START("开始节点"),
    WEBHOOK("Webhook触发"),
    SCHEDULE("定时触发"),
    
    // AI节点
    LLM("大语言模型"),
    KNOWLEDGE_RETRIEVAL("知识库检索"),
    TEXT_EMBEDDING("文本向量化"),
    INTENT_RECOGNITION("意图识别"),
    ENTITY_EXTRACTION("实体抽取"),
    
    // 逻辑节点
    CONDITION("条件分支"),
    SWITCH("多路分支"),
    LOOP("循环"),
    LOOP_START("循环开始"),
    LOOP_END("循环结束"),
    PARALLEL("并行执行"),
    MERGE("合并"),
    
    // 数据处理节点
    VARIABLE_SET("设置变量"),
    VARIABLE_GET("获取变量"),
    JSON_PARSE("JSON解析"),
    TEMPLATE("模板渲染"),
    CODE("代码执行"),
    
    // 集成节点
    HTTP_REQUEST("HTTP请求"),
    DATABASE_QUERY("数据库查询"),
    FILE_READ("文件读取"),
    FILE_WRITE("文件写入"),
    
    // 输出节点
    RESPONSE("响应输出"),
    END("结束节点");
    
    private final String description;
    
    NodeType(String description) {
        this.description = description;
    }
    
    public String getDescription() {
        return description;
    }
}
