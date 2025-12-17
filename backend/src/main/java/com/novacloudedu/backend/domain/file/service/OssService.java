package com.novacloudedu.backend.domain.file.service;

import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import org.springframework.web.multipart.MultipartFile;

/**
 * 对象存储服务接口
 * 支持阿里云OSS、腾讯云COS、MinIO等
 */
public interface OssService {

    /**
     * 上传文件
     * @param file 文件
     * @param businessType 业务类型（决定存储文件夹）
     * @return 文件访问URL
     */
    String uploadFile(MultipartFile file, FileBusinessType businessType);

    /**
     * 删除文件
     * @param fileUrl 文件URL
     */
    void deleteFile(String fileUrl);

    /**
     * 生成预签名URL（用于私有文件临时访问）
     * @param fileUrl 文件URL
     * @param expireSeconds 过期时间（秒）
     * @return 预签名URL
     */
    String generatePresignedUrl(String fileUrl, long expireSeconds);

    /**
     * 检查文件是否存在
     * @param fileUrl 文件URL
     * @return 是否存在
     */
    boolean fileExists(String fileUrl);
}
