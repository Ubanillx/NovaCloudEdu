# AI功能集成指南 - 阿里云灵积平台

## 📋 概述

本项目已集成阿里云灵积平台（DashScope）实现以下AI功能：
1. **章节智能总结** - 自动生成章节摘要和要点
2. **智能问答对话** - 基于RAG的书籍内容问答
3. **知识点提取** - 自动识别和提取关键概念
4. **阅读理解测试** - 自动生成测试题目

## 🔧 已完成的配置

### 1. Maven依赖

已添加阿里云DashScope SDK到 `pom.xml`:

```xml
<!-- 阿里云 DashScope SDK (灵积平台) -->
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>dashscope-sdk-java</artifactId>
    <version>2.16.7</version>
</dependency>
```

### 2. YAML配置

在 `application.yml` 中配置：

```yaml
ai:
  dashscope:
    # API密钥 (通过环境变量设置)
    api-key: ${DASHSCOPE_API_KEY:your-dashscope-api-key-here}
    
    # LLM 模型配置
    llm:
      model-name: qwen-turbo  # 可选: qwen-turbo, qwen-plus, qwen-max
      temperature: 0.7
      max-tokens: 2000
      top-p: 0.8
    
    # Embedding 模型配置
    embedding:
      model-name: text-embedding-v2
      dimension: 1536
  
  # RAG 配置
  rag:
    enabled: true
    top-k: 5
    similarity-threshold: 0.7
    chunk-size: 500
```

### 3. 核心服务实现

#### DashScopeConfig
- 配置类：`com.novacloudedu.backend.config.DashScopeConfig`
- 初始化 Generation 和 TextEmbedding 客户端

#### DashScopeLlmService
- 实现类：`com.novacloudedu.backend.infrastructure.ai.DashScopeLlmService`
- 实现 `LlmService` 接口
- 支持单轮对话、多轮对话、系统提示词对话

#### DashScopeEmbeddingService
- 实现类：`com.novacloudedu.backend.infrastructure.ai.DashScopeEmbeddingService`
- 实现 `VectorEmbeddingService` 接口
- 支持单文本和批量文本向量化

## 🚀 使用指南

### 1. 获取API密钥

