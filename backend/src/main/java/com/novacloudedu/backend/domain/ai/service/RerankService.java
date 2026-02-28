package com.novacloudedu.backend.domain.ai.service;

import java.util.List;

/**
 * 文档重排序服务接口
 * 用于对向量召回的文档进行二次精排，提升检索质量
 */
public interface RerankService {

    /**
     * 对文档列表按与查询的相关性重新排序
     *
     * @param query     用户查询
     * @param documents 待排序的文档内容列表
     * @param topN      返回前 N 个结果
     * @return 按相关性降序排列的重排序结果
     */
    List<RerankResult> rerank(String query, List<String> documents, int topN);

    /**
     * 对文档列表按与查询的相关性重新排序（指定模型）
     */
    default List<RerankResult> rerank(String query, List<String> documents, int topN, String modelName) {
        return rerank(query, documents, topN);
    }

    /**
     * 重排序结果
     */
    record RerankResult(
            int index,
            double relevanceScore,
            String document
    ) {}
}
