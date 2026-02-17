package com.novacloudedu.backend.infrastructure.email;

import com.novacloudedu.backend.domain.feedback.entity.UserFeedback;
import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherStatus;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * 管理员邮件通知器
 * 封装各业务场景的邮件模板和发送逻辑
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class AdminEmailNotifier {

    private final EmailService emailService;
    private final EmailProperties emailProperties;

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // ==================== 用户反馈通知 ====================

    /**
     * 通知管理员：新用户反馈
     */
    public void notifyNewFeedback(UserFeedback feedback) {
        if (!canSend()) return;

        String subject = buildSubject("新用户反馈待处理");
        String htmlContent = buildHtmlTemplate(
            "新用户反馈",
            "FEEDBACK",
            "#3b82f6",
            "有新的用户反馈需要处理，请及时登录管理后台查看。",
            List.of(
                new InfoItem("反馈类型", feedback.getFeedbackType()),
                new InfoItem("标题", feedback.getTitle()),
                new InfoItem("内容", truncate(feedback.getContent(), 200)),
                new InfoItem("提交时间", LocalDateTime.now().format(FORMATTER))
            ),
            "进入管理后台",
            "https://ubanillx.cn/admin/feedbacks"
        );

        sendHtmlToAllAdmins(subject, htmlContent);
        log.info("已发送新反馈通知邮件, feedbackTitle={}", feedback.getTitle());
    }

    // ==================== 讲师申请通知 ====================

    /**
     * 通知管理员：新讲师申请
     */
    public void notifyTeacherApplied(TeacherApplication application) {
        if (!canSend()) return;

        String subject = buildSubject("新讲师申请待审核");
        String expertise = application.getExpertise() != null
                ? String.join("、", application.getExpertise())
                : "未填写";

        String htmlContent = buildHtmlTemplate(
            "新讲师申请",
            "TEACHER",
            "#8b5cf6",
            "有新的讲师申请需要审核，请及时登录管理后台处理。",
            List.of(
                new InfoItem("申请人姓名", application.getName()),
                new InfoItem("个人介绍", truncate(application.getIntroduction(), 200)),
                new InfoItem("擅长领域", expertise),
                new InfoItem("提交时间", LocalDateTime.now().format(FORMATTER))
            ),
            "审核申请",
            "https://ubanillx.cn/admin/teachers"
        );

        sendHtmlToAllAdmins(subject, htmlContent);
        log.info("已发送讲师申请通知邮件, applicantName={}", application.getName());
    }

    /**
     * 通知管理员：讲师审核结果（记录通知）
     */
    public void notifyTeacherReviewResult(TeacherApplication application) {
        if (!canSend()) return;

        boolean isApproved = application.getStatus() == TeacherStatus.APPROVED;
        String statusDesc = isApproved ? "已通过" : "已拒绝";
        String statusColor = isApproved ? "#10b981" : "#ef4444";
        String sceneTag = isApproved ? "APPROVED" : "REJECTED";

        List<InfoItem> infoItems = new ArrayList<>(List.of(
            new InfoItem("申请人姓名", application.getName()),
            new InfoItem("审核结果", statusDesc, statusColor),
            new InfoItem("审核时间", application.getReviewTime() != null
                    ? application.getReviewTime().format(FORMATTER)
                    : LocalDateTime.now().format(FORMATTER))
        ));

        if (!isApproved && application.getRejectReason() != null) {
            infoItems.add(2, new InfoItem("拒绝原因", application.getRejectReason(), "#ef4444"));
        }

        String subject = buildSubject("讲师申请审核" + statusDesc);
        String htmlContent = buildHtmlTemplate(
            "讲师审核结果",
            sceneTag,
            statusColor,
            "讲师申请审核已完成，以下为审核结果详情。",
            infoItems,
            null,
            null
        );

        sendHtmlToAllAdmins(subject, htmlContent);
        log.info("已发送讲师审核结果通知邮件, applicantName={}, status={}", application.getName(), statusDesc);
    }

    // ==================== 课程订单通知 ====================

    /**
     * 通知管理员：新课程订单（待支付）
     */
    public void notifyNewCourseOrder(String orderNo, String courseName, String amount, String userName) {
        if (!canSend()) return;

        String subject = buildSubject("新课程订单待确认");
        String htmlContent = buildHtmlTemplate(
            "新课程订单",
            "ORDER",
            "#3b82f6",
            "有新的课程订单创建，如为付费课程请等待用户支付后确认收款。",
            List.of(
                new InfoItem("订单号", orderNo),
                new InfoItem("课程名称", courseName),
                new InfoItem("订单金额", "¥" + amount),
                new InfoItem("购买用户", userName),
                new InfoItem("创建时间", LocalDateTime.now().format(FORMATTER))
            ),
            "查看订单",
            "https://ubanillx.cn/admin/orders"
        );

        sendHtmlToAllAdmins(subject, htmlContent);
        log.info("已发送新课程订单通知邮件, orderNo={}", orderNo);
    }

    // ==================== 会员通知 ====================

    /**
     * 通知管理员：新会员购买订单
     */
    public void notifyMembershipPurchased(String orderNo, String planName, String amount, String userName) {
        if (!canSend()) return;

        String subject = buildSubject("新会员订单待确认");
        String htmlContent = buildHtmlTemplate(
            "新会员订单",
            "MEMBERSHIP",
            "#8b5cf6",
            "有新的会员购买订单，请及时确认收款。",
            List.of(
                new InfoItem("订单号", orderNo),
                new InfoItem("会员计划", planName),
                new InfoItem("金额", "¥" + amount),
                new InfoItem("购买用户", userName),
                new InfoItem("创建时间", LocalDateTime.now().format(FORMATTER))
            ),
            "确认收款",
            "https://ubanillx.cn/admin/membership"
        );

        sendHtmlToAllAdmins(subject, htmlContent);
        log.info("已发送会员购买通知邮件, orderNo={}", orderNo);
    }

    /**
     * 通知管理员：会员已激活
     */
    public void notifyMembershipActivated(String orderNo, String planName, String userName) {
        if (!canSend()) return;

        String subject = buildSubject("会员开通成功");
        String htmlContent = buildHtmlTemplate(
            "会员开通成功",
            "MEMBERSHIP",
            "#10b981",
            "用户会员已成功开通。",
            List.of(
                new InfoItem("订单号", orderNo),
                new InfoItem("会员计划", planName),
                new InfoItem("用户", userName),
                new InfoItem("开通时间", LocalDateTime.now().format(FORMATTER))
            ),
            "查看会员列表",
            "https://ubanillx.cn/admin/membership"
        );

        sendHtmlToAllAdmins(subject, htmlContent);
        log.info("已发送会员激活通知邮件, orderNo={}", orderNo);
    }

    // ==================== 订单支付通知 ====================

    /**
     * 通知管理员：订单支付成功
     */
    public void notifyPaymentSuccess(String orderNo, String courseName, String amount) {
        if (!canSend()) return;

        String subject = buildSubject("新订单支付成功");
        String htmlContent = buildHtmlTemplate(
            "新订单支付成功",
            "PAYMENT",
            "#10b981",
            "恭喜！有新的订单支付成功。",
            List.of(
                new InfoItem("订单号", orderNo),
                new InfoItem("课程名称", courseName),
                new InfoItem("支付金额", "¥" + amount, "#10b981"),
                new InfoItem("支付时间", LocalDateTime.now().format(FORMATTER))
            ),
            "查看订单详情",
            "https://ubanillx.cn/admin/orders"
        );

        sendHtmlToAllAdmins(subject, htmlContent);
        log.info("已发送支付成功通知邮件, orderNo={}", orderNo);
    }

    /**
     * 通知管理员：退款申请
     */
    public void notifyRefundRequest(String orderNo, String courseName, String amount) {
        if (!canSend()) return;

        String subject = buildSubject("退款申请待处理");
        String htmlContent = buildHtmlTemplate(
            "退款申请",
            "REFUND",
            "#f59e0b",
            "有新的退款申请需要处理，请及时登录管理后台查看。",
            List.of(
                new InfoItem("订单号", orderNo),
                new InfoItem("课程名称", courseName),
                new InfoItem("退款金额", "¥" + amount, "#ef4444"),
                new InfoItem("申请时间", LocalDateTime.now().format(FORMATTER))
            ),
            "处理退款",
            "https://ubanillx.cn/admin/refunds"
        );

        sendHtmlToAllAdmins(subject, htmlContent);
        log.info("已发送退款申请通知邮件, orderNo={}", orderNo);
    }

    // ==================== 用户注册通知 ====================

    /**
     * 通知管理员：新用户注册
     */
    public void notifyNewUserRegistered(String username, String phone) {
        if (!canSend()) return;

        String subject = buildSubject("新用户注册");
        String htmlContent = buildHtmlTemplate(
            "新用户注册",
            "USER",
            "#06b6d4",
            "平台有新用户注册加入。",
            List.of(
                new InfoItem("用户名", username),
                new InfoItem("手机号", maskPhone(phone)),
                new InfoItem("注册时间", LocalDateTime.now().format(FORMATTER))
            ),
            "查看用户列表",
            "https://ubanillx.cn/admin/users"
        );

        sendHtmlToAllAdmins(subject, htmlContent);
        log.info("已发送新用户注册通知邮件, username={}", username);
    }

    // ==================== 系统异常通知 ====================

    /**
     * 通知管理员：系统严重异常
     */
    public void notifySystemError(String errorMessage, String stackTrace) {
        if (!canSend()) return;

        String subject = buildSubject("系统异常报警");
        String htmlContent = buildHtmlTemplate(
            "系统异常报警",
            "ALERT",
            "#ef4444",
            "系统检测到严重异常，请及时排查处理。",
            List.of(
                new InfoItem("错误信息", errorMessage, "#ef4444"),
                new InfoItem("发生时间", LocalDateTime.now().format(FORMATTER)),
                new InfoItem("堆栈信息", truncate(stackTrace, 500))
            ),
            "查看日志",
            "https://ubanillx.cn/admin/logs"
        );

        sendHtmlToAllAdmins(subject, htmlContent);
        log.info("已发送系统异常报警邮件, error={}", truncate(errorMessage, 100));
    }

    // ==================== HTML 模板构建 ====================

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
                """, escapeHtml(item.label), valueColor, formatTextForHtml(item.value)));
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
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>%s - %s</title>
            </head>
            <body style="margin: 0; padding: 0; background-color: #f5f5f5; font-family: 'Arial', 'Helvetica Neue', sans-serif;">
                <table width="100%%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" style="padding: 30px 15px;">
                            <table width="600" cellpadding="0" cellspacing="0" border="0" 
                                   style="max-width: 600px; width: 100%%; background: #ffffff; 
                                          border: 1px solid #dddddd; border-radius: 0; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
                                <!-- 头部区域 -->
                                <tr>
                                    <td style="padding: 20px; text-align: center; border-bottom: 2px solid %s;">
                                        <span style="font-size: 22px; font-weight: bold; color: #333333;">
                                            %s
                                        </span>
                                        <span style="display: block; font-size: 12px; color: #666666; margin-top: 5px;">
                                            智能教育管理平台
                                        </span>
                                    </td>
                                </tr>
                                
                                <!-- 主内容区 -->
                                <tr>
                                    <td style="padding: 30px;">
                                        <table width="100%%" cellpadding="0" cellspacing="0" border="0">
                                            <!-- 标题区 -->
                                            <tr>
                                                <td style="text-align: left; padding-bottom: 20px;">
                                                    <h1 style="margin: 0; font-size: 20px; font-weight: bold; color: #333333; border-left: 4px solid %s; padding-left: 10px;">
                                                        %s
                                                    </h1>
                                                    <p style="margin: 10px 0 0; font-size: 14px; color: #555555; line-height: 1.5;">
                                                        %s
                                                    </p>
                                                </td>
                                            </tr>
                                            
                                            <!-- 信息表格 -->
                                            <tr>
                                                <td>
                                                    <table width="100%%" cellpadding="0" cellspacing="0" border="0" 
                                                           style="background: #f9f9f9; border: 1px solid #eeeeee; border-radius: 0; padding: 15px;">
                                                        %s
                                                    </table>
                                                </td>
                                            </tr>
                                            
                                            %s
                                        </table>
                                    </td>
                                </tr>
                                
                                <!-- 底部 -->
                                <tr>
                                    <td style="padding: 20px; background: #f5f5f5; border-radius: 0; text-align: center; border-top: 1px solid #dddddd;">
                                        <p style="margin: 0; font-size: 12px; color: #888888;">
                                            此邮件由系统自动发送，请勿直接回复
                                        </p>
                                        <p style="margin: 5px 0 0; font-size: 11px; color: #aaaaaa;">
                                            2026 %s 
                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </body>
            </html>
            """,
            emailProperties.getPlatformName(), title,
            accentColor,
            emailProperties.getPlatformName(),
            accentColor, title, description,
            itemsHtml.toString(),
            buttonHtml,
            emailProperties.getPlatformName()
        );
    }

    // ==================== 内部方法 ====================

    private boolean canSend() {
        if (!emailProperties.isEnabled()) {
            log.debug("管理员邮件通知已禁用");
            return false;
        }
        List<String> recipients = emailProperties.getRecipientList();
        if (recipients.isEmpty()) {
            log.warn("管理员邮件收件人列表为空，跳过发送");
            return false;
        }
        return true;
    }

    private String buildSubject(String title) {
        return String.format("【%s】%s", emailProperties.getPlatformName(), title);
    }

    private void sendHtmlToAllAdmins(String subject, String htmlContent) {
        List<String> recipients = emailProperties.getRecipientList();
        String[] toArray = recipients.toArray(new String[0]);
        emailService.sendHtmlMailToMultiple(toArray, subject, htmlContent);
    }

    private String truncate(String text, int maxLength) {
        if (text == null) return "";
        return text.length() > maxLength ? text.substring(0, maxLength) + "..." : text;
    }

    private String maskPhone(String phone) {
        if (phone == null || phone.length() < 7) return phone;
        return phone.substring(0, 3) + "****" + phone.substring(phone.length() - 4);
    }

    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#x27;");
    }

    private String formatTextForHtml(String text) {
        return escapeHtml(text).replace("\n", "<br/>");
    }

    // ==================== 内部类 ====================

    private record InfoItem(String label, String value, String valueColor) {
        InfoItem(String label, String value) {
            this(label, value, null);
        }
    }
}