1. 访问 [阿里云灵积平台](https://dashscope.aliyun.com/)
2. 注册并登录账号
3. 在控制台获取 API Key

### 2. 配置环境变量

**Linux/Mac:**
```bash
export DASHSCOPE_API_KEY=your-actual-api-key
```

**Windows:**
```cmd
set DASHSCOPE_API_KEY=your-actual-api-key
```

**或在 application-dev.yml 中配置:**
```yaml
ai:
  dashscope:
    api-key: sk-xxxxxxxxxxxxxxxxxxxxxxxx
```

### 3. 启动应用

```bash
./mvnw spring-boot:run
```

## 📊 领域模型

### 实体 (Entity)

1. **AiConversation** - AI对话记录
   - 支持多轮对话历史
   - 区分对话类型（总结/问答/知识点/测试）

2. **ChapterSummary** - 章节总结
   - 支持多种总结类型（简短/详细/要点）
   - 自动缓存机制

3. **KnowledgePoint** - 知识点
   - 支持多种类型（概念/术语/公式/原理/方法）
   - 关联其他知识点和章节

4. **ReadingQuiz** - 阅读测试
   - 支持多种题型（选择/填空/判断/简答）
   - 自动评分功能

### 值对象 (Value Object)

- `ConversationType` - 对话类型枚举
- `SummaryType` - 总结类型枚举
- `KnowledgePointType` - 知识点类型枚举
- `QuestionType` - 题目类型枚举
- `QuestionDifficulty` - 题目难度枚举

## 🔄 待实现功能

### 应用服务层

需要创建以下应用服务：

1. **ChapterSummaryApplicationService**
   - `generateSummary(chapterId, summaryType)` - 生成章节总结
   - `getSummary(chapterId, summaryType)` - 获取缓存的总结

2. **AiQuestionApplicationService**
   - `askQuestion(bookId, question, conversationId)` - 智能问答
   - `continueConversation(conversationId, question)` - 继续对话

3. **KnowledgePointApplicationService**
   - `extractKnowledgePoints(chapterId)` - 提取知识点
   - `getKnowledgePoints(chapterId)` - 获取知识点列表

4. **ReadingQuizApplicationService**
   - `generateQuiz(chapterId, count, difficulty)` - 生成测试题
   - `submitAnswers(quizId, answers)` - 提交答案并评分

### 数据库表

需要在 `sql/book.sql` 中添加：

```sql
-- AI对话表
CREATE TABLE ai_conversation (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    chapter_id BIGINT,
    conversation_type VARCHAR(20) NOT NULL,
    messages JSONB NOT NULL,
    create_time TIMESTAMP NOT NULL,
    update_time TIMESTAMP NOT NULL
);

-- 章节总结表
CREATE TABLE chapter_summary (
    id BIGSERIAL PRIMARY KEY,
    chapter_id BIGINT NOT NULL,
    summary_type VARCHAR(20) NOT NULL,
    content TEXT NOT NULL,
    key_points JSONB,
    ai_model VARCHAR(50) NOT NULL,
    is_cached BOOLEAN DEFAULT TRUE,
    create_time TIMESTAMP NOT NULL
);

-- 知识点表
CREATE TABLE knowledge_point (
    id BIGSERIAL PRIMARY KEY,
    chapter_id BIGINT NOT NULL,
    point_type VARCHAR(20) NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    position INT,
    related_chapter_ids JSONB,
    related_point_ids JSONB,
    create_time TIMESTAMP NOT NULL
);

-- 阅读测试表
CREATE TABLE reading_quiz (
    id BIGSERIAL PRIMARY KEY,
    chapter_id BIGINT NOT NULL,
    questions JSONB NOT NULL,
    ai_model VARCHAR(50) NOT NULL,
    create_time TIMESTAMP NOT NULL
);
```

## 📝 API接口示例

### 生成章节总结
```
POST /api/books/{bookId}/chapters/{chapterId}/summary
{
  "summaryType": "detailed",
  "language": "zh"
}
```

### 智能问答
```
POST /api/books/{bookId}/ai/chat
{
  "question": "这一章的主要内容是什么？",
  "chapterId": 5,
  "conversationId": "optional-conversation-id"
}
```

### 提取知识点
```
GET /api/books/{bookId}/chapters/{chapterId}/knowledge-points
```

### 生成测试题
```
POST /api/books/{bookId}/chapters/{chapterId}/quiz
{
  "questionCount": 5,
  "difficulty": "medium",
  "types": ["choice", "fill"]
}
```

## ⚠️ 注意事项

1. **API调用成本**
   - 通义千问按token计费，建议启用缓存
   - 向量化按次数计费，批量处理可降低成本

2. **性能优化**
   - 总结结果自动缓存7天
   - 向量化结果存储在数据库
   - 使用异步处理避免阻塞

3. **错误处理**
   - API调用失败会抛出 RuntimeException
   - 建议在应用层添加重试机制
   - 记录详细日志便于排查问题

4. **安全性**
   - API Key 通过环境变量配置
   - 不要将密钥提交到代码仓库
   - 生产环境使用密钥管理服务

## 🔗 相关文档

- [阿里云灵积平台文档](https://help.aliyun.com/zh/dashscope/)
- [通义千问API文档](https://help.aliyun.com/zh/dashscope/developer-reference/api-details)
- [文本向量化API文档](https://help.aliyun.com/zh/dashscope/developer-reference/text-embedding-api-details)

## 📞 技术支持

如遇到问题，请查看：
1. 日志输出（`logging.level.com.novacloudedu.backend: debug`）
2. DashScope SDK 文档
3. 项目 Issue 跟踪
