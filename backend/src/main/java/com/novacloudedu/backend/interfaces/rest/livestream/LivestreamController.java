package com.novacloudedu.backend.interfaces.rest.livestream;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.livestream.LivestreamApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.livestream.entity.LiveRoom;
import com.novacloudedu.backend.domain.livestream.repository.LiveRoomMessageRepository;
import com.novacloudedu.backend.domain.livestream.repository.LiveRoomRepository;
import com.novacloudedu.backend.interfaces.rest.livestream.dto.CreateLiveRoomRequest;
import com.novacloudedu.backend.interfaces.rest.livestream.dto.LiveRoomMessageResponse;
import com.novacloudedu.backend.interfaces.rest.livestream.dto.LiveRoomResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 直播间控制器
 */
@Tag(name = "直播管理", description = "直播间相关接口")
@RestController
@RequestMapping("/api/livestream")
@RequiredArgsConstructor
@Slf4j
public class LivestreamController {

    private final LivestreamApplicationService livestreamService;

    @Value("${srs.rtmp-url:rtmp://localhost:1935/live}")
    private String srsRtmpUrl;

    @Value("${srs.http-base:http://localhost:8085}")
    private String srsHttpBase;

    /**
     * 创建直播间
     */
    @Operation(summary = "创建直播间", description = "教师创建直播间，支持公开和班级专属")
    @PostMapping("/rooms")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<LiveRoomResponse> createRoom(@RequestBody CreateLiveRoomRequest request,
                                                      Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        LiveRoom room;
        if (request.getClassId() != null && "CLASS_ONLY".equalsIgnoreCase(request.getVisibility())) {
            room = livestreamService.createClassRoom(
                    request.getTitle(), request.getDescription(), request.getCoverUrl(),
                    userId, request.getClassId());
        } else {
            room = livestreamService.createPublicRoom(
                    request.getTitle(), request.getDescription(), request.getCoverUrl(), userId);
        }
        return ResultUtils.success(LiveRoomResponse.fromDomain(room));
    }

    /**
     * 直播间列表
     */
    @Operation(summary = "直播间列表", description = "分页获取直播间列表，可按状态筛选")
    @GetMapping("/rooms")
    public BaseResponse<Map<String, Object>> listRooms(
            @RequestParam(required = false) @Parameter(description = "状态: CREATED/LIVE/ENDED") String status,
            @RequestParam(required = false) @Parameter(description = "班级ID") Long classId,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {
        LiveRoomRepository.RoomPage roomPage;
        if (classId != null) {
            roomPage = livestreamService.listRoomsByClass(classId, status, page, size);
        } else {
            roomPage = livestreamService.listRooms(status, page, size);
        }
        List<LiveRoomResponse> rooms = roomPage.rooms().stream()
                .map(room -> {
                    LiveRoomResponse resp = LiveRoomResponse.fromDomain(room);
                    if (room.isLive()) {
                        resp.withPlayUrls(
                                srsHttpBase + "/live/" + room.getStreamKey().value() + ".flv",
                                srsHttpBase + "/live/" + room.getStreamKey().value() + ".m3u8");
                    }
                    return resp;
                })
                .toList();
        Map<String, Object> result = new HashMap<>();
        result.put("records", rooms);
        result.put("total", roomPage.total());
        result.put("pageNum", roomPage.pageNum());
        result.put("pageSize", roomPage.pageSize());
        return ResultUtils.success(result);
    }

    /**
     * 直播间详情
     */
    @Operation(summary = "直播间详情", description = "获取直播间详情，含播放地址")
    @GetMapping("/rooms/{id}")
    public BaseResponse<LiveRoomResponse> getRoomDetail(@PathVariable Long id,
                                                         Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        LiveRoom room = livestreamService.getRoomDetail(id, userId);
        LiveRoomResponse resp = LiveRoomResponse.fromDomain(room);
        if (room.isLive()) {
            resp.withPlayUrls(
                    srsHttpBase + "/live/" + room.getStreamKey().value() + ".flv",
                    srsHttpBase + "/live/" + room.getStreamKey().value() + ".m3u8");
        }
        return ResultUtils.success(resp);
    }

    /**
     * 获取推流信息
     */
    @Operation(summary = "获取推流信息", description = "主播获取推流地址和密钥")
    @PostMapping("/rooms/{id}/start")
    public BaseResponse<LiveRoomResponse> startStreaming(@PathVariable Long id,
                                                          Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        LiveRoom room = livestreamService.startStreaming(id, userId);
        LiveRoomResponse resp = LiveRoomResponse.fromDomain(room);
        resp.withStreamInfo(room.getStreamKey().value(), srsRtmpUrl);
        resp.withPlayUrls(
                srsHttpBase + "/live/" + room.getStreamKey().value() + ".flv",
                srsHttpBase + "/live/" + room.getStreamKey().value() + ".m3u8");
        return ResultUtils.success(resp);
    }

    /**
     * 手动结束直播
     */
    @Operation(summary = "结束直播", description = "主播手动结束直播")
    @PostMapping("/rooms/{id}/stop")
    public BaseResponse<LiveRoomResponse> stopStreaming(@PathVariable Long id,
                                                         Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        LiveRoom room = livestreamService.stopStreaming(id, userId);
        return ResultUtils.success(LiveRoomResponse.fromDomain(room));
    }

    /**
     * 删除直播间
     */
    @Operation(summary = "删除直播间", description = "主播或管理员删除直播间")
    @DeleteMapping("/rooms/{id}")
    public BaseResponse<Boolean> deleteRoom(@PathVariable Long id, Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        String role = authentication.getAuthorities().iterator().next().getAuthority().replace("ROLE_", "");
        livestreamService.deleteRoom(id, userId, role);
        return ResultUtils.success(true);
    }

    /**
     * 我的直播间
     */
    @Operation(summary = "我的直播间", description = "获取当前用户创建的直播间列表")
    @GetMapping("/rooms/my")
    public BaseResponse<Map<String, Object>> myRooms(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        LiveRoomRepository.RoomPage roomPage = livestreamService.myRooms(userId, page, size);
        List<LiveRoomResponse> rooms = roomPage.rooms().stream()
                .map(LiveRoomResponse::fromDomain)
                .toList();
        Map<String, Object> result = new HashMap<>();
        result.put("records", rooms);
        result.put("total", roomPage.total());
        result.put("pageNum", roomPage.pageNum());
        result.put("pageSize", roomPage.pageSize());
        return ResultUtils.success(result);
    }

    /**
     * 聊天历史
     */
    @Operation(summary = "直播间聊天历史", description = "分页获取直播间聊天消息")
    @GetMapping("/rooms/{id}/messages")
    public BaseResponse<Map<String, Object>> getChatHistory(
            @PathVariable Long id,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "50") int size,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        LiveRoomMessageRepository.MessagePage msgPage = livestreamService.getChatHistory(id, userId, page, size);
        List<LiveRoomMessageResponse> messages = msgPage.messages().stream()
                .map(LiveRoomMessageResponse::fromDomain)
                .toList();
        Map<String, Object> result = new HashMap<>();
        result.put("records", messages);
        result.put("total", msgPage.total());
        result.put("pageNum", msgPage.pageNum());
        result.put("pageSize", msgPage.pageSize());
        return ResultUtils.success(result);
    }
}
