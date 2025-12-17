package com.novacloudedu.backend.domain.clazz.repository;

import com.novacloudedu.backend.domain.clazz.entity.ClassInfo;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Value;

import java.util.List;
import java.util.Optional;

public interface ClassInfoRepository {
    ClassInfo save(ClassInfo classInfo);
    
    void update(ClassInfo classInfo);
    
    Optional<ClassInfo> findById(ClassId id);
    
    List<ClassInfo> findByCreatorId(UserId creatorId);
    
    ClassPage findAll(int pageNum, int pageSize);
    
    ClassPage searchByName(String keyword, int pageNum, int pageSize);
    
    void delete(ClassId id);

    @Value
    class ClassPage {
        List<ClassInfo> list;
        long total;
        int pageNum;
        int pageSize;
    }
}
