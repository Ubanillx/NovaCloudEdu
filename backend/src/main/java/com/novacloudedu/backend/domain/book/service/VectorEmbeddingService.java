package com.novacloudedu.backend.domain.book.service;

import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;

/**
 * 向量嵌入服务接口
 * 用于将文本转换为向量表示,支持 RAG 对话
 */
public interface VectorEmbeddingService {
    
    /**
     * 将文本转换为向量
     * @param text 文本内容
     * @return 向量表示
     */
    ChapterVector embedText(String text);
    
    /**
     * 批量将文本转换为向量
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
