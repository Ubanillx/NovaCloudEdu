package com.novacloudedu.backend.domain.recommendation.repository;

import com.novacloudedu.backend.domain.recommendation.entity.UserPreference;
import com.novacloudedu.backend.domain.recommendation.valueobject.PreferenceType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface UserPreferenceRepository {

    UserPreference save(UserPreference preference);

    Optional<UserPreference> findById(Long id);

    Optional<UserPreference> findByUserIdAndTypeAndKey(UserId userId, PreferenceType type, String key);

    List<UserPreference> findByUserId(UserId userId);

    List<UserPreference> findByUserIdAndType(UserId userId, PreferenceType type);

    List<UserPreference> findTopByUserIdAndType(UserId userId, PreferenceType type, int limit);

    void deleteByUserId(UserId userId);
}
