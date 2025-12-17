package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.clazz.entity.ClassMember;
import com.novacloudedu.backend.domain.clazz.repository.ClassMemberRepository;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ClassMemberConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ClassMemberMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassMemberPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class ClassMemberRepositoryImpl implements ClassMemberRepository {

    private final ClassMemberMapper classMemberMapper;
    private final ClassMemberConverter converter;

    @Override
    public ClassMember save(ClassMember member) {
        ClassMemberPO po = converter.toPO(member);
        if (po.getId() == null) {
            classMemberMapper.insert(po);
            member.assignId(po.getId());
        } else {
            classMemberMapper.updateById(po);
        }
        return member;
    }

    @Override
    public void update(ClassMember member) {
        ClassMemberPO po = converter.toPO(member);
        classMemberMapper.updateById(po);
    }

    @Override
    public List<ClassMember> findByClassId(ClassId classId) {
        LambdaQueryWrapper<ClassMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassMemberPO::getClassId, classId.getValue());
        return classMemberMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public MemberPage findByClassId(ClassId classId, int pageNum, int pageSize) {
        Page<ClassMemberPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<ClassMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassMemberPO::getClassId, classId.getValue())
               .orderByDesc(ClassMemberPO::getJoinTime);
        Page<ClassMemberPO> result = classMemberMapper.selectPage(page, wrapper);
        
        List<ClassMember> list = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new MemberPage(list, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public List<ClassMember> findByUserId(UserId userId) {
        LambdaQueryWrapper<ClassMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassMemberPO::getUserId, userId.value())
               .orderByDesc(ClassMemberPO::getJoinTime);
        return classMemberMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public Optional<ClassMember> findByClassIdAndUserId(ClassId classId, UserId userId) {
        LambdaQueryWrapper<ClassMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassMemberPO::getClassId, classId.getValue())
               .eq(ClassMemberPO::getUserId, userId.value());
        ClassMemberPO po = classMemberMapper.selectOne(wrapper);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public void deleteByClassId(ClassId classId) {
        LambdaQueryWrapper<ClassMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassMemberPO::getClassId, classId.getValue());
        classMemberMapper.delete(wrapper);
    }

    @Override
    public void deleteByClassIdAndUserId(ClassId classId, UserId userId) {
        LambdaQueryWrapper<ClassMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassMemberPO::getClassId, classId.getValue())
               .eq(ClassMemberPO::getUserId, userId.value());
        classMemberMapper.delete(wrapper);
    }
}
