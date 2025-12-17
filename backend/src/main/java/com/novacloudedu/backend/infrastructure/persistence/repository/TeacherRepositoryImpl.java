package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.teacher.entity.Teacher;
import com.novacloudedu.backend.domain.teacher.repository.TeacherRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.TeacherConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.TeacherMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.TeacherPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class TeacherRepositoryImpl implements TeacherRepository {

    private final TeacherMapper teacherMapper;
    private final TeacherConverter teacherConverter;

    @Override
    public Teacher save(Teacher teacher) {
        TeacherPO po = teacherConverter.toTeacherPO(teacher);
        if (po.getId() == null) {
            teacherMapper.insert(po);
            teacher.assignId(TeacherId.of(po.getId()));
        } else {
            teacherMapper.updateById(po);
        }
        return teacher;
    }

    @Override
    public Optional<Teacher> findById(TeacherId id) {
        TeacherPO po = teacherMapper.selectById(id.value());
        return Optional.ofNullable(po).map(teacherConverter::toTeacher);
    }

    @Override
    public Optional<Teacher> findByUserId(UserId userId) {
        LambdaQueryWrapper<TeacherPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(TeacherPO::getUserId, userId.value());
        TeacherPO po = teacherMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(teacherConverter::toTeacher);
    }

    @Override
    public List<Teacher> findAll(int page, int size) {
        Page<TeacherPO> pageParam = new Page<>(page, size);
        Page<TeacherPO> result = teacherMapper.selectPage(pageParam, null);
        return result.getRecords().stream()
                .map(teacherConverter::toTeacher)
                .collect(Collectors.toList());
    }

    @Override
    public long count() {
        return teacherMapper.selectCount(null);
    }

    @Override
    public void deleteById(TeacherId id) {
        teacherMapper.deleteById(id.value());
    }
}
