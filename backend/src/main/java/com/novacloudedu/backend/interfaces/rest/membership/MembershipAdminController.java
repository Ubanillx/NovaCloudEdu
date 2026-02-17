package com.novacloudedu.backend.interfaces.rest.membership;

import com.novacloudedu.backend.application.membership.service.MembershipApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.membership.entity.MembershipPlan;
import com.novacloudedu.backend.domain.membership.entity.UserMembership;
import com.novacloudedu.backend.domain.membership.valueobject.MembershipStatus;
import com.novacloudedu.backend.domain.membership.valueobject.PlanCode;
import com.novacloudedu.backend.interfaces.rest.membership.dto.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/membership")
@RequiredArgsConstructor
@Tag(name = "会员管理（管理员）", description = "管理员会员管理接口")
public class MembershipAdminController {

    private final MembershipApplicationService membershipApplicationService;

    // ==================== 计划管理 ====================

    @GetMapping("/plans")
    @Operation(summary = "获取所有会员计划")
    public BaseResponse<List<MembershipPlan>> listPlans() {
        return ResultUtils.success(membershipApplicationService.listPlans());
    }

    @PostMapping("/plans")
    @Operation(summary = "创建会员计划")
    public BaseResponse<MembershipPlan> createPlan(@Valid @RequestBody CreatePlanRequest request) {
        MembershipPlan plan = membershipApplicationService.createPlan(
                request.getName(),
                PlanCode.fromValue(request.getCode()),
                request.getDescription(),
                request.getPrice(),
                request.getDurationDays()
        );
        return ResultUtils.success(plan);
    }

    @PutMapping("/plans")
    @Operation(summary = "更新会员计划基本信息")
    public BaseResponse<Void> updatePlan(@Valid @RequestBody UpdatePlanRequest request) {
        membershipApplicationService.updatePlan(
                request.getId(),
                request.getName(),
                request.getDescription(),
                request.getPrice(),
                request.getDurationDays()
        );
        return ResultUtils.success(null);
    }

    @PutMapping("/plans/{planId}/quota")
    @Operation(summary = "修改计划AI配额")
    public BaseResponse<Void> updatePlanQuota(@PathVariable Long planId,
                                               @Valid @RequestBody UpdatePlanQuotaRequest request) {
        membershipApplicationService.updatePlanQuota(
                planId,
                request.getAiChatDailyLimit(), request.getAiChatMonthlyLimit(),
                request.getAiPptDailyLimit(), request.getAiPptMonthlyLimit(),
                request.getAiExamDailyLimit(), request.getAiExamMonthlyLimit(),
                request.getAiBookDailyLimit(), request.getAiBookMonthlyLimit()
        );
        return ResultUtils.success(null);
    }

    @DeleteMapping("/plans/{planId}")
    @Operation(summary = "删除会员计划")
    public BaseResponse<Void> deletePlan(@PathVariable Long planId) {
        membershipApplicationService.deletePlan(planId);
        return ResultUtils.success(null);
    }

    // ==================== 会员管理 ====================

    @PostMapping("/confirm")
    @Operation(summary = "确认会员支付（管理员手动确认）")
    public BaseResponse<Void> confirmPayment(@RequestParam @Parameter(description = "会员订单号") String orderNo) {
        membershipApplicationService.confirmMembershipPayment(orderNo);
        return ResultUtils.success(null);
    }

    @PostMapping("/grant")
    @Operation(summary = "为用户直接开通会员")
    public BaseResponse<Void> grantMembership(@Valid @RequestBody GrantMembershipRequest request) {
        membershipApplicationService.grantMembership(request.getUserId(), request.getPlanId());
        return ResultUtils.success(null);
    }

    @PostMapping("/cancel/{userId}")
    @Operation(summary = "取消用户会员")
    public BaseResponse<Void> cancelMembership(@PathVariable Long userId) {
        membershipApplicationService.cancelMembership(userId);
        return ResultUtils.success(null);
    }

    @GetMapping("/list")
    @Operation(summary = "按状态查询会员列表")
    public BaseResponse<List<UserMembership>> listMemberships(
            @RequestParam(required = false) @Parameter(description = "状态：0-待支付，1-生效中，2-已过期，3-已取消") Integer status,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        MembershipStatus membershipStatus = status != null
                ? MembershipStatus.fromCode(status)
                : MembershipStatus.ACTIVE;
        return ResultUtils.success(membershipApplicationService.listMembershipsByStatus(membershipStatus, page, size));
    }

    @GetMapping("/statistics")
    @Operation(summary = "会员统计")
    public BaseResponse<Map<String, Long>> getStatistics() {
        return ResultUtils.success(Map.of(
                "pending", membershipApplicationService.countByStatus(MembershipStatus.PENDING),
                "active", membershipApplicationService.countByStatus(MembershipStatus.ACTIVE),
                "expired", membershipApplicationService.countByStatus(MembershipStatus.EXPIRED),
                "cancelled", membershipApplicationService.countByStatus(MembershipStatus.CANCELLED)
        ));
    }

    @GetMapping("/users/{userId}/ai-quota")
    @Operation(summary = "查询指定用户的AI额度")
    public BaseResponse<Map<String, Map<String, Integer>>> getUserAiQuota(@PathVariable Long userId) {
        return ResultUtils.success(membershipApplicationService.getAiQuota(userId));
    }
}
