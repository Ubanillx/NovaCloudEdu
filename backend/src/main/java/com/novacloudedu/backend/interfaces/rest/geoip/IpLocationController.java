package com.novacloudedu.backend.interfaces.rest.geoip;

import com.novacloudedu.backend.application.service.IpLocationApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.interfaces.rest.geoip.dto.BatchIpLocationRequest;
import com.novacloudedu.backend.interfaces.rest.geoip.dto.IpLocationResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/ip-location")
@RequiredArgsConstructor
@Tag(name = "IP归属地", description = "基于本地 GeoLite2-City.mmdb 的 IP 归属地查询")
public class IpLocationController {

    private final IpLocationApplicationService ipLocationApplicationService;

    @GetMapping
    @Operation(summary = "查询单个 IP 归属地")
    public BaseResponse<IpLocationResponse> lookup(@RequestParam String ip) {
        return ResultUtils.success(ipLocationApplicationService.lookup(ip));
    }

    @PostMapping("/batch")
    @Operation(summary = "批量查询 IP 归属地")
    public BaseResponse<Map<String, IpLocationResponse>> lookupBatch(@RequestBody BatchIpLocationRequest request) {
        return ResultUtils.success(ipLocationApplicationService.lookupBatch(request.getIps()));
    }
}
