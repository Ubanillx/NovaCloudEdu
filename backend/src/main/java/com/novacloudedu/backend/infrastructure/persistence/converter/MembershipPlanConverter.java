package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.membership.entity.MembershipPlan;
import com.novacloudedu.backend.domain.membership.valueobject.PlanCode;
import com.novacloudedu.backend.infrastructure.persistence.po.MembershipPlanPO;
import org.springframework.stereotype.Component;

@Component
public class MembershipPlanConverter {

    public MembershipPlanPO toPO(MembershipPlan plan) {
        MembershipPlanPO po = new MembershipPlanPO();
        if (plan.getId() != null) {
            po.setId(plan.getId());
        }
        po.setName(plan.getName());
        po.setCode(plan.getCode().getValue());
        po.setDescription(plan.getDescription());
        po.setPrice(plan.getPrice());
        po.setDurationDays(plan.getDurationDays());
        po.setAiChatDailyLimit(plan.getAiChatDailyLimit());
        po.setAiChatMonthlyLimit(plan.getAiChatMonthlyLimit());
        po.setAiPptDailyLimit(plan.getAiPptDailyLimit());
        po.setAiPptMonthlyLimit(plan.getAiPptMonthlyLimit());
        po.setAiExamDailyLimit(plan.getAiExamDailyLimit());
        po.setAiExamMonthlyLimit(plan.getAiExamMonthlyLimit());
        po.setAiBookDailyLimit(plan.getAiBookDailyLimit());
        po.setAiBookMonthlyLimit(plan.getAiBookMonthlyLimit());
        po.setCourseMemberAccess(plan.isCourseMemberAccess() ? 1 : 0);
        po.setIsDefault(plan.isDefault() ? 1 : 0);
        po.setSortOrder(plan.getSortOrder());
        po.setCreateTime(plan.getCreateTime());
        po.setUpdateTime(plan.getUpdateTime());
        return po;
    }

    public MembershipPlan toDomain(MembershipPlanPO po) {
        return MembershipPlan.reconstruct(
                po.getId(),
                po.getName(),
                PlanCode.fromValue(po.getCode()),
                po.getDescription(),
                po.getPrice(),
                po.getDurationDays(),
                po.getAiChatDailyLimit(),
                po.getAiChatMonthlyLimit(),
                po.getAiPptDailyLimit(),
                po.getAiPptMonthlyLimit(),
                po.getAiExamDailyLimit(),
                po.getAiExamMonthlyLimit(),
                po.getAiBookDailyLimit(),
                po.getAiBookMonthlyLimit(),
                po.getCourseMemberAccess() != null && po.getCourseMemberAccess() == 1,
                po.getIsDefault() != null && po.getIsDefault() == 1,
                po.getSortOrder(),
                po.getCreateTime(),
                po.getUpdateTime(),
                po.getIsDelete() != null && po.getIsDelete() == 1
        );
    }
}
