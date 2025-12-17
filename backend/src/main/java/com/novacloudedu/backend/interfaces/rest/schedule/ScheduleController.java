package com.novacloudedu.backend.interfaces.rest.schedule;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.schedule.command.*;
import com.novacloudedu.backend.application.schedule.query.GetClassScheduleQuery;
import com.novacloudedu.backend.application.schedule.query.GetTeacherScheduleQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.application.schedule.query.GetMyScheduleQuery;
import com.novacloudedu.backend.interfaces.rest.schedule.assembler.ScheduleAssembler;
import com.novacloudedu.backend.interfaces.rest.schedule.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.schedule.dto.response.ClassScheduleItemResponse;
import com.novacloudedu.backend.interfaces.rest.schedule.dto.response.ScheduleResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "课程表管理", description = "课程表相关接口")
@RestController
@RequestMapping("/api/schedule")
@RequiredArgsConstructor
public class ScheduleController {

    private final CreateScheduleSettingCommand createScheduleSettingCommand;
    private final UpdateScheduleSettingCommand updateScheduleSettingCommand;
    private final ActivateScheduleSettingCommand activateScheduleSettingCommand;
    private final AddScheduleItemCommand addScheduleItemCommand;
    private final UpdateScheduleItemCommand updateScheduleItemCommand;
    private final DeleteScheduleItemCommand deleteScheduleItemCommand;
    private final GetClassScheduleQuery getClassScheduleQuery;
    private final GetTeacherScheduleQuery getTeacherScheduleQuery;
    private final GetMyScheduleQuery getMyScheduleQuery;
    private final ScheduleAssembler scheduleAssembler;

    // ==================== Setting Management ====================

    @Operation(summary = "创建课表配置", description = "管理员/教师创建班级课表配置")
    @PostMapping("/setting")
    @AuthCheck(mustRole = "admin") // Assuming admin for now, or could allow teacher
    public BaseResponse<Long> createSetting(@RequestBody @Valid CreateScheduleSettingRequest request) {
        Long id = createScheduleSettingCommand.execute(
                request.getClassId(),
                request.getSemester(),
                request.getStartDate(),
                request.getTotalWeeks(),
                request.getDaysPerWeek(),
                request.getSectionsPerDay(),
                request.getTimeConfig()
        );
        return ResultUtils.success(id);
    }

    @Operation(summary = "更新课表配置", description = "更新课表基础配置")
    @PutMapping("/setting/{id}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> updateSetting(@PathVariable Long id, @RequestBody @Valid UpdateScheduleSettingRequest request) {
        updateScheduleSettingCommand.execute(
                id,
                request.getSemester(),
                request.getStartDate(),
                request.getTotalWeeks(),
                request.getDaysPerWeek(),
                request.getSectionsPerDay(),
                request.getTimeConfig()
        );
        return ResultUtils.success(true);
    }

    @Operation(summary = "激活课表配置", description = "将某学期配置设为当前激活")
    @PostMapping("/setting/{id}/activate")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> activateSetting(@PathVariable Long id) {
        activateScheduleSettingCommand.execute(id);
        return ResultUtils.success(true);
    }

    // ==================== Item Management ====================

    @Operation(summary = "添加课程项", description = "向课表中添加课程")
    @PostMapping("/item")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Long> addItem(@RequestBody @Valid AddScheduleItemRequest request) {
        Long id = addScheduleItemCommand.execute(
                request.getSettingId(),
                request.getCourseType(),
                request.getCourseName(),
                request.getTeacherName(),
                request.getLocation(),
                request.getCourseId(),
                request.getTeacherId(),
                request.getDayOfWeek(),
                request.getStartSection(),
                request.getEndSection(),
                request.getStartWeek(),
                request.getEndWeek(),
                request.getWeekType(),
                request.getColor(),
                request.getRemark()
        );
        return ResultUtils.success(id);
    }

    @Operation(summary = "更新课程项", description = "更新课程项信息")
    @PutMapping("/item/{id}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> updateItem(@PathVariable Long id, @RequestBody @Valid UpdateScheduleItemRequest request) {
        updateScheduleItemCommand.execute(
                id,
                request.getLocation(),
                request.getDayOfWeek(),
                request.getStartSection(),
                request.getEndSection(),
                request.getStartWeek(),
                request.getEndWeek(),
                request.getWeekType(),
                request.getColor(),
                request.getRemark(),
                request.getCourseName(),
                request.getTeacherName()
        );
        return ResultUtils.success(true);
    }

    @Operation(summary = "删除课程项", description = "删除课程项")
    @DeleteMapping("/item/{id}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> deleteItem(@PathVariable Long id) {
        deleteScheduleItemCommand.execute(id);
        return ResultUtils.success(true);
    }

    // ==================== Query ====================

    @Operation(summary = "获取我的课表", description = "获取当前登录用户的完整课表（包括班级课表、执教课表、个人日程）")
    @GetMapping("/my")
    public BaseResponse<List<ClassScheduleItemResponse>> getMySchedule(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        var items = getMyScheduleQuery.execute(userId);
        return ResultUtils.success(scheduleAssembler.toItemResponses(items));
    }
    
    @Operation(summary = "获取特定配置的课表", description = "根据配置ID获取课表预览")
    @GetMapping("/setting/{settingId}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<ScheduleResponse> getScheduleBySetting(@PathVariable Long settingId) {
        var dto = getClassScheduleQuery.executeBySettingId(settingId);
        return ResultUtils.success(scheduleAssembler.toScheduleResponse(dto));
    }
}
