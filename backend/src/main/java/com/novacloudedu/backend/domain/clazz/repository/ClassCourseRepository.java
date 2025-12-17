package com.novacloudedu.backend.domain.clazz.repository;

import com.novacloudedu.backend.domain.clazz.entity.ClassCourse;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;

import java.util.List;
import java.util.Optional;

public interface ClassCourseRepository {
    ClassCourse save(ClassCourse classCourse);
    
    List<ClassCourse> findByClassId(ClassId classId);
    
    List<ClassCourse> findByCourseId(CourseId courseId);
    
    Optional<ClassCourse> findByClassIdAndCourseId(ClassId classId, CourseId courseId);
    
    void deleteByClassId(ClassId classId);
    
    void delete(Long id);
}
