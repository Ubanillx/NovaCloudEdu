package com.novacloudedu.backend.application.membership.service;

import com.novacloudedu.backend.domain.membership.entity.MembershipPlan;
import com.novacloudedu.backend.domain.membership.entity.UserMembership;
import com.novacloudedu.backend.domain.membership.repository.MembershipPlanRepository;
import com.novacloudedu.backend.domain.membership.repository.UserMembershipRepository;
import com.novacloudedu.backend.domain.membership.service.AiUsageLimitService;
import com.novacloudedu.backend.domain.membership.valueobject.MembershipStatus;
import com.novacloudedu.backend.domain.membership.valueobject.PlanCode;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.email.AdminEmailNotifier;
import com.novacloudedu.backend.infrastructure.email.UserEmailNotifier;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

@Slf4j
@Service
@RequiredArgsConstructor
public class MembershipApplicationService {

    private final MembershipPlanRepository planRepository;
    private final UserMembershipRepository membershipRepository;
    private final AiUsageLimitService aiUsageLimitService;
    private final UserRepository userRepository;
    private final AdminEmailNotifier adminEmailNotifier;
    private final UserEmailNotifier userEmailNotifier;

    // ==================== 计划管理（管理员） ====================

    public List<MembershipPlan> listPlans() {
        return planRepository.findAll();
    }

    public MembershipPlan getPlan(Long planId) {
        return planRepository.findById(planId)
                .orElseThrow(() -> new BusinessException(40400, "会员计划不存在"));
    }

    @Transactional
    public MembershipPlan createPlan(String name, PlanCode code, String description,
                                     BigDecimal price, Integer durationDays) {
        if (planRepository.findByCode(code).isPresent()) {
            throw new BusinessException(40900, "计划编码已存在: " + code.getValue());
        }
        MembershipPlan plan = MembershipPlan.create(name, code, description, price, durationDays);
        return planRepository.save(plan);
    }

    @Transactional
    public void updatePlan(Long planId, String name, String description,
                           BigDecimal price, Integer durationDays) {
        MembershipPlan plan = getPlan(planId);
        plan.updateBasicInfo(name, description, price, durationDays);
        planRepository.save(plan);
    }

    @Transactional
    public void updatePlanQuota(Long planId,
                                Integer aiChatDailyLimit, Integer aiChatMonthlyLimit,
                                Integer aiPptDailyLimit, Integer aiPptMonthlyLimit,
                                Integer aiExamDailyLimit, Integer aiExamMonthlyLimit,
                                Integer aiBookDailyLimit, Integer aiBookMonthlyLimit) {
        MembershipPlan plan = getPlan(planId);
        plan.updateQuota(aiChatDailyLimit, aiChatMonthlyLimit,
                aiPptDailyLimit, aiPptMonthlyLimit,
                aiExamDailyLimit, aiExamMonthlyLimit,
                aiBookDailyLimit, aiBookMonthlyLimit);
        planRepository.save(plan);
    }

    @Transactional
    public void deletePlan(Long planId) {
        MembershipPlan plan = getPlan(planId);
        if (plan.isDefault()) {
            throw new BusinessException(40000, "不能删除默认计划");
        }
        plan.delete();
        planRepository.save(plan);
    }

    // ==================== 用户会员管理 ====================

    /**
     * 用户购买会员（创建待支付订单）
     */
    @Transactional
    public String purchaseMembership(Long userId, Long planId) {
        MembershipPlan plan = getPlan(planId);
        if (plan.isDefault() && plan.getPrice().compareTo(BigDecimal.ZERO) == 0) {
            throw new BusinessException(40000, "免费计划无需购买");
        }

        // 检查是否已有生效会员
        Optional<UserMembership> active = membershipRepository.findActiveByUserId(UserId.of(userId));
        if (active.isPresent() && active.get().isActive()) {
            throw new BusinessException(40900, "您已有生效中的会员，请到期后再购买");
        }

        String orderNo = generateOrderNo();
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime expireTime = plan.getDurationDays() > 0
                ? now.plusDays(plan.getDurationDays())
                : null;

        UserMembership membership = UserMembership.create(
                UserId.of(userId), plan.getId(), orderNo, now, expireTime);
        membershipRepository.save(membership);

        log.info("用户[{}]创建会员订单: planId={}, orderNo={}", userId, planId, orderNo);

        // 邮件通知
        String userName = userRepository.findById(UserId.of(userId))
                .map(User::getUserName).orElse("未知用户");
        String planName = plan.getName();
        adminEmailNotifier.notifyMembershipPurchased(orderNo, planName, plan.getPrice().toPlainString(), userName);
        userEmailNotifier.notifyMembershipPurchased(userId, orderNo, planName, plan.getPrice().toPlainString());

        return orderNo;
    }

