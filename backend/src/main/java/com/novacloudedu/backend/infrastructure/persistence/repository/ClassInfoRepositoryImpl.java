package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.clazz.entity.ClassInfo;
import com.novacloudedu.backend.domain.clazz.repository.ClassInfoRepository;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ClassInfoConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ClassInfoMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassInfoPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class ClassInfoRepositoryImpl implements ClassInfoRepository {

    private final ClassInfoMapper classInfoMapper;
    private final ClassInfoConverter converter;

    @Override
    public ClassInfo save(ClassInfo classInfo) {
        ClassInfoPO po = converter.toPO(classInfo);
        if (po.getId() == null) {
            classInfoMapper.insert(po);
            classInfo.assignId(ClassId.of(po.getId()));
        } else {
            classInfoMapper.updateById(po);
        }
        return classInfo;
    }

    @Override
    public void update(ClassInfo classInfo) {
        ClassInfoPO po = converter.toPO(classInfo);
        classInfoMapper.updateById(po);
    }

    @Override
    public Optional<ClassInfo> findById(ClassId id) {
        ClassInfoPO po = classInfoMapper.selectById(id.getValue());
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<ClassInfo> findByCreatorId(UserId creatorId) {
        LambdaQueryWrapper<ClassInfoPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassInfoPO::getCreatorId, creatorId.value())
               .orderByDesc(ClassInfoPO::getCreateTime);
        return classInfoMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public ClassPage findAll(int pageNum, int pageSize) {
        Page<ClassInfoPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<ClassInfoPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(ClassInfoPO::getCreateTime);
        Page<ClassInfoPO> result = classInfoMapper.selectPage(page, wrapper);
        
        List<ClassInfo> list = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new ClassPage(list, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public ClassPage searchByName(String keyword, int pageNum, int pageSize) {
        Page<ClassInfoPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<ClassInfoPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(ClassInfoPO::getClassName, keyword)
               .orderByDesc(ClassInfoPO::getCreateTime);
        Page<ClassInfoPO> result = classInfoMapper.selectPage(page, wrapper);
        
        List<ClassInfo> list = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new ClassPage(list, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public void delete(ClassId id) {
        classInfoMapper.deleteById(id.getValue());
    }
}
