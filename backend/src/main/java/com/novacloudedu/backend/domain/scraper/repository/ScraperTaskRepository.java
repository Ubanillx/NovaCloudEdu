package com.novacloudedu.backend.domain.scraper.repository;

import com.novacloudedu.backend.domain.scraper.entity.ScraperTask;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperConfigId;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperTaskId;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * 抓取任务仓储接口
 */
public interface ScraperTaskRepository {

    ScraperTask save(ScraperTask task);

    Optional<ScraperTask> findById(ScraperTaskId id);

    List<ScraperTask> findByConfigId(ScraperConfigId configId, int page, int size);

    TaskPage findByConfigIdWithTotal(ScraperConfigId configId, int page, int size);

    List<ScraperTask> findByDateRange(LocalDateTime startTime, LocalDateTime endTime, int page, int size);

    List<ScraperTask> findAll(int page, int size);

    TaskPage findAllWithTotal(int page, int size);

    Optional<ScraperTask> findLatestByConfigId(ScraperConfigId configId);

    long count();

    long countByConfigId(ScraperConfigId configId);

    void deleteById(ScraperTaskId id);

    /**
     * 任务分页结果
     */
    record TaskPage(List<ScraperTask> tasks, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return pageSize > 0 ? (int) Math.ceil((double) total / pageSize) : 0;
        }
    }
}
