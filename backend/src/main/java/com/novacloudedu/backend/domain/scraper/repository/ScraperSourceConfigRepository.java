package com.novacloudedu.backend.domain.scraper.repository;

import com.novacloudedu.backend.domain.scraper.entity.ScraperSourceConfig;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperConfigId;

import java.util.List;
import java.util.Optional;

/**
 * 抓取源配置仓储接口
 */
public interface ScraperSourceConfigRepository {

    ScraperSourceConfig save(ScraperSourceConfig config);

    Optional<ScraperSourceConfig> findById(ScraperConfigId id);

    Optional<ScraperSourceConfig> findBySourceCode(String sourceCode);

    List<ScraperSourceConfig> findAll();

    List<ScraperSourceConfig> findAllEnabled();

    List<ScraperSourceConfig> findByPage(int page, int size);

    ConfigPage findByPageWithTotal(int page, int size);

    long count();

    void deleteById(ScraperConfigId id);

    /**
     * 配置分页结果
     */
    record ConfigPage(List<ScraperSourceConfig> configs, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return pageSize > 0 ? (int) Math.ceil((double) total / pageSize) : 0;
        }
    }
}
