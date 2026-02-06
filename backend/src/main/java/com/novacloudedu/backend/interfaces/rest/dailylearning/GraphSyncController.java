package com.novacloudedu.backend.interfaces.rest.dailylearning;

import com.novacloudedu.backend.application.recommendation.service.GraphDataSyncService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/dailylearning/graph-sync")
@RequiredArgsConstructor
@Tag(name = "每日学习-知识图谱同步", description = "每日学习领域下的Neo4j知识图谱数据同步接口")
public class GraphSyncController {

    private final GraphDataSyncService graphDataSyncService;

    @PostMapping("/articles/batch")
    @Operation(summary = "批量同步每日文章到知识图谱（高效批量导入）")
    public BaseResponse<Integer> batchSyncArticles(
            @RequestParam(defaultValue = "500") @Parameter(description = "每批次数量，默认500") int batchSize) {
        log.info("开始批量同步每日文章到Neo4j知识图谱，批次大小: {}", batchSize);
        int total = graphDataSyncService.batchSyncArticlesToGraph(batchSize);
        return ResultUtils.success(total);
    }


    @PostMapping("/words/batch")
    @Operation(summary = "批量同步每日单词到知识图谱（高效批量导入）")
    public BaseResponse<Integer> batchSyncWords(
            @RequestParam(defaultValue = "500") @Parameter(description = "每批次数量，默认500") int batchSize) {
        log.info("开始批量同步每日单词到Neo4j知识图谱，批次大小: {}", batchSize);
        int total = graphDataSyncService.batchSyncWordsToGraph(batchSize);
        return ResultUtils.success(total);
    }

    @PostMapping("/all/batch")
    @Operation(summary = "批量同步所有数据到知识图谱（高效批量导入）")
    public BaseResponse<String> batchSyncAll(
            @RequestParam(defaultValue = "500") @Parameter(description = "每批次数量，默认500") int batchSize) {
        log.info("开始批量同步所有数据到Neo4j知识图谱，批次大小: {}", batchSize);
        int wordTotal = graphDataSyncService.batchSyncWordsToGraph(batchSize);
        int articleTotal = graphDataSyncService.batchSyncArticlesToGraph(batchSize);
        return ResultUtils.success("批量同步完成：单词 " + wordTotal + " 个，文章 " + articleTotal + " 篇");
    }
}
