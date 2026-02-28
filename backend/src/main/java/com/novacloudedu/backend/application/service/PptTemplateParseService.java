package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.ppt.entity.PptTemplate;
import com.novacloudedu.backend.domain.ppt.repository.PptTemplateRepository;
import com.novacloudedu.backend.domain.ppt.valueobject.PptTemplateId;
import com.novacloudedu.backend.infrastructure.ppt.PptServiceClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/**
 * PPT模板异步解析服务 —— 独立Bean，确保 @Async 代理生效。
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class PptTemplateParseService {

    private final PptTemplateRepository pptTemplateRepository;
    private final PptServiceClient pptServiceClient;

    /**
     * 异步执行语义增强解析：调用 ppt-service 的 enriched 端点。
     * <p>
     * 必须从外部 Bean 调用本方法，否则 Spring AOP 代理无法拦截 @Async。
     */
    @Async
    public void triggerEnrichedParsing(Long templateId, String templateUrl) {
        PptTemplate template = pptTemplateRepository.findById(PptTemplateId.of(templateId))
                .orElse(null);
        if (template == null) {
            log.warn("异步解析模板时找不到模板: id={}", templateId);
            return;
        }

        template.markParsing();
        pptTemplateRepository.save(template);

        try {
            PptServiceClient.ParseEnrichedResult enrichedResult =
                    pptServiceClient.parseTemplateEnriched(templateUrl);

            template.updateStructure(
                    enrichedResult.fullResponseJson(),
                    enrichedResult.coverUrl(),
                    enrichedResult.slideCount()
            );
            pptTemplateRepository.save(template);
            log.info("模板语义增强解析完成: id={}", templateId);

        } catch (Exception e) {
            log.error("模板语义增强解析失败: id={}", templateId, e);
            template.markParseFailed();
            pptTemplateRepository.save(template);
        }
    }
}
