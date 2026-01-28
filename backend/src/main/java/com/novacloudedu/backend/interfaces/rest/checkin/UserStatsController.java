package com.novacloudedu.backend.interfaces.rest.checkin;

import com.novacloudedu.backend.application.service.CheckinApplicationService;
import com.novacloudedu.backend.application.service.CheckinApplicationService.UserStatsResult;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 用户统计数据接口
 */
@RestController
@RequestMapping("/api/user/stats")
@RequiredArgsConstructor
@Tag(name = "用户统计接口", description = "用户个人数据统计接口")
public class UserStatsController {

    private final CheckinApplicationService checkinService;

    @GetMapping
    @Operation(summary = "获取用户统计数据", description = "获取当前用户的注册天数、打卡天数、帖子获赞数等统计数据")
    public BaseResponse<UserStatsResult> getUserStats() {
        UserStatsResult result = checkinService.getUserStats();
        return ResultUtils.success(result);
    }
}
