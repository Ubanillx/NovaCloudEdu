package com.novacloudedu.backend.domain.book.service;

import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;

/**
 * 向量嵌入服务接口
 * 用于将文本转换为向量表示,支持 RAG 对话
 */
public interface VectorEmbeddingService {
    
    /**
     * 将文本转换为向量（文档入库时使用，text_type=document）
     * @param text 文本内容
     * @return 向量表示
     */
    ChapterVector embedText(String text);

    /**
     * 将查询文本转换为向量（RAG检索时使用，text_type=query）
     * DashScope 等非对称 embedding 模型要求 query 和 document 使用不同的 text_type
     * @param query 查询文本
     * @return 向量表示
     */
    default ChapterVector embedQuery(String query) {
        return embedText(query);
    }
    
    /**
     * 批量将文本转换为向量（文档入库，text_type=document）
     * @param texts 文本列表
     * @return 向量列表
     */
    ChapterVector[] embedTexts(String[] texts);
    
    /**
     * 获取向量维度
     */
    int getDimension();
    
    /**
     * 获取使用的模型名称
     */
    String getModelName();
}
