package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 检索模式枚举
 * 
 * VECTOR_ONLY     - 纯向量召回
 * HYBRID          - 向量 + BM25 全文检索混合召回 (RRF融合)
 * HYBRID_RERANK   - 混合召回 + Rerank精排 (推荐)
 */
public enum RetrievalMode {
    VECTOR_ONLY("纯向量召回"),
    HYBRID("混合召回(向量+全文)"),
    HYBRID_RERANK("混合召回+Rerank精排");

    private final String label;

    RetrievalMode(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
