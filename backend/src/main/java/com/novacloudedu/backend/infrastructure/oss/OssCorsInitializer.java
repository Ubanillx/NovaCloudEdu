package com.novacloudedu.backend.infrastructure.oss;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.SetBucketCORSRequest;
import com.aliyun.oss.model.SetBucketCORSRequest.CORSRule;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * 应用启动时自动为 OSS Bucket 配置 CORS 规则，
 * 确保浏览器可以直接请求 OSS 预签名 URL（如 HLS m3u8/ts 文件）。
 */
@Slf4j
@Component
public class OssCorsInitializer implements ApplicationRunner {

    @Value("${aliyun.oss.endpoint:oss-cn-hangzhou.aliyuncs.com}")
    private String endpoint;

    @Value("${aliyun.oss.access-key-id:}")
    private String accessKeyId;

    @Value("${aliyun.oss.access-key-secret:}")
    private String accessKeySecret;

    @Value("${aliyun.oss.bucket-name:novacloudedu}")
    private String bucketName;

    @Override
    public void run(ApplicationArguments args) {
        if (accessKeyId.isBlank() || accessKeySecret.isBlank()) {
            log.warn("OSS 凭证未配置，跳过 CORS 规则初始化");
            return;
        }

        OSS ossClient = null;
        try {
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            SetBucketCORSRequest request = new SetBucketCORSRequest(bucketName);

            CORSRule rule = new CORSRule();
            List<String> allowedOrigins = new ArrayList<>();
            allowedOrigins.add("*");
            rule.setAllowedOrigins(allowedOrigins);

            List<String> allowedMethods = new ArrayList<>();
            allowedMethods.add("GET");
            allowedMethods.add("HEAD");
            rule.setAllowedMethods(allowedMethods);

            List<String> allowedHeaders = new ArrayList<>();
            allowedHeaders.add("*");
            rule.setAllowedHeaders(allowedHeaders);

            List<String> exposedHeaders = new ArrayList<>();
            exposedHeaders.add("ETag");
            exposedHeaders.add("Content-Length");
            exposedHeaders.add("Content-Type");
            rule.setExposeHeaders(exposedHeaders);

            rule.setMaxAgeSeconds(3600);

            request.addCorsRule(rule);
            ossClient.setBucketCORS(request);

            log.info("OSS Bucket [{}] CORS 规则配置成功", bucketName);
        } catch (Exception e) {
            log.warn("OSS Bucket CORS 规则配置失败（不影响核心功能）: {}", e.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }
}
