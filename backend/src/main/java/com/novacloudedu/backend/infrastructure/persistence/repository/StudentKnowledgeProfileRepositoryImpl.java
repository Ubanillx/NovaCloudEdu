package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.grading.entity.StudentKnowledgeProfile;
import com.novacloudedu.backend.domain.grading.repository.StudentKnowledgeProfileRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.StudentKnowledgeProfileConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.StudentKnowledgeProfileMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.StudentKnowledgeProfilePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class StudentKnowledgeProfileRepositoryImpl implements StudentKnowledgeProfileRepository {

    private final StudentKnowledgeProfileMapper mapper;
    private final StudentKnowledgeProfileConverter converter;

    @Override
    public StudentKnowledgeProfile save(StudentKnowledgeProfile profile) {
        StudentKnowledgeProfilePO po = converter.toPO(profile);
        if (po.getId() != null && mapper.selectById(po.getId()) != null) {
            mapper.updateById(po);
        } else {
            // 尝试 upsert：先查是否存在相同 student+subject+point
            LambdaQueryWrapper<StudentKnowledgeProfilePO> wrapper = new LambdaQueryWrapper<StudentKnowledgeProfilePO>()
                    .eq(StudentKnowledgeProfilePO::getStudentId, po.getStudentId())
                    .eq(StudentKnowledgeProfilePO::getSubject, po.getSubject())
                    .eq(StudentKnowledgeProfilePO::getKnowledgePoint, po.getKnowledgePoint());
            StudentKnowledgeProfilePO existing = mapper.selectOne(wrapper);
            if (existing != null) {
                po.setId(existing.getId());
                mapper.updateById(po);
            } else {
                mapper.insert(po);
            }
        }
        return profile;
    }

    @Override
    public Optional<StudentKnowledgeProfile> findByStudentAndSubjectAndPoint(UserId studentId, Subject subject, String knowledgePoint) {
        LambdaQueryWrapper<StudentKnowledgeProfilePO> wrapper = new LambdaQueryWrapper<StudentKnowledgeProfilePO>()
                .eq(StudentKnowledgeProfilePO::getStudentId, studentId.value())
                .eq(StudentKnowledgeProfilePO::getSubject, subject.getCode())
                .eq(StudentKnowledgeProfilePO::getKnowledgePoint, knowledgePoint);
        StudentKnowledgeProfilePO po = mapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(converter::toDomain);
    }

    @Override
    public List<StudentKnowledgeProfile> findByStudentAndSubject(UserId studentId, Subject subject) {
        LambdaQueryWrapper<StudentKnowledgeProfilePO> wrapper = new LambdaQueryWrapper<StudentKnowledgeProfilePO>()
                .eq(StudentKnowledgeProfilePO::getStudentId, studentId.value())
                .eq(StudentKnowledgeProfilePO::getSubject, subject.getCode())
                .orderByAsc(StudentKnowledgeProfilePO::getMasteryLevel);
        return mapper.selectList(wrapper).stream().map(converter::toDomain).toList();
    }

    @Override
    public List<StudentKnowledgeProfile> findWeakPoints(UserId studentId, Subject subject) {
        LambdaQueryWrapper<StudentKnowledgeProfilePO> wrapper = new LambdaQueryWrapper<StudentKnowledgeProfilePO>()
                .eq(StudentKnowledgeProfilePO::getStudentId, studentId.value())
                .eq(StudentKnowledgeProfilePO::getSubject, subject.getCode())
                .lt(StudentKnowledgeProfilePO::getMasteryLevel, 0.4)
                .ge(StudentKnowledgeProfilePO::getTotalAttempts, 3)
                .orderByAsc(StudentKnowledgeProfilePO::getMasteryLevel);
        return mapper.selectList(wrapper).stream().map(converter::toDomain).toList();
    }

    @Override
    public List<StudentKnowledgeProfile> findByStudentId(UserId studentId) {
        LambdaQueryWrapper<StudentKnowledgeProfilePO> wrapper = new LambdaQueryWrapper<StudentKnowledgeProfilePO>()
                .eq(StudentKnowledgeProfilePO::getStudentId, studentId.value())
                .orderByAsc(StudentKnowledgeProfilePO::getSubject)
                .orderByAsc(StudentKnowledgeProfilePO::getMasteryLevel);
        return mapper.selectList(wrapper).stream().map(converter::toDomain).toList();
    }
}
