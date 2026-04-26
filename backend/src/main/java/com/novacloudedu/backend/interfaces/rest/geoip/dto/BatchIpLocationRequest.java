package com.novacloudedu.backend.interfaces.rest.geoip.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "批量 IP 归属地查询请求")
public class BatchIpLocationRequest {

    @Schema(description = "IP 地址列表", example = "[\"114.114.114.114\", \"8.8.8.8\"]")
    private List<String> ips;
}
