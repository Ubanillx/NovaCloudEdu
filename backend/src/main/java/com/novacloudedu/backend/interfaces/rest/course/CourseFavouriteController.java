package com.novacloudedu.backend.interfaces.rest.course;

import com.novacloudedu.backend.application.course.command.FavouriteCourseCommand;
import com.novacloudedu.backend.application.course.command.UnfavouriteCourseCommand;
import com.novacloudedu.backend.application.course.query.GetCourseFavouriteQuery;
import com.novacloudedu.backend.application.course.query.GetCourseQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.entity.CourseFavourite;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.course.assembler.CourseAssembler;
import com.novacloudedu.backend.interfaces.rest.course.dto.CourseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/course/favourite")
@RequiredArgsConstructor
@Tag(name = "课程收藏", description = "课程收藏相关接口")
public class CourseFavouriteController {

    private final FavouriteCourseCommand favouriteCommand;
    private final UnfavouriteCourseCommand unfavouriteCommand;
    private final GetCourseFavouriteQuery getFavouriteQuery;
    private final GetCourseQuery getCourseQuery;
    private final CourseAssembler courseAssembler;

    @PostMapping("/{courseId}")
    @Operation(summary = "收藏课程")
    public BaseResponse<Void> favouriteCourse(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                             Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        favouriteCommand.execute(UserId.of(userId), courseId);
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{courseId}")
    @Operation(summary = "取消收藏")
    public BaseResponse<Void> unfavouriteCourse(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                               Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        unfavouriteCommand.execute(UserId.of(userId), courseId);
        return ResultUtils.success(null);
    }

    @GetMapping("/my")
    @Operation(summary = "获取我的收藏列表")
    public BaseResponse<List<CourseResponse>> getMyFavourites(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size,
            Authentication authentication) {
        
        Long userId = Long.parseLong(authentication.getName());
        List<CourseFavourite> favourites = getFavouriteQuery.executeByUserId(UserId.of(userId), page, size);
        
        List<CourseResponse> responses = favourites.stream()
                .map(fav -> getCourseQuery.execute(fav.getCourseId().value())
                        .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR)))
                .map(courseAssembler::toCourseResponse)
                .collect(Collectors.toList());
        
        return ResultUtils.success(responses);
    }

    @GetMapping("/{courseId}/check")
    @Operation(summary = "检查是否已收藏")
    public BaseResponse<Boolean> checkFavourite(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                               Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        boolean isFavourite = getFavouriteQuery.isFavourite(UserId.of(userId), courseId);
        return ResultUtils.success(isFavourite);
    }

    @GetMapping("/{courseId}/count")
    @Operation(summary = "获取课程收藏数")
    public BaseResponse<Long> getFavouriteCount(@PathVariable @Parameter(description = "课程ID") Long courseId) {
        long count = getFavouriteQuery.countByCourseId(courseId);
        return ResultUtils.success(count);
    }
}
