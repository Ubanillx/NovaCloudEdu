package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.grading.entity.HomeworkSubmission;
import com.novacloudedu.backend.domain.grading.repository.HomeworkSubmissionRepository;
import com.novacloudedu.backend.domain.grading.valueobject.GradingStatus;
import com.novacloudedu.backend.domain.grading.valueobject.SubmissionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.HomeworkSubmissionConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.HomeworkSubmissionMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.HomeworkSubmissionPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class HomeworkSubmissionRepositoryImpl implements HomeworkSubmissionRepository {

    private final HomeworkSubmissionMapper mapper;
    private final HomeworkSubmissionConverter converter;

    @Override
    public HomeworkSubmission save(HomeworkSubmission submission) {
        HomeworkSubmissionPO po = converter.toPO(submission);
        if (po.getId() != null && mapper.selectById(po.getId()) != null) {
            mapper.updateById(po);
        } else {
            mapper.insert(po);
        }
        if (submission.getId() == null) {
            submission.assignId(SubmissionId.of(po.getId()));
        }
        return submission;
    }

    @Override
    public Optional<HomeworkSubmission> findById(SubmissionId id) {
        HomeworkSubmissionPO po = mapper.selectById(id.getValue());
        return Optional.ofNullable(po).map(converter::toDomain);
    }

    @Override
    public List<HomeworkSubmission> findByStudentId(UserId studentId, int page, int size) {
        Page<HomeworkSubmissionPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<HomeworkSubmissionPO> wrapper = new LambdaQueryWrapper<HomeworkSubmissionPO>()
                .eq(HomeworkSubmissionPO::getStudentId, studentId.value())
                .orderByDesc(HomeworkSubmissionPO::getCreateTime);
        return mapper.selectPage(pageParam, wrapper).getRecords()
                .stream().map(converter::toDomain).toList();
    }

    @Override
    public List<HomeworkSubmission> findByStatus(GradingStatus status, int page, int size) {
        Page<HomeworkSubmissionPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<HomeworkSubmissionPO> wrapper = new LambdaQueryWrapper<HomeworkSubmissionPO>()
                .eq(HomeworkSubmissionPO::getStatus, status.getCode())
                .orderByDesc(HomeworkSubmissionPO::getCreateTime);
        return mapper.selectPage(pageParam, wrapper).getRecords()
                .stream().map(converter::toDomain).toList();
    }

    @Override
    public List<HomeworkSubmission> findByClassId(Long classId, int page, int size) {
        Page<HomeworkSubmissionPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<HomeworkSubmissionPO> wrapper = new LambdaQueryWrapper<HomeworkSubmissionPO>()
                .eq(HomeworkSubmissionPO::getClassId, classId)
                .orderByDesc(HomeworkSubmissionPO::getCreateTime);
        return mapper.selectPage(pageParam, wrapper).getRecords()
                .stream().map(converter::toDomain).toList();
    }

    @Override
    public long countByStudentId(UserId studentId) {
        LambdaQueryWrapper<HomeworkSubmissionPO> wrapper = new LambdaQueryWrapper<HomeworkSubmissionPO>()
                .eq(HomeworkSubmissionPO::getStudentId, studentId.value());
        return mapper.selectCount(wrapper);
    }
}
