package com.novacloudedu.backend.infrastructure.email;

import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 用户邮件通知器
 * 向用户发送业务关键节点的邮件通知（若用户设置了邮箱）
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class UserEmailNotifier {

    private final EmailService emailService;
    private final EmailProperties emailProperties;
    private final UserRepository userRepository;

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    /** 额度告警防重复缓存：key = userId:featureType:date，避免同日重复发送 */
    private final ConcurrentHashMap<String, Boolean> quotaAlertCache = new ConcurrentHashMap<>();

    // ==================== 订单通知 ====================

    /**
     * 通知用户：课程订单已创建
     */
    public void notifyOrderCreated(Long userId, String orderNo, String courseName, String price) {
        sendToUser(userId, "课程订单已创建",
                "ORDER", "#3b82f6",
                "您的课程订单已创建成功，请及时完成支付。",
                List.of(
                        new InfoItem("订单号", orderNo),
                        new InfoItem("课程名称", courseName),
                        new InfoItem("订单金额", "¥" + price),
                        new InfoItem("创建时间", LocalDateTime.now().format(FORMATTER))
                ),
                "查看订单", "https://ubanillx.cn/membership");
    }

    /**
     * 通知用户：支付确认成功
     */
    public void notifyPaymentConfirmed(Long userId, String orderNo, String courseName, String price) {
        sendToUser(userId, "支付成功",
                "PAYMENT", "#10b981",
                "您的订单已支付成功，课程已开通，快来学习吧！",
                List.of(
                        new InfoItem("订单号", orderNo),
                        new InfoItem("课程名称", courseName),
                        new InfoItem("支付金额", "¥" + price, "#10b981"),
                        new InfoItem("支付时间", LocalDateTime.now().format(FORMATTER))
                ),
                "开始学习", "https://ubanillx.cn/");
    }

    /**
     * 通知用户：退款完成
     */
    public void notifyRefundCompleted(Long userId, String orderNo, String price) {
        sendToUser(userId, "退款成功",
                "REFUND", "#f59e0b",
                "您的退款申请已处理完成，退款金额将按原路返回。",
                List.of(
                        new InfoItem("订单号", orderNo),
                        new InfoItem("退款金额", "¥" + price, "#ef4444"),
                        new InfoItem("退款时间", LocalDateTime.now().format(FORMATTER))
                ),
                null, null);
    }

    // ==================== 会员通知 ====================

    /**
     * 通知用户：会员订单已创建（待支付）
     */
    public void notifyMembershipPurchased(Long userId, String orderNo, String planName, String price) {
        sendToUser(userId, "会员订单已创建",
                "MEMBERSHIP", "#8b5cf6",
                "您的会员订单已创建，请联系管理员确认支付后即可生效。",
                List.of(
                        new InfoItem("订单号", orderNo),
                        new InfoItem("会员计划", planName),
                        new InfoItem("金额", "¥" + price),
                        new InfoItem("创建时间", LocalDateTime.now().format(FORMATTER))
                ),
                "查看会员", "https://ubanillx.cn/membership");
    }

    /**
     * 通知用户：会员已激活
     */
    public void notifyMembershipActivated(Long userId, String planName, String expireDate) {
        sendToUser(userId, "会员已开通",
                "MEMBERSHIP", "#10b981",
                "恭喜！您的会员已成功开通，尽享全部权益。",
                List.of(
                        new InfoItem("会员计划", planName, "#10b981"),
                        new InfoItem("到期时间", expireDate != null ? expireDate : "永久有效"),
                        new InfoItem("开通时间", LocalDateTime.now().format(FORMATTER))
                ),
                "探索会员权益", "https://ubanillx.cn/membership");
    }

    /**
     * 通知用户：管理员直接开通会员
     */
    public void notifyMembershipGranted(Long userId, String planName, String expireDate) {
        sendToUser(userId, "会员已为您开通",
                "MEMBERSHIP", "#8b5cf6",
                "管理员已为您开通会员，尽享全部权益！",
                List.of(
                        new InfoItem("会员计划", planName, "#8b5cf6"),
                        new InfoItem("到期时间", expireDate != null ? expireDate : "永久有效"),
                        new InfoItem("开通时间", LocalDateTime.now().format(FORMATTER))
                ),
                "查看会员详情", "https://ubanillx.cn/membership");
    }

    /**
     * 通知用户：会员已取消
     */
    public void notifyMembershipCancelled(Long userId) {
        sendToUser(userId, "会员已取消",
                "MEMBERSHIP", "#ef4444",
                "您的会员已被取消。如有疑问请联系管理员。",
                List.of(
                        new InfoItem("取消时间", LocalDateTime.now().format(FORMATTER)),
                        new InfoItem("说明", "您仍可重新购买会员恢复权益")
                ),
                "重新开通", "https://ubanillx.cn/membership");
    }

    // ==================== AI额度告警 ====================

    /**
     * 通知用户：AI额度即将耗尽（达到80%）
     */
    public void notifyAiQuotaLow(Long userId, String featureName, int used, int limit, String period) {
        String cacheKey = userId + ":" + featureName + ":" + period + ":" + java.time.LocalDate.now();
        if (quotaAlertCache.putIfAbsent(cacheKey, true) != null) {
            log.debug("用户[{}]{}额度告警已发送过，跳过", userId, featureName);
            return;
        }

        sendToUser(userId, "AI额度即将耗尽",
                "QUOTA", "#f59e0b",
                String.format("您的%s%s额度即将用完（%d/%d），请合理使用或升级会员。", featureName, period, used, limit),
                List.of(
                        new InfoItem("功能", featureName),
                        new InfoItem("已使用", used + "/" + limit, "#f59e0b"),
                        new InfoItem("周期", period),
                        new InfoItem("提醒时间", LocalDateTime.now().format(FORMATTER))
                ),
                "升级会员", "https://ubanillx.cn/membership");
    }

    /**
     * 通知用户：AI额度已耗尽
     */
    public void notifyAiQuotaExhausted(Long userId, String featureName, int limit, String period) {
        String cacheKey = userId + ":" + featureName + ":exhausted:" + period + ":" + java.time.LocalDate.now();
        if (quotaAlertCache.putIfAbsent(cacheKey, true) != null) {
            return;
        }

        sendToUser(userId, "AI额度已耗尽",
                "QUOTA", "#ef4444",
                String.format("您的%s%s额度已全部用完（%d/%d）。升级会员可获得更多额度。", featureName, period, limit, limit),
                List.of(
                        new InfoItem("功能", featureName),
                        new InfoItem("额度上限", String.valueOf(limit), "#ef4444"),
                        new InfoItem("周期", period),
                        new InfoItem("提醒时间", LocalDateTime.now().format(FORMATTER))
                ),
                "立即升级", "https://ubanillx.cn/membership");
    }

    // ==================== 内部方法 ====================

    private void sendToUser(Long userId, String title, String sceneTag, String accentColor,
                            String description, List<InfoItem> items,
                            String buttonText, String buttonUrl) {
        if (!emailProperties.isEnabled()) return;

        Optional<User> userOpt = userRepository.findById(UserId.of(userId));
        if (userOpt.isEmpty()) {
            log.debug("用户[{}]不存在，跳过邮件通知", userId);
            return;
        }
        User user = userOpt.get();
        String email = user.getUserEmail();
        if (email == null || email.isBlank()) {
            log.debug("用户[{}]未设置邮箱，跳过邮件通知", userId);
            return;
        }

        String subject = String.format("【%s】%s", emailProperties.getPlatformName(), title);
        String htmlContent = buildHtmlTemplate(title, sceneTag, accentColor, description, items, buttonText, buttonUrl);
        emailService.sendHtmlMail(email, subject, htmlContent);
        log.info("用户邮件通知已发送: userId={}, email={}, title={}", userId, email, title);
    }

    private String buildHtmlTemplate(String title, String sceneTag, String accentColor,
                                     String description, List<InfoItem> items,
                                     String buttonText, String buttonUrl) {
        StringBuilder itemsHtml = new StringBuilder();
        for (InfoItem item : items) {
            String valueColor = item.valueColor != null ? item.valueColor : "#333333";
            itemsHtml.append(String.format("""
                <tr>
                    <td style="padding: 10px 0; border-bottom: 1px solid #eeeeee; width: 30%%;">
                        <span style="color: #666666; font-size: 14px; font-weight: bold;">%s</span>
                    </td>
                    <td style="padding: 10px 0; border-bottom: 1px solid #eeeeee; width: 70%%;">
                        <span style="color: %s; font-size: 14px;">%s</span>
                    </td>
                </tr>
                """, escapeHtml(item.label), valueColor, escapeHtml(item.value)));
        }

        String buttonHtml = "";
        if (buttonText != null && buttonUrl != null) {
            buttonHtml = String.format("""
                <tr>
                    <td colspan="2" style="padding-top: 20px; text-align: center;">
                        <a href="%s"
                           style="display: inline-block; background: %s;
                                  color: #ffffff; text-decoration: none; padding: 12px 24px;
                                  border-radius: 4px; font-size: 14px; font-weight: bold;">
                            %s
                        </a>
                    </td>
                </tr>
                """, buttonUrl, accentColor, buttonText);
        }

        return String.format("""
            <!DOCTYPE html>
            <html>
            <head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
            <body style="margin: 0; padding: 0; background-color: #f5f5f5; font-family: 'Arial', sans-serif;">
                <table width="100%%" cellpadding="0" cellspacing="0" border="0">
                    <tr><td align="center" style="padding: 30px 15px;">
                        <table width="600" cellpadding="0" cellspacing="0" border="0"
                               style="max-width: 600px; width: 100%%; background: #ffffff; border: 1px solid #dddddd; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
                            <tr><td style="padding: 20px; text-align: center; border-bottom: 2px solid %s;">
                                <span style="font-size: 22px; font-weight: bold; color: #333333;">%s</span>
                                <span style="display: block; font-size: 12px; color: #666666; margin-top: 5px;">智能教育管理平台</span>
                            </td></tr>
                            <tr><td style="padding: 30px;">
                                <table width="100%%" cellpadding="0" cellspacing="0" border="0">
                                    <tr><td style="text-align: left; padding-bottom: 20px;">
                                        <h1 style="margin: 0; font-size: 20px; font-weight: bold; color: #333333; border-left: 4px solid %s; padding-left: 10px;">%s</h1>
                                        <p style="margin: 10px 0 0; font-size: 14px; color: #555555; line-height: 1.5;">%s</p>
                                    </td></tr>
                                    <tr><td>
                                        <table width="100%%" cellpadding="0" cellspacing="0" border="0"
                                               style="background: #f9f9f9; border: 1px solid #eeeeee; padding: 15px;">
                                            %s
                                        </table>
                                    </td></tr>
                                    %s
                                </table>
                            </td></tr>
                            <tr><td style="padding: 20px; background: #f5f5f5; text-align: center; border-top: 1px solid #dddddd;">
                                <p style="margin: 0; font-size: 12px; color: #888888;">此邮件由系统自动发送，请勿直接回复</p>
                                <p style="margin: 5px 0 0; font-size: 11px; color: #aaaaaa;">2026 %s</p>
                            </td></tr>
                        </table>
                    </td></tr>
                </table>
            </body></html>
            """,
                accentColor, emailProperties.getPlatformName(),
                accentColor, title, description,
                itemsHtml.toString(), buttonHtml,
                emailProperties.getPlatformName());
    }

    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                   .replace("\"", "&quot;").replace("'", "&#x27;");
    }

    private record InfoItem(String label, String value, String valueColor) {
        InfoItem(String label, String value) {
            this(label, value, null);
        }
    }
}
