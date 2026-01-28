package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.novacloudedu.backend.domain.checkin.entity.UserCheckin;
import com.novacloudedu.backend.domain.checkin.entity.UserCheckinStats;
import com.novacloudedu.backend.domain.checkin.repository.CheckinRepository;
import com.novacloudedu.backend.domain.checkin.valueobject.CheckinId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.CheckinConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.CheckinMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserCheckinPO;
import com.novacloudedu.backend.infrastructure.persistence.po.UserCheckinStatsPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 打卡仓储实现
 */
@Repository
@RequiredArgsConstructor
public class CheckinRepositoryImpl implements CheckinRepository {

    private final CheckinMapper checkinMapper;

    @Override
    public UserCheckin saveCheckin(UserCheckin checkin) {
        UserCheckinPO po = CheckinConverter.toCheckinPO(checkin);
        checkinMapper.insertCheckin(po);
        checkin.assignId(CheckinId.of(po.getId()));
        return checkin;
    }

    @Override
    public UserCheckinStats saveStats(UserCheckinStats stats) {
        UserCheckinStatsPO po = CheckinConverter.toStatsPO(stats);
        if (stats.getId() == null) {
            checkinMapper.insertStats(po);
            stats.assignId(po.getId());
        } else {
            checkinMapper.updateStats(po);
        }
        return stats;
    }

    @Override
    public Optional<UserCheckin> findCheckinByUserIdAndDate(UserId userId, LocalDate date) {
        UserCheckinPO po = checkinMapper.selectByUserIdAndDate(userId.value(), date);
        return Optional.ofNullable(CheckinConverter.toCheckinEntity(po));
    }

    @Override
    public Optional<UserCheckinStats> findStatsByUserId(UserId userId) {
        UserCheckinStatsPO po = checkinMapper.selectStatsByUserId(userId.value());
        return Optional.ofNullable(CheckinConverter.toStatsEntity(po));
    }

    @Override
    public List<CheckinRankingItem> getCheckinRanking(int limit) {
        List<Map<String, Object>> results = checkinMapper.selectCheckinRanking(limit);
        List<CheckinRankingItem> items = new ArrayList<>();
        
        // 将 Map 转换为 CheckinRankingItem 并添加排名
        for (int i = 0; i < results.size(); i++) {
            Map<String, Object> row = results.get(i);
            items.add(new CheckinRankingItem(
                    ((Number) row.get("userid")).longValue(),
                    (String) row.get("username"),
                    (String) row.get("useravatar"),
                    ((Number) row.get("totalcheckindays")).intValue(),
                    ((Number) row.get("currentstreak")).intValue(),
                    i + 1  // 排名从1开始
            ));
        }
        return items;
    }

    @Override
    public List<UserCheckin> findCheckinHistory(UserId userId, int page, int size) {
        int offset = (page - 1) * size;
        List<UserCheckinPO> poList = checkinMapper.selectCheckinHistory(userId.value(), offset, size);
        return poList.stream()
                .map(CheckinConverter::toCheckinEntity)
                .collect(Collectors.toList());
    }
}
