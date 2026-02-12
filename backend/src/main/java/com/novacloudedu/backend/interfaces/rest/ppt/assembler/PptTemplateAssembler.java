package com.novacloudedu.backend.interfaces.rest.ppt.assembler;

import com.novacloudedu.backend.domain.ppt.entity.PptTemplate;
import com.novacloudedu.backend.infrastructure.ppt.PptServiceClient;
import com.novacloudedu.backend.interfaces.rest.ppt.dto.response.PptGenerateResponse;
import com.novacloudedu.backend.interfaces.rest.ppt.dto.response.PptTemplateDetailResponse;
import com.novacloudedu.backend.interfaces.rest.ppt.dto.response.PptTemplateListResponse;
import org.springframework.stereotype.Component;

/**
 * PPT模板接口层装配器
 */
@Component
public class PptTemplateAssembler {

    public PptTemplateListResponse toListResponse(PptTemplate template) {
        return PptTemplateListResponse.builder()
                .id(template.getId().value())
                .name(template.getName())
                .description(template.getDescription())
                .coverUrl(template.getCoverUrl())
                .templateUrl(template.getTemplateUrl())
                .slideCount(template.getSlideCount())
                .enabled(template.isEnabled())
                .build();
    }

    public PptTemplateDetailResponse toDetailResponse(PptTemplate template) {
        return PptTemplateDetailResponse.builder()
                .id(template.getId().value())
                .name(template.getName())
                .description(template.getDescription())
                .coverUrl(template.getCoverUrl())
                .templateUrl(template.getTemplateUrl())
                .slideCount(template.getSlideCount())
                .structureJson(template.getStructureJson())
                .enabled(template.isEnabled())
                .build();
    }

    public PptGenerateResponse toGenerateResponse(PptServiceClient.GenerateResult result) {
        return PptGenerateResponse.builder()
                .fileUrl(result.fileUrl())
                .fileName(result.fileName())
                .slideCount(result.slideCount())
                .build();
    }
}
