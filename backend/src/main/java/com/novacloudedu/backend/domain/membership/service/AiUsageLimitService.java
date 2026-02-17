package com.novacloudedu.backend.domain.membership.service;

import com.novacloudedu.backend.domain.membership.entity.MembershipPlan;
import com.novacloudedu.backend.domain.membership.entity.UserMembership;
import com.novacloudedu.backend.domain.membership.repository.AiUsageRecordRepository;
import com.novacloudedu.backend.domain.membership.repository.MembershipPlanRepository;
import com.novacloudedu.backend.domain.membership.repository.UserMembershipRepository;
import com.novacloudedu.backend.domain.membership.valueobject.AiFeatureType;
import com.novacloudedu.backend.domain.membership.valueobject.PlanCode;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.email.UserEmailNotifier;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * AI使用额度领域服务
 * 
 * 负责检查用户AI功能使用额度并扣减
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AiUsageLimitService {

    private final UserRepository userRepository;
    private final UserMembershipRepository userMembershipRepository;
    private final MembershipPlanRepository membershipPlanRepository;
    private final AiUsageRecordRepository aiUsageRecordRepository;
    private final UserEmailNotifier userEmailNotifier;

    /**
     * 检查并消费一次AI使用额度
     * 
     * @param userId      用户ID
     * @param featureType AI功能类型
     * @throws BusinessException 如果额度不足
     */
    @Transactional
    public void checkAndConsume(Long userId, AiFeatureType featureType) {
        // 管理员不受限制
        Optional<User> userOpt = userRepository.findById(UserId.of(userId));
        if (userOpt.isPresent() && userOpt.get().isAdmin()) {
            log.debug("管理员[{}]不受AI额度限制", userId);
            aiUsageRecordRepository.incrementUsage(UserId.of(userId), featureType, LocalDate.now());
            return;
        }

        MembershipPlan plan = getUserPlan(userId);

        // 检查每日限额
        int dailyLimit = plan.getDailyLimit(featureType);
        int todayUsage = 0;
        if (dailyLimit != -1) {
            LocalDate today = LocalDate.now();
            Optional<com.novacloudedu.backend.domain.membership.entity.AiUsageRecord> record =
                    aiUsageRecordRepository.findByUserIdAndFeatureTypeAndDate(UserId.of(userId), featureType, today);
            todayUsage = record.map(com.novacloudedu.backend.domain.membership.entity.AiUsageRecord::getUsageCount).orElse(0);
            if (todayUsage >= dailyLimit) {
                userEmailNotifier.notifyAiQuotaExhausted(userId, featureType.getDescription(), dailyLimit, "每日");
                throw new BusinessException(42900,
                        String.format("今日%s额度已用尽（%d/%d），请明天再试或升级会员",
                                featureType.getDescription(), todayUsage, dailyLimit));
            }
        }

        // 检查每月限额
        int monthlyLimit = plan.getMonthlyLimit(featureType);
        int monthlyUsage = 0;
        if (monthlyLimit != -1) {
            LocalDate today = LocalDate.now();
            monthlyUsage = aiUsageRecordRepository.sumMonthlyUsage(
                    UserId.of(userId), featureType, today.getYear(), today.getMonthValue());
            if (monthlyUsage >= monthlyLimit) {
                userEmailNotifier.notifyAiQuotaExhausted(userId, featureType.getDescription(), monthlyLimit, "每月");
                throw new BusinessException(42901,
                        String.format("本月%s额度已用尽（%d/%d），请下月再试或升级会员",
                                featureType.getDescription(), monthlyUsage, monthlyLimit));
            }
        }

        // 额度充足，增加使用计数
        aiUsageRecordRepository.incrementUsage(UserId.of(userId), featureType, LocalDate.now());
        log.debug("用户[{}]消费{}额度成功", userId, featureType.getValue());

        // 消费后检查是否达到80%告警线
        if (dailyLimit != -1 && todayUsage + 1 >= (int)(dailyLimit * 0.8)) {
            userEmailNotifier.notifyAiQuotaLow(userId, featureType.getDescription(), todayUsage + 1, dailyLimit, "每日");
        }
        if (monthlyLimit != -1 && monthlyUsage + 1 >= (int)(monthlyLimit * 0.8)) {
            userEmailNotifier.notifyAiQuotaLow(userId, featureType.getDescription(), monthlyUsage + 1, monthlyLimit, "每月");
        }
    }

    /**
     * 查询用户某功能今日剩余次数
     * 
     * @return -1 表示无限制
     */
    public int getRemainingDailyQuota(Long userId, AiFeatureType featureType) {
        // 管理员不受限制
        Optional<User> userOpt = userRepository.findById(UserId.of(userId));
        if (userOpt.isPresent() && userOpt.get().isAdmin()) {
            return -1;
        }

        MembershipPlan plan = getUserPlan(userId);
        int dailyLimit = plan.getDailyLimit(featureType);
        if (dailyLimit == -1) {
            return -1;
        }

        LocalDate today = LocalDate.now();
        Optional<com.novacloudedu.backend.domain.membership.entity.AiUsageRecord> record =
                aiUsageRecordRepository.findByUserIdAndFeatureTypeAndDate(UserId.of(userId), featureType, today);
        int todayUsage = record.map(com.novacloudedu.backend.domain.membership.entity.AiUsageRecord::getUsageCount).orElse(0);
        return Math.max(0, dailyLimit - todayUsage);
    }

    /**
     * 查询用户某功能本月剩余次数
     * 
     * @return -1 表示无限制
     */
    public int getRemainingMonthlyQuota(Long userId, AiFeatureType featureType) {
        Optional<User> userOpt = userRepository.findById(UserId.of(userId));
        if (userOpt.isPresent() && userOpt.get().isAdmin()) {
            return -1;
        }

        MembershipPlan plan = getUserPlan(userId);
        int monthlyLimit = plan.getMonthlyLimit(featureType);
        if (monthlyLimit == -1) {
            return -1;
        }

        LocalDate today = LocalDate.now();
        int monthlyUsage = aiUsageRecordRepository.sumMonthlyUsage(
                UserId.of(userId), featureType, today.getYear(), today.getMonthValue());
        return Math.max(0, monthlyLimit - monthlyUsage);
    }

    /**
     * 查询用户所有AI功能的剩余额度（优化版：4次DB查询替代原来32~56次）
     */
    public Map<String, Map<String, Integer>> getAllRemainingQuota(Long userId) {
        // 1. 查 User 一次 → 判断 admin
        Optional<User> userOpt = userRepository.findById(UserId.of(userId));
        if (userOpt.isPresent() && userOpt.get().isAdmin()) {
            // 管理员全部无限制
            Map<String, Map<String, Integer>> result = new HashMap<>();
            for (AiFeatureType ft : AiFeatureType.values()) {
                Map<String, Integer> quota = new HashMap<>();
                quota.put("dailyRemaining", -1);
                quota.put("monthlyRemaining", -1);
                result.put(ft.getValue(), quota);
            }
            return result;
        }

        // 2. 查 Plan 一次
        MembershipPlan plan = getUserPlan(userId);

        // 3. 批量查当日所有 feature 的使用记录（1次SQL）
        LocalDate today = LocalDate.now();
        List<com.novacloudedu.backend.domain.membership.entity.AiUsageRecord> dailyRecords =
                aiUsageRecordRepository.findByUserIdAndDate(UserId.of(userId), today);
        Map<String, Integer> dailyUsageMap = new HashMap<>();
        for (com.novacloudedu.backend.domain.membership.entity.AiUsageRecord record : dailyRecords) {
            dailyUsageMap.put(record.getFeatureType().getValue(), record.getUsageCount());
        }

        // 4. 批量查本月所有 feature 的使用汇总（1次SQL）
        Map<String, Integer> monthlyUsageMap =
                aiUsageRecordRepository.sumAllMonthlyUsage(UserId.of(userId), today.getYear(), today.getMonthValue());

        // 5. 内存中计算所有 feature 的剩余额度
        Map<String, Map<String, Integer>> result = new HashMap<>();
        for (AiFeatureType ft : AiFeatureType.values()) {
            Map<String, Integer> quota = new HashMap<>();
            int dailyLimit = plan.getDailyLimit(ft);
            int monthlyLimit = plan.getMonthlyLimit(ft);

            if (dailyLimit == -1) {
                quota.put("dailyRemaining", -1);
            } else {
                int dailyUsage = dailyUsageMap.getOrDefault(ft.getValue(), 0);
                quota.put("dailyRemaining", Math.max(0, dailyLimit - dailyUsage));
            }

            if (monthlyLimit == -1) {
                quota.put("monthlyRemaining", -1);
            } else {
                int monthlyUsage = monthlyUsageMap.getOrDefault(ft.getValue(), 0);
                quota.put("monthlyRemaining", Math.max(0, monthlyLimit - monthlyUsage));
            }

            result.put(ft.getValue(), quota);
        }
        return result;
    }

    /**
     * 获取用户当前生效的会员计划，无会员则返回默认FREE计划
     */
    private MembershipPlan getUserPlan(Long userId) {
        // 先查用户是否有生效中的会员
        Optional<UserMembership> activeMembership =
                userMembershipRepository.findActiveByUserId(UserId.of(userId));

        if (activeMembership.isPresent() && activeMembership.get().isActive()) {
            Optional<MembershipPlan> plan = membershipPlanRepository.findById(activeMembership.get().getPlanId());
            if (plan.isPresent()) {
                return plan.get();
            }
        }

        // 教师角色自动使用教师计划
        Optional<User> userOpt = userRepository.findById(UserId.of(userId));
        if (userOpt.isPresent() && "teacher".equals(userOpt.get().getRole().getValue())) {
            Optional<MembershipPlan> teacherPlan = membershipPlanRepository.findByCode(PlanCode.TEACHER);
            if (teacherPlan.isPresent()) {
                return teacherPlan.get();
            }
        }

        // 返回默认计划（FREE）
        return membershipPlanRepository.findDefault()
                .orElseGet(() -> membershipPlanRepository.findByCode(PlanCode.FREE)
                        .orElseThrow(() -> new BusinessException(50000, "系统未配置默认会员计划")));
    }
}
