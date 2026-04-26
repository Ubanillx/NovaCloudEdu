package com.novacloudedu.backend.interfaces.rest.geoip.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@Schema(description = "IP 归属地响应")
public class IpLocationResponse {

    @Schema(description = "IP 地址")
    private String ip;

    @Schema(description = "是否查询成功")
    private Boolean success;

    @Schema(description = "展示用归属地文本", example = "江苏 南京")
    private String display;

    @Schema(description = "国家/地区")
    private String country;

    @Schema(description = "省/州")
    private String province;

    @Schema(description = "城市")
    private String city;

    @Schema(description = "错误原因或状态说明")
    private String message;
}
