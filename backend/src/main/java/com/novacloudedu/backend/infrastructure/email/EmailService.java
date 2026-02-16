package com.novacloudedu.backend.infrastructure.email;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

/**
 * 邮件发送基础服务
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username:}")
    private String fromAddress;

    /**
     * 异步发送纯文本邮件
     *
     * @param to      收件人
     * @param subject 主题
     * @param content 内容
     */
    @Async
    public void sendSimpleMail(String to, String subject, String content) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromAddress);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(content);
            mailSender.send(message);
            log.info("纯文本邮件发送成功: to={}, subject={}", to, subject);
        } catch (Exception e) {
            log.error("纯文本邮件发送失败: to={}, subject={}", to, subject, e);
        }
    }

    /**
     * 异步发送 HTML 邮件
     *
     * @param to          收件人
     * @param subject     主题
     * @param htmlContent HTML 内容
     */
    @Async
    public void sendHtmlMail(String to, String subject, String htmlContent) {
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            helper.setFrom(fromAddress);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htmlContent, true);
            mailSender.send(mimeMessage);
            log.info("HTML邮件发送成功: to={}, subject={}", to, subject);
        } catch (MessagingException e) {
            log.error("HTML邮件发送失败: to={}, subject={}", to, subject, e);
        }
    }

    /**
     * 异步发送纯文本邮件给多个收件人
     *
     * @param toList  收件人列表
     * @param subject 主题
     * @param content 内容
     */
    @Async
    public void sendSimpleMailToMultiple(String[] toList, String subject, String content) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromAddress);
            message.setTo(toList);
            message.setSubject(subject);
            message.setText(content);
            mailSender.send(message);
            log.info("批量纯文本邮件发送成功: to={}, subject={}", String.join(",", toList), subject);
        } catch (Exception e) {
            log.error("批量纯文本邮件发送失败: to={}, subject={}", String.join(",", toList), subject, e);
        }
    }

    /**
     * 异步发送 HTML 邮件给多个收件人
     *
     * @param toList      收件人列表
     * @param subject     主题
     * @param htmlContent HTML 内容
     */
    @Async
    public void sendHtmlMailToMultiple(String[] toList, String subject, String htmlContent) {
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            helper.setFrom(fromAddress);
            helper.setTo(toList);
            helper.setSubject(subject);
            helper.setText(htmlContent, true);
            mailSender.send(mimeMessage);
            log.info("批量HTML邮件发送成功: to={}, subject={}", String.join(",", toList), subject);
        } catch (MessagingException e) {
            log.error("批量HTML邮件发送失败: to={}, subject={}", String.join(",", toList), subject, e);
        }
    }
}
