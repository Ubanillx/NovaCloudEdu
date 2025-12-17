package com.novacloudedu.backend.domain.course.entity;

import com.novacloudedu.backend.domain.course.valueobject.CourseDifficulty;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.CourseStatus;
import com.novacloudedu.backend.domain.course.valueobject.CourseType;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Course {

    private CourseId id;
    private String title;
    private String subtitle;
    private String description;
    private String coverImage;
    private BigDecimal price;
    private CourseType courseType;
    private CourseDifficulty difficulty;
    private CourseStatus status;
    private TeacherId teacherId;
    private Integer totalDuration;
    private Integer totalChapters;
    private Integer totalSections;
    private Integer studentCount;
    private BigDecimal ratingScore;
    private List<String> tags;
    private UserId adminId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static Course create(String title, String subtitle, String description,
                               String coverImage, BigDecimal price, CourseType courseType,
                               CourseDifficulty difficulty, TeacherId teacherId,
                               List<String> tags, UserId adminId) {
        Course course = new Course();
        course.title = title;
        course.subtitle = subtitle;
        course.description = description;
        course.coverImage = coverImage;
        course.price = price != null ? price : BigDecimal.ZERO;
        course.courseType = courseType;
        course.difficulty = difficulty;
        course.status = CourseStatus.UNPUBLISHED;
        course.teacherId = teacherId;
        course.totalDuration = 0;
        course.totalChapters = 0;
        course.totalSections = 0;
        course.studentCount = 0;
        course.ratingScore = BigDecimal.ZERO;
        course.tags = tags;
        course.adminId = adminId;
        course.createTime = LocalDateTime.now();
        course.updateTime = LocalDateTime.now();
        return course;
    }

    public static Course reconstruct(CourseId id, String title, String subtitle, String description,
                                    String coverImage, BigDecimal price, CourseType courseType,
                                    CourseDifficulty difficulty, CourseStatus status,
                                    TeacherId teacherId, Integer totalDuration, Integer totalChapters,
                                    Integer totalSections, Integer studentCount, BigDecimal ratingScore,
                                    List<String> tags, UserId adminId, LocalDateTime createTime,
                                    LocalDateTime updateTime) {
        Course course = new Course();
        course.id = id;
        course.title = title;
        course.subtitle = subtitle;
        course.description = description;
        course.coverImage = coverImage;
        course.price = price;
        course.courseType = courseType;
        course.difficulty = difficulty;
        course.status = status;
        course.teacherId = teacherId;
        course.totalDuration = totalDuration;
        course.totalChapters = totalChapters;
        course.totalSections = totalSections;
        course.studentCount = studentCount;
        course.ratingScore = ratingScore;
        course.tags = tags;
        course.adminId = adminId;
        course.createTime = createTime;
        course.updateTime = updateTime;
        return course;
    }

    public void assignId(CourseId id) {
        if (this.id != null) {
            throw new IllegalStateException("课程ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void updateBasicInfo(String title, String subtitle, String description,
                               String coverImage, BigDecimal price, CourseType courseType,
                               CourseDifficulty difficulty, List<String> tags) {
        this.title = title;
        this.subtitle = subtitle;
        this.description = description;
        this.coverImage = coverImage;
        this.price = price;
        this.courseType = courseType;
        this.difficulty = difficulty;
        this.tags = tags;
        this.updateTime = LocalDateTime.now();
    }

    public void publish() {
        if (this.status == CourseStatus.PUBLISHED) {
            throw new IllegalStateException("课程已发布");
        }
        this.status = CourseStatus.PUBLISHED;
        this.updateTime = LocalDateTime.now();
    }

    public void takeOffline() {
        if (this.status != CourseStatus.PUBLISHED) {
            throw new IllegalStateException("只有已发布的课程才能下架");
        }
        this.status = CourseStatus.OFFLINE;
        this.updateTime = LocalDateTime.now();
    }

    public void updateRating(BigDecimal newRating) {
        this.ratingScore = newRating;
        this.updateTime = LocalDateTime.now();
    }

    public void incrementStudentCount() {
        this.studentCount++;
        this.updateTime = LocalDateTime.now();
    }

    public boolean isPublished() {
        return this.status == CourseStatus.PUBLISHED;
    }

    public boolean canBeEnrolled() {
        return this.status == CourseStatus.PUBLISHED;
    }

    public void updateStatistics(Integer totalChapters, Integer totalSections, Integer totalDuration) {
        this.totalChapters = totalChapters;
        this.totalSections = totalSections;
        this.totalDuration = totalDuration;
        this.updateTime = LocalDateTime.now();
    }
}
