package com.novacloudedu.backend.domain.book.service;

import lombok.Getter;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

@Service
public class ContentSecurityService {

    private static final String ALGORITHM = "AES/CBC/PKCS5Padding";
    private static final int IV_SIZE = 16;

    public EncryptedContent encrypt(String content, String sessionKey) {
        try {
            byte[] iv = generateIV();
            
            SecretKeySpec keySpec = new SecretKeySpec(
                    sessionKey.getBytes(StandardCharsets.UTF_8), 
                    "AES"
            );
            IvParameterSpec ivSpec = new IvParameterSpec(iv);
            
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
            
            byte[] encrypted = cipher.doFinal(content.getBytes(StandardCharsets.UTF_8));
            
            return new EncryptedContent(
                    Base64.getEncoder().encodeToString(encrypted),
                    Base64.getEncoder().encodeToString(iv)
            );
        } catch (Exception e) {
            throw new RuntimeException("内容加密失败", e);
        }
    }

    public String decrypt(String encryptedContent, String sessionKey, String ivBase64) {
        try {
            byte[] iv = Base64.getDecoder().decode(ivBase64);
            byte[] encrypted = Base64.getDecoder().decode(encryptedContent);
            
            SecretKeySpec keySpec = new SecretKeySpec(
                    sessionKey.getBytes(StandardCharsets.UTF_8), 
                    "AES"
            );
            IvParameterSpec ivSpec = new IvParameterSpec(iv);
            
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);
            
            byte[] decrypted = cipher.doFinal(encrypted);
            return new String(decrypted, StandardCharsets.UTF_8);
        } catch (Exception e) {
            throw new RuntimeException("内容解密失败", e);
        }
    }

    private byte[] generateIV() {
        byte[] iv = new byte[IV_SIZE];
        new SecureRandom().nextBytes(iv);
        return iv;
    }

    @Getter
    public static class EncryptedContent {
        private final String content;
        private final String iv;

        public EncryptedContent(String content, String iv) {
            this.content = content;
            this.iv = iv;
        }
    }
}
