package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.course.command.*;
import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.entity.CourseFavourite;
import com.novacloudedu.backend.domain.course.entity.CourseReview;
import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.course.repository.CourseChapterRepository;
import com.novacloudedu.backend.domain.course.repository.CourseFavouriteRepository;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.repository.CourseReviewRepository;
import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.*;
import com.novacloudedu.backend.domain.teacher.repository.TeacherRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

/**
 * 课程应用服务
 * 负责课程、章节、小节的创建、更新、删除、发布等用例编排
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class CourseApplicationService {

    private final CourseRepository courseRepository;
    private final CourseChapterRepository chapterRepository;
    private final CourseSectionRepository sectionRepository;
    private final TeacherRepository teacherRepository;
    private final CourseReviewRepository reviewRepository;
    private final CourseFavouriteRepository favouriteRepository;

    // ==================== 课程管理 ====================

    /**
     * 创建课程
     */
    @Transactional
    public Long createCourse(CreateCourseCommand command, UserId adminId) {
        // 验证讲师存在
        teacherRepository.findById(TeacherId.of(command.teacherId()))
                .orElseThrow(() -> new BusinessException(40400, "讲师不存在"));

        Course course = Course.create(
                command.title(), command.subtitle(), command.description(),
                command.coverImage(), command.price(), command.courseType(),
                command.difficulty(), TeacherId.of(command.teacherId()),
                command.tags(), adminId
        );

        courseRepository.save(course);
        log.info("课程创建成功: courseId={}, title={}", course.getId().value(), command.title());
        return course.getId().value();
    }

    /**
     * 更新课程
     */
    @Transactional
    public void updateCourse(UpdateCourseCommand command) {
        Course course = courseRepository.findById(CourseId.of(command.courseId()))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        course.updateBasicInfo(
                command.title(), command.subtitle(), command.description(),
                command.coverImage(), command.price(), command.courseType(),
                command.difficulty(), command.tags()
        );

        courseRepository.save(course);
        log.info("课程更新成功: courseId={}", command.courseId());
    }

    /**
     * 发布课程
     */
    @Transactional
    public void publishCourse(Long courseId) {
        Course course = courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        course.publish();
        courseRepository.save(course);
        log.info("课程发布成功: courseId={}", courseId);
    }

    /**
     * 下架课程
     */
    @Transactional
    public void takeOfflineCourse(Long courseId) {
        Course course = courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        course.takeOffline();
        courseRepository.save(course);
        log.info("课程下架成功: courseId={}", courseId);
    }

    /**
     * 删除课程
     */
    @Transactional
    public void deleteCourse(Long courseId) {
        courseRepository.deleteById(CourseId.of(courseId));
        log.info("课程删除成功: courseId={}", courseId);
    }

    /**
     * 重新计算并更新课程统计信息（章节数、小节数、总时长）
     */
    @Transactional
    public void refreshCourseStatistics(Long courseId) {
        Course course = courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        long chapterCount = chapterRepository.countByCourseId(CourseId.of(courseId));
        long sectionCount = sectionRepository.countByCourseId(CourseId.of(courseId));
        int totalDuration = sectionRepository.sumDurationByCourseId(CourseId.of(courseId));

        course.updateStatistics((int) chapterCount, (int) sectionCount, totalDuration / 60);
        courseRepository.save(course);
        log.info("课程统计更新成功: courseId={}", courseId);
    }

    // ==================== 章节管理 ====================

    /**
     * 创建章节
     */
    @Transactional
    public Long createChapter(CreateChapterCommand command, UserId adminId) {
        // 验证课程存在
        courseRepository.findById(CourseId.of(command.courseId()))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        CourseChapter chapter = CourseChapter.create(
                CourseId.of(command.courseId()),
                command.title(), command.description(),
                command.sort(), adminId
        );

        chapterRepository.save(chapter);
        log.info("章节创建成功: chapterId={}, courseId={}", chapter.getId().value(), command.courseId());
        return chapter.getId().value();
    }

    /**
     * 更新章节
     */
    @Transactional
    public void updateChapter(UpdateChapterCommand command) {
        CourseChapter chapter = chapterRepository.findById(ChapterId.of(command.chapterId()))
                .orElseThrow(() -> new BusinessException(40400, "章节不存在"));

        chapter.updateInfo(command.title(), command.description(), command.sort());
        chapterRepository.save(chapter);
        log.info("章节更新成功: chapterId={}", command.chapterId());
    }

    /**
     * 删除章节（同时删除关联小节）
     */
    @Transactional
    public void deleteChapter(Long chapterId) {
        ChapterId id = ChapterId.of(chapterId);
        sectionRepository.deleteByChapterId(id);
        chapterRepository.deleteById(id);
        log.info("章节删除成功: chapterId={}", chapterId);
    }

    // ==================== 小节管理 ====================

    /**
     * 创建小节
     */
    @Transactional
    public Long createSection(CreateSectionCommand command, UserId adminId) {
        // 验证章节存在
        chapterRepository.findById(ChapterId.of(command.chapterId()))
                .orElseThrow(() -> new BusinessException(40400, "章节不存在"));

        CourseSection section = CourseSection.create(
                CourseId.of(command.courseId()),
                ChapterId.of(command.chapterId()),
                command.title(), command.description(),
                command.videoUrl(), command.duration(),
                command.sort(), command.isFree(),
                command.resourceUrl(), adminId
        );

        sectionRepository.save(section);
        log.info("小节创建成功: sectionId={}, chapterId={}", section.getId().value(), command.chapterId());
        return section.getId().value();
    }

    /**
     * 更新小节
     */
    @Transactional
    public void updateSection(UpdateSectionCommand command) {
        CourseSection section = sectionRepository.findById(SectionId.of(command.sectionId()))
                .orElseThrow(() -> new BusinessException(40400, "小节不存在"));

        section.updateInfo(
                command.title(), command.description(),
                command.videoUrl(), command.duration(),
                command.sort(), command.isFree(),
                command.resourceUrl()
        );

        sectionRepository.save(section);
        log.info("小节更新成功: sectionId={}", command.sectionId());
    }

    /**
     * 删除小节
     */
    @Transactional
    public void deleteSection(Long sectionId) {
        sectionRepository.deleteById(SectionId.of(sectionId));
        log.info("小节删除成功: sectionId={}", sectionId);
    }

    // ==================== 课程评价 ====================

    /**
     * 评价课程
     */
    @Transactional
    public Long reviewCourse(ReviewCourseCommand command, UserId userId) {
        CourseId courseIdVo = CourseId.of(command.courseId());
        Course course = courseRepository.findById(courseIdVo)
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        if (reviewRepository.existsByUserIdAndCourseId(userId, courseIdVo)) {
            throw new BusinessException(40331, "已评价过该课程");
        }

        CourseReview review = CourseReview.create(userId, courseIdVo, command.rating());
        reviewRepository.save(review);

        BigDecimal avgRating = reviewRepository.calculateAverageRating(courseIdVo);
        course.updateRating(avgRating);
        courseRepository.save(course);

        log.info("课程评价成功: courseId={}, userId={}", command.courseId(), userId.value());
        return review.getId();
    }

    /**
     * 更新评价
     */
    @Transactional
    public void updateReview(UpdateReviewCommand command) {
        CourseReview review = reviewRepository.findById(command.reviewId())
                .orElseThrow(() -> new BusinessException(40400, "评价不存在"));

        review.updateRating(command.newRating());
        reviewRepository.save(review);

        BigDecimal avgRating = reviewRepository.calculateAverageRating(review.getCourseId());
        Course course = courseRepository.findById(review.getCourseId())
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));
        course.updateRating(avgRating);
        courseRepository.save(course);

        log.info("评价更新成功: reviewId={}", command.reviewId());
    }

    // ==================== 课程收藏 ====================

    /**
     * 收藏课程
     */
    @Transactional
    public void favouriteCourse(Long courseId, UserId userId) {
        CourseId courseIdVo = CourseId.of(courseId);
        courseRepository.findById(courseIdVo)
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        if (favouriteRepository.existsByUserIdAndCourseId(userId, courseIdVo)) {
            throw new BusinessException(40330, "已收藏该课程");
        }

        CourseFavourite favourite = CourseFavourite.create(userId, courseIdVo);
        favouriteRepository.save(favourite);
        log.info("收藏课程成功: courseId={}, userId={}", courseId, userId.value());
    }

    /**
     * 取消收藏
     */
    @Transactional
    public void unfavouriteCourse(Long courseId, UserId userId) {
        favouriteRepository.deleteByUserIdAndCourseId(userId, CourseId.of(courseId));
        log.info("取消收藏成功: courseId={}, userId={}", courseId, userId.value());
    }
}
