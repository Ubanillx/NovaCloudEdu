package com.novacloudedu.backend.domain.membership.repository;

import com.novacloudedu.backend.domain.membership.entity.MembershipPlan;
import com.novacloudedu.backend.domain.membership.valueobject.PlanCode;

import java.util.List;
import java.util.Optional;

public interface MembershipPlanRepository {

    MembershipPlan save(MembershipPlan plan);

    Optional<MembershipPlan> findById(Long id);

    Optional<MembershipPlan> findByCode(PlanCode code);

    Optional<MembershipPlan> findDefault();

    List<MembershipPlan> findAll();

    void deleteById(Long id);
}
