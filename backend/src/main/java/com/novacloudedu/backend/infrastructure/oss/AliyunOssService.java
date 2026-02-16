package com.novacloudedu.backend.infrastructure.oss;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.OSSObject;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectRequest;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.net.URL;
import java.nio.charset.Charset;
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

    @Override
    public String uploadBytes(byte[] data, String extension, FileBusinessType businessType) {
        if (data == null || data.length == 0) {
            throw new BusinessException(40000, "文件数据不能为空");
        }

        OSS ossClient = null;
        try {
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            String dateFolder = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
            String fileName = UUID.randomUUID().toString().replace("-", "") + extension;
            String objectName = businessType.getFolder() + "/" + dateFolder + "/" + fileName;

            InputStream inputStream = new java.io.ByteArrayInputStream(data);
            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, inputStream);
            ossClient.putObject(putObjectRequest);

            String fileUrl = customDomain.isEmpty()
                    ? "https://" + bucketName + "." + endpoint + "/" + objectName
                    : customDomain + "/" + objectName;

            log.info("字节数据上传成功: {}, 大小: {}KB", fileUrl, data.length / 1024);
            return fileUrl;

        } catch (Exception e) {
            log.error("字节数据上传失败", e);
            throw new BusinessException(50000, "文件上传失败: " + e.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    @Override
    public String readFileAsString(String fileUrl, String encoding) {
        OSS ossClient = null;
        try {
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            String objectName = extractObjectName(fileUrl);
            OSSObject ossObject = ossClient.getObject(bucketName, objectName);

            try (InputStream is = ossObject.getObjectContent()) {
                byte[] bytes = is.readAllBytes();
                String charset = (encoding != null && !encoding.isBlank()) ? encoding : "UTF-8";
                String content = new String(bytes, Charset.forName(charset));
                log.info("OSS文件读取成功: {}, 大小: {}B", fileUrl, bytes.length);
                return content;
            }

        } catch (Exception e) {
            log.error("OSS文件读取失败: {}", fileUrl, e);
            throw new BusinessException(50000, "文件读取失败: " + e.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    @Override
    public String uploadString(String content, String fileName, String encoding, FileBusinessType businessType) {
        if (content == null) {
            content = "";
        }

        OSS ossClient = null;
        try {
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            String charset = (encoding != null && !encoding.isBlank()) ? encoding : "UTF-8";
            byte[] data = content.getBytes(Charset.forName(charset));

            String dateFolder = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
            // 保留原始文件名的扩展名
            String extension = (fileName != null && fileName.contains("."))
                    ? fileName.substring(fileName.lastIndexOf("."))
                    : ".txt";
            String objectFileName = UUID.randomUUID().toString().replace("-", "") + extension;
            String objectName = businessType.getFolder() + "/" + dateFolder + "/" + objectFileName;

            InputStream inputStream = new ByteArrayInputStream(data);
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(data.length);
            metadata.setContentType("text/plain; charset=" + charset);
            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, inputStream, metadata);
            ossClient.putObject(putObjectRequest);

            String fileUrl = customDomain.isEmpty()
                    ? "https://" + bucketName + "." + endpoint + "/" + objectName
                    : customDomain + "/" + objectName;

            log.info("字符串内容上传成功: {}, 文件名: {}, 大小: {}B", fileUrl, fileName, data.length);
            return fileUrl;

        } catch (Exception e) {
            log.error("字符串内容上传失败: {}", fileName, e);
            throw new BusinessException(50000, "文件写入失败: " + e.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    @Override
    public long getFileSize(String fileUrl) {
        OSS ossClient = null;
        try {
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            String objectName = extractObjectName(fileUrl);
            if (!ossClient.doesObjectExist(bucketName, objectName)) {
                return -1;
            }
            ObjectMetadata meta = ossClient.getObjectMetadata(bucketName, objectName);
            return meta.getContentLength();

        } catch (Exception e) {
            log.error("获取文件大小失败: {}", fileUrl, e);
            return -1;
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    @Override
    public String uploadToPath(byte[] data, String objectName, String contentType, boolean publicRead) {
        if (data == null || data.length == 0) {
            throw new BusinessException(40000, "文件数据不能为空");
        }

        OSS ossClient = null;
        try {
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            InputStream inputStream = new ByteArrayInputStream(data);
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(data.length);
            if (contentType != null && !contentType.isBlank()) {
                metadata.setContentType(contentType);
            }
            if (publicRead) {
                metadata.setObjectAcl(com.aliyun.oss.model.CannedAccessControlList.PublicRead);
            }

            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, inputStream, metadata);
            ossClient.putObject(putObjectRequest);

            String fileUrl = customDomain.isEmpty()
                    ? "https://" + bucketName + "." + endpoint + "/" + objectName
                    : customDomain + "/" + objectName;

            log.info("文件上传到指定路径成功: {}, publicRead={}", fileUrl, publicRead);
            return fileUrl;

        } catch (Exception e) {
            log.error("文件上传到指定路径失败: {}", objectName, e);
            throw new BusinessException(50000, "文件上传失败: " + e.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    private String extractObjectName(String fileUrl) {
        String objectName;
        if (fileUrl.contains(bucketName + "." + endpoint)) {
            objectName = fileUrl.substring(fileUrl.indexOf(bucketName + "." + endpoint) + bucketName.length() + endpoint.length() + 2);
        } else if (!customDomain.isEmpty() && fileUrl.contains(customDomain)) {
            objectName = fileUrl.substring(fileUrl.indexOf(customDomain) + customDomain.length() + 1);
        } else {
            throw new IllegalArgumentException("无法解析文件URL: " + fileUrl);
        }
        // 去掉查询参数（如预签名URL中的 ?Expires=...&Signature=...）
        int queryIndex = objectName.indexOf('?');
        if (queryIndex > 0) {
            objectName = objectName.substring(0, queryIndex);
        }
        return objectName;
    }
}
