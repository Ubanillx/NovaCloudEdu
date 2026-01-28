package com.novacloudedu.backend.interfaces.rest.checkin;

import com.novacloudedu.backend.application.service.CheckinApplicationService;
import com.novacloudedu.backend.application.service.CheckinApplicationService.*;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.checkin.repository.CheckinRepository.CheckinRankingItem;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 打卡接口
 */
@RestController
@RequestMapping("/api/user/checkin")
@RequiredArgsConstructor
@Tag(name = "打卡接口", description = "用户打卡相关接口")
public class CheckinController {

    private final CheckinApplicationService checkinService;

    @PostMapping
    @Operation(summary = "用户打卡", description = "每日打卡，每天只能打卡一次")
    public BaseResponse<CheckinResult> checkin() {
        CheckinResult result = checkinService.checkin();
        return ResultUtils.success(result);
    }

    @GetMapping("/status")
    @Operation(summary = "获取打卡状态", description = "获取当前用户的打卡状态")
    public BaseResponse<CheckinStatusResult> getCheckinStatus() {
        CheckinStatusResult result = checkinService.getCheckinStatus();
        return ResultUtils.success(result);
    }

    @GetMapping("/ranking")
    @Operation(summary = "打卡排行榜", description = "获取打卡排行榜前10名，公开接口")
    public BaseResponse<List<CheckinRankingItem>> getCheckinRanking(
            @RequestParam(defaultValue = "10") int limit) {
        List<CheckinRankingItem> ranking = checkinService.getCheckinRanking(limit);
        return ResultUtils.success(ranking);
    }
}
