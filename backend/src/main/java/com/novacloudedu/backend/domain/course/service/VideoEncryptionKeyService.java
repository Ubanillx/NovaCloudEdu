package com.novacloudedu.backend.domain.course.service;

/**
 * 视频加密密钥管理服务接口
 * 负责生成、存储和获取 AES-128 加密密钥
 */
public interface VideoEncryptionKeyService {

    /**
     * 为视频生成一个新的 AES-128 密钥并存储
     * @return 密钥ID（keyId）
     */
    String generateAndStoreKey();

    /**
     * 根据密钥ID获取 AES-128 密钥（16字节）
     * @param keyId 密钥ID
     * @return AES-128 密钥字节数组，不存在返回 null
     */
    byte[] getKey(String keyId);

    /**
     * 删除密钥
     * @param keyId 密钥ID
     */
    void deleteKey(String keyId);
}
