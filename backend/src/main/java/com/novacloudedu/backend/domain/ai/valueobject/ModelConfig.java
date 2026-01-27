package com.novacloudedu.backend.domain.ai.valueobject;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * 模型配置值对象
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ModelConfig {

    private String modelName;
    private BigDecimal temperature;
    private BigDecimal topP;
    private Integer maxTokens;

    private ModelConfig(String modelName, BigDecimal temperature, BigDecimal topP, Integer maxTokens) {
        this.modelName = modelName;
        this.temperature = temperature;
        this.topP = topP;
        this.maxTokens = maxTokens;
    }

    public static ModelConfig create(String modelName, BigDecimal temperature, BigDecimal topP, Integer maxTokens) {
        if (modelName == null || modelName.trim().isEmpty()) {
            modelName = "qwen-plus";
        }
        if (temperature == null) {
            temperature = new BigDecimal("0.7");
        }
        if (topP == null) {
            topP = new BigDecimal("0.8");
        }
        if (maxTokens == null || maxTokens <= 0) {
            maxTokens = 2000;
        }
        
        // 参数范围校验
        if (temperature.compareTo(BigDecimal.ZERO) < 0 || temperature.compareTo(BigDecimal.valueOf(2)) > 0) {
            throw new IllegalArgumentException("temperature必须在0-2之间");
        }
        if (topP.compareTo(BigDecimal.ZERO) < 0 || topP.compareTo(BigDecimal.ONE) > 0) {
            throw new IllegalArgumentException("topP必须在0-1之间");
        }
        if (maxTokens > 8000) {
            throw new IllegalArgumentException("maxTokens不能超过8000");
        }
        
        return new ModelConfig(modelName.trim(), temperature, topP, maxTokens);
    }

    public static ModelConfig defaultConfig() {
        return create("qwen-plus", new BigDecimal("0.7"), new BigDecimal("0.8"), 2000);
    }
}
