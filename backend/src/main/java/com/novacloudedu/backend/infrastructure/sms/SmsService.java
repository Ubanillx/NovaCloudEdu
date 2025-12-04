package com.novacloudedu.backend.infrastructure.sms;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * 短信服务
 */
@Component
@Slf4j
public class SmsService {

    @Value("${sms.url:https://push.spug.cc/sms/0tGVJKjeT36KYlKw-oq9TQ}")
    private String smsUrl;

    @Value("${sms.query-url:https://push.spug.cc/request/query}")
    private String queryUrl;

    @Value("${sms.token:}")
    private String token;

    @Value("${sms.app-name:智云星课平台}")
    private String appName;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${sms.expire-minutes:5}")
    private int expireMinutes;

    /**
     * 发送短信验证码
     *
     * @param phone 手机号
     * @param code  验证码
     * @return 发送结果，包含 request_id
     */
    public SendResult sendSmsCode(String phone, String code) {
        return sendSmsCode(phone, code, expireMinutes);
    }

    /**
     * 发送短信验证码
     *
     * @param phone   手机号
     * @param code    验证码
     * @param minutes 验证码有效期（分钟）
     * @return 发送结果，包含 request_id
     */
    public SendResult sendSmsCode(String phone, String code, int minutes) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("name", appName);
            params.put("code", code);
            params.put("to", phone);
            params.put("number", minutes);

            String json = objectMapper.writeValueAsString(params);
            String responseBody = doPost(smsUrl, json);

            SendResponse response = objectMapper.readValue(responseBody, SendResponse.class);
            if (response.getCode() == 200) {
                log.info("短信发送成功, phone={}, requestId={}", phone, response.getRequestId());
                return SendResult.success(response.getRequestId());
            } else {
                log.error("短信发送失败, phone={}, msg={}", phone, response.getMsg());
                return SendResult.fail(response.getMsg());
            }
        } catch (Exception e) {
            log.error("短信发送异常, phone={}", phone, e);
            return SendResult.fail(e.getMessage());
        }
    }

    /**
     * 查询短信发送状态
     *
     * @param requestId 发送短信返回的 request_id
     * @return 查询结果
     */
    public QueryResult querySmsStatus(String requestId) {
        try {
            Map<String, String> params = new HashMap<>();
            params.put("token", token);
            params.put("request_id", requestId);

            String json = objectMapper.writeValueAsString(params);
            String responseBody = doPost(queryUrl, json);

            QueryResponse response = objectMapper.readValue(responseBody, QueryResponse.class);
            if (response.getCode() == 200) {
                log.info("短信状态查询成功, requestId={}, data={}", requestId, response.getData());
                return QueryResult.success(response.getData());
            } else {
                log.error("短信状态查询失败, requestId={}, msg={}", requestId, response.getMsg());
                return QueryResult.fail(response.getMsg());
            }
        } catch (Exception e) {
            log.error("短信状态查询异常, requestId={}", requestId, e);
            return QueryResult.fail(e.getMessage());
        }
    }

    /**
     * 发送 POST 请求
     */
    private String doPost(String url, String json) throws Exception {
        HttpURLConnection conn = (HttpURLConnection) URI.create(url).toURL().openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setConnectTimeout(5000);
        conn.setReadTimeout(5000);
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(json.getBytes(StandardCharsets.UTF_8));
        }

        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
        }
        return response.toString();
    }

    /**
     * 生成随机验证码
     */
    public String generateCode(int length) {
        Random random = new Random();
        StringBuilder code = new StringBuilder();
        for (int i = 0; i < length; i++) {
            code.append(random.nextInt(10));
        }
        return code.toString();
    }

    /**
     * 生成6位随机验证码
     */
    public String generateCode() {
        return generateCode(6);
    }

    // ==================== 响应类 ====================

    @Data
    public static class SendResponse {
        private int code;
        private String msg;
        @JsonProperty("request_id")
        private String requestId;
    }

    @Data
    public static class QueryResponse {
        private int code;
        private String msg;
        private List<SmsStatus> data;
    }

    @Data
    public static class SmsStatus {
        private String target;
        private String type;
        private int fee;
        private String status;
        private String reason;

        /**
         * 是否发送成功
         */
        public boolean isSuccess() {
            return "2".equals(status) && "success".equalsIgnoreCase(reason);
        }
    }

    // ==================== 结果类 ====================

    @Data
    public static class SendResult {
        private boolean success;
        private String requestId;
        private String errorMsg;

        public static SendResult success(String requestId) {
            SendResult result = new SendResult();
            result.success = true;
            result.requestId = requestId;
            return result;
        }

        public static SendResult fail(String errorMsg) {
            SendResult result = new SendResult();
            result.success = false;
            result.errorMsg = errorMsg;
            return result;
        }
    }

    @Data
    public static class QueryResult {
        private boolean success;
        private List<SmsStatus> data;
        private String errorMsg;

        public static QueryResult success(List<SmsStatus> data) {
            QueryResult result = new QueryResult();
            result.success = true;
            result.data = data;
            return result;
        }

        public static QueryResult fail(String errorMsg) {
            QueryResult result = new QueryResult();
            result.success = false;
            result.errorMsg = errorMsg;
            return result;
        }
    }
}
