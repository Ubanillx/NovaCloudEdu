package com.novacloudedu.backend.infrastructure.oss;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.PutObjectRequest;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.net.URL;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.UUID;

@Slf4j
@Service
public class AliyunOssService implements OssService {

    @Value("${aliyun.oss.endpoint:oss-cn-hangzhou.aliyuncs.com}")
    private String endpoint;

    @Value("${aliyun.oss.access-key-id:}")
    private String accessKeyId;

    @Value("${aliyun.oss.access-key-secret:}")
    private String accessKeySecret;

    @Value("${aliyun.oss.bucket-name:novacloudedu}")
    private String bucketName;

    @Value("${aliyun.oss.domain:}")
    private String customDomain;

    @Override
    public String uploadFile(MultipartFile file, FileBusinessType businessType) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException(40000, "文件不能为空");
        }

        OSS ossClient = null;
        try {
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename != null && originalFilename.contains(".") 
                    ? originalFilename.substring(originalFilename.lastIndexOf(".")) 
                    : "";

            String dateFolder = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
            String fileName = UUID.randomUUID().toString().replace("-", "") + extension;
            String objectName = businessType.getFolder() + "/" + dateFolder + "/" + fileName;

            InputStream inputStream = file.getInputStream();
            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, inputStream);
            ossClient.putObject(putObjectRequest);

            String fileUrl = customDomain.isEmpty() 
                    ? "https://" + bucketName + "." + endpoint + "/" + objectName
                    : customDomain + "/" + objectName;

            log.info("文件上传成功: {}", fileUrl);
            return fileUrl;

        } catch (Exception e) {
            log.error("文件上传失败", e);
            throw new BusinessException(50000, "文件上传失败: " + e.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    @Override
    public void deleteFile(String fileUrl) {
        OSS ossClient = null;
        try {
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            String objectName = extractObjectName(fileUrl);
            ossClient.deleteObject(bucketName, objectName);

            log.info("文件删除成功: {}", fileUrl);

        } catch (Exception e) {
            log.error("文件删除失败", e);
            throw new BusinessException(50000, "文件删除失败: " + e.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    @Override
    public String generatePresignedUrl(String fileUrl, long expireSeconds) {
        OSS ossClient = null;
        try {
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            String objectName = extractObjectName(fileUrl);
            Date expiration = new Date(System.currentTimeMillis() + expireSeconds * 1000);
            URL url = ossClient.generatePresignedUrl(bucketName, objectName, expiration);

            return url.toString();

        } catch (Exception e) {
            log.error("生成预签名URL失败", e);
            throw new BusinessException(50000, "生成预签名URL失败: " + e.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    @Override
    public boolean fileExists(String fileUrl) {
        OSS ossClient = null;
        try {
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            String objectName = extractObjectName(fileUrl);
            return ossClient.doesObjectExist(bucketName, objectName);

        } catch (Exception e) {
            log.error("检查文件是否存在失败", e);
            return false;
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    private String extractObjectName(String fileUrl) {
        if (fileUrl.contains(bucketName + "." + endpoint)) {
            return fileUrl.substring(fileUrl.indexOf(bucketName + "." + endpoint) + bucketName.length() + endpoint.length() + 2);
        } else if (!customDomain.isEmpty() && fileUrl.contains(customDomain)) {
            return fileUrl.substring(fileUrl.indexOf(customDomain) + customDomain.length() + 1);
        }
        throw new IllegalArgumentException("无法解析文件URL: " + fileUrl);
    }
}
