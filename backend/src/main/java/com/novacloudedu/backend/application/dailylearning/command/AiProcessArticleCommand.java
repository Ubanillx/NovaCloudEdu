package com.novacloudedu.backend.application.dailylearning.command;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * AI 处理文章命令
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AiProcessArticleCommand {
    
    /**
     * 文章ID（处理已有文章时使用）
     */
    private Long articleId;
    
    /**
     * 是否格式化内容为 Markdown
     */
    @Builder.Default
    private boolean formatContent = true;
    
    /**
     * 是否生成摘要
     */
    @Builder.Default
    private boolean generateSummary = true;
    
    /**
     * 摘要最大长度
     */
    @Builder.Default
    private int summaryMaxLength = 150;
}
