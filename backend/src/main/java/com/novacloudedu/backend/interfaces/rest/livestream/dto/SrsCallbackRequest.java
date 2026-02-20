package com.novacloudedu.backend.interfaces.rest.livestream.dto;

import lombok.Data;

/**
 * SRS HTTP 回调请求
 */
@Data
public class SrsCallbackRequest {
    private String action;
    private String clientId;
    private String ip;
    private String vhost;
    private String app;
    private String stream;
    private String param;
    private String tcUrl;
    private String pageUrl;
}