    /**
     * 管理员确认会员支付
     */
    @Transactional
    public void confirmMembershipPayment(String orderNo) {
        UserMembership membership = membershipRepository.findByOrderNo(orderNo)
                .orElseThrow(() -> new BusinessException(40400, "会员订单不存在"));

        MembershipPlan plan = planRepository.findById(membership.getPlanId())
                .orElseThrow(() -> new BusinessException(40400, "关联计划不存在"));

        membership.activateWithExpiry(plan.getDurationDays());
        membershipRepository.save(membership);

        log.info("会员订单确认支付: orderNo={}, userId={}, planId={}",
                orderNo, membership.getUserId().value(), membership.getPlanId());

        // 邮件通知
        String userName = userRepository.findById(membership.getUserId())
                .map(User::getUserName).orElse("未知用户");
        String expireDate = membership.getExpireTime() != null
                ? membership.getExpireTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : null;
        adminEmailNotifier.notifyMembershipActivated(orderNo, plan.getName(), userName);
        userEmailNotifier.notifyMembershipActivated(membership.getUserId().value(), plan.getName(), expireDate);
    }

    /**
     * 管理员直接为用户开通会员
     */
    @Transactional
    public void grantMembership(Long userId, Long planId) {
        MembershipPlan plan = getPlan(planId);

        // 如果已有生效会员，先取消
        Optional<UserMembership> active = membershipRepository.findActiveByUserId(UserId.of(userId));
        active.ifPresent(UserMembership::cancel);
        active.ifPresent(membershipRepository::save);

        String orderNo = generateOrderNo();
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime expireTime = plan.getDurationDays() > 0
                ? now.plusDays(plan.getDurationDays())
                : null;

        UserMembership membership = UserMembership.createActive(
                UserId.of(userId), plan.getId(), orderNo, now, expireTime);
        membershipRepository.save(membership);

        log.info("管理员为用户[{}]开通会员: planId={}", userId, planId);

        // 邮件通知用户
        String expireDate = expireTime != null
                ? expireTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : null;
        userEmailNotifier.notifyMembershipGranted(userId, plan.getName(), expireDate);
    }

    /**
     * 取消会员
     */
    @Transactional
    public void cancelMembership(Long userId) {
        UserMembership membership = membershipRepository.findActiveByUserId(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(40400, "未找到生效中的会员"));
        membership.cancel();
        membershipRepository.save(membership);
        log.info("用户[{}]会员已取消", userId);

        // 邮件通知用户
        userEmailNotifier.notifyMembershipCancelled(userId);
    }

    /**
     * 查询用户当前会员状态（包含 PENDING 和 ACTIVE，优先返回 ACTIVE）
     */
    public Optional<UserMembership> getCurrentMembership(Long userId) {
        Optional<UserMembership> active = membershipRepository.findActiveByUserId(UserId.of(userId));
        if (active.isPresent()) {
            return active;
        }
        return membershipRepository.findLatestByUserId(UserId.of(userId));
    }

    /**
     * 查询用户会员历史
     */
    public List<UserMembership> getMembershipHistory(Long userId) {
        return membershipRepository.findByUserId(UserId.of(userId));
    }

    /**
     * 查询用户AI功能剩余额度
     */
    public Map<String, Map<String, Integer>> getAiQuota(Long userId) {
        return aiUsageLimitService.getAllRemainingQuota(userId);
    }

    /**
     * 检查用户是否有会员课访问权限
     */
    public boolean hasCourseMemberAccess(Long userId) {
        Optional<UserMembership> active = membershipRepository.findActiveByUserId(UserId.of(userId));
        if (active.isEmpty() || !active.get().isActive()) {
            return false;
        }
        Optional<MembershipPlan> plan = planRepository.findById(active.get().getPlanId());
        return plan.isPresent() && plan.get().isCourseMemberAccess();
    }

    // ==================== 管理员查询 ====================

    public List<UserMembership> listMembershipsByStatus(MembershipStatus status, int page, int size) {
        return membershipRepository.findByStatus(status, page, size);
    }

    public long countByStatus(MembershipStatus status) {
        return membershipRepository.countByStatus(status);
    }

    // ==================== 工具方法 ====================

    private String generateOrderNo() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String timestamp = LocalDateTime.now().format(formatter);
        int random = new Random().nextInt(10000);
        return "MEM" + timestamp + String.format("%04d", random);
    }
}
