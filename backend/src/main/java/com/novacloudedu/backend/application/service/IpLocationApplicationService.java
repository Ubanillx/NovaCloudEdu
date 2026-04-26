package com.novacloudedu.backend.application.service;

import com.maxmind.db.CHMCache;
import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.exception.GeoIp2Exception;
import com.maxmind.geoip2.model.CityResponse;
import com.novacloudedu.backend.interfaces.rest.geoip.dto.IpLocationResponse;
import jakarta.annotation.PreDestroy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Slf4j
@Service
public class IpLocationApplicationService {

    private final DatabaseReader databaseReader;

    public IpLocationApplicationService(@Value("${geoip.database-path}") Resource databaseResource) {
        this.databaseReader = createReader(databaseResource);
    }

    public IpLocationResponse lookup(String ip) {
        String normalizedIp = normalizeIp(ip);
        if (normalizedIp == null) {
            return failed(ip, "无效 IP");
        }

        String localDisplay = localDisplay(normalizedIp);
        if (localDisplay != null) {
            return IpLocationResponse.builder()
                    .ip(normalizedIp)
                    .success(true)
                    .display(localDisplay)
                    .message("local")
                    .build();
        }

        if (databaseReader == null) {
            return failed(normalizedIp, "GeoLite2-City.mmdb 未配置");
        }

        try {
            CityResponse response = databaseReader.city(InetAddress.getByName(normalizedIp));
            String country = name(response.getCountry().getNames());
            String province = response.getMostSpecificSubdivision() != null
                    ? name(response.getMostSpecificSubdivision().getNames())
                    : null;
            String city = response.getCity() != null ? name(response.getCity().getNames()) : null;
            String display = buildDisplay(country, province, city);

            return IpLocationResponse.builder()
                    .ip(normalizedIp)
                    .success(display != null && !display.isBlank())
                    .display(display == null || display.isBlank() ? "未知地区" : display)
                    .country(country)
                    .province(province)
                    .city(city)
                    .message(display == null || display.isBlank() ? "未匹配到归属地" : "ok")
                    .build();
        } catch (IOException | GeoIp2Exception e) {
            return failed(normalizedIp, "未匹配到归属地");
        }
    }

    public Map<String, IpLocationResponse> lookupBatch(List<String> ips) {
        Map<String, IpLocationResponse> result = new LinkedHashMap<>();
        if (ips == null) {
            return result;
        }

        for (String ip : uniqueIps(ips)) {
            result.put(ip, lookup(ip));
        }
        return result;
    }

    @PreDestroy
    public void close() {
        if (databaseReader != null) {
            try {
                databaseReader.close();
            } catch (IOException e) {
                log.warn("关闭 GeoIP 数据库失败", e);
            }
        }
    }

    private DatabaseReader createReader(Resource resource) {
        try {
            if (!resource.exists()) {
                log.warn("GeoIP 数据库不存在：{}", resource);
                return null;
            }
            InputStream inputStream = resource.getInputStream();
            return new DatabaseReader.Builder(inputStream).withCache(new CHMCache()).build();
        } catch (IOException e) {
            log.warn("加载 GeoIP 数据库失败：{}", resource, e);
            return null;
        }
    }

    private String normalizeIp(String ip) {
        if (ip == null) return null;
        String normalized = ip.trim();
        return normalized.isEmpty() || normalized.length() > 128 ? null : normalized;
    }

    private String localDisplay(String ip) {
        if ("localhost".equalsIgnoreCase(ip)
                || "127.0.0.1".equals(ip)
                || "::1".equals(ip)
                || "0:0:0:0:0:0:0:1".equals(ip)) {
            return "本机";
        }
        if (ip.startsWith("10.") || ip.startsWith("192.168.") || ip.matches("^172\\.(1[6-9]|2\\d|3[0-1])\\..*")) {
            return "内网";
        }
        String lower = ip.toLowerCase(Locale.ROOT);
        if (lower.startsWith("fc") || lower.startsWith("fd") || lower.startsWith("fe80:")) {
            return "内网";
        }
        return null;
    }

    private List<String> uniqueIps(List<String> ips) {
        List<String> result = new ArrayList<>();
        for (String ip : ips) {
            String normalized = normalizeIp(ip);
            if (normalized != null && !result.contains(normalized)) {
                result.add(normalized);
            }
        }
        return result;
    }

    private String name(Map<String, String> names) {
        if (names == null || names.isEmpty()) return null;
        String zh = names.get("zh-CN");
        if (zh != null && !zh.isBlank()) return zh;
        String en = names.get("en");
        if (en != null && !en.isBlank()) return en;
        return names.values().stream().filter(value -> value != null && !value.isBlank()).findFirst().orElse(null);
    }

    private String buildDisplay(String country, String province, String city) {
        List<String> parts = new ArrayList<>();
        boolean isChina = "中国".equals(country) || "China".equalsIgnoreCase(country);
        if (!isChina && country != null && !country.isBlank()) {
            parts.add(country);
        }
        if (province != null && !province.isBlank() && !parts.contains(province)) {
            parts.add(province);
        }
        if (city != null && !city.isBlank() && !parts.contains(city)) {
            parts.add(city);
        }
        return String.join(" ", parts);
    }

    private IpLocationResponse failed(String ip, String message) {
        return IpLocationResponse.builder()
                .ip(ip)
                .success(false)
                .display("未知地区")
                .message(message)
                .build();
    }
}
