package com.novacloudedu.backend.interfaces.rest.social;

import com.novacloudedu.backend.application.service.GroupChatApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.social.entity.GroupMessage;
import com.novacloudedu.backend.domain.social.repository.GroupMessageRepository;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.interfaces.rest.social.dto.response.GroupMessagePageResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 群聊消息 REST 控制器
 */
@RestController
@RequestMapping("/api/group-chat")
@RequiredArgsConstructor
@Tag(name = "群聊消息", description = "群聊历史消息获取、已读管理")
public class GroupChatController {

    private final GroupChatApplicationService groupChatService;
    private final UserRepository userRepository;

    @GetMapping("/{groupId}/messages")
    @Operation(summary = "获取群聊历史消息（分页）")
    public BaseResponse<GroupMessagePageResponse> getMessages(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "50") int pageSize) {

        GroupMessageRepository.MessagePage page = groupChatService.getMessages(groupId, userId, pageNum, pageSize);

        // 构建响应
        GroupMessagePageResponse response = new GroupMessagePageResponse();
        response.setTotal(page.total());
        response.setPageNum(page.pageNum());
        response.setPageSize(page.pageSize());
        response.setTotalPages(page.getTotalPages());

        // 批量获取发送者信息
        Map<Long, User> userCache = new HashMap<>();
        List<GroupMessagePageResponse.GroupMessageItem> items = page.messages().stream()
                .map(msg -> {
                    GroupMessagePageResponse.GroupMessageItem item = GroupMessagePageResponse.GroupMessageItem.from(msg);
                    if (msg.getSenderId() != null) {
                        User sender = userCache.computeIfAbsent(msg.getSenderId().value(),
                                id -> userRepository.findById(UserId.of(id)).orElse(null));
                        if (sender != null) {
                            item.setSenderName(sender.getUserName());
                            item.setSenderAvatar(sender.getUserAvatar());
                        }
                    }
                    return item;
                })
                .toList();
        response.setMessages(items);

        return ResultUtils.success(response);
    }

    @GetMapping("/{groupId}/messages/before")
    @Operation(summary = "获取群聊历史消息（游标分页，获取某消息之前的消息）")
    public BaseResponse<List<GroupMessagePageResponse.GroupMessageItem>> getMessagesBefore(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @RequestParam Long beforeMessageId,
            @RequestParam(defaultValue = "50") int limit) {

        List<GroupMessage> messages = groupChatService.getMessagesBefore(groupId, userId, beforeMessageId, limit);

        // 批量获取发送者信息
        Map<Long, User> userCache = new HashMap<>();
        List<GroupMessagePageResponse.GroupMessageItem> items = messages.stream()
                .map(msg -> {
                    GroupMessagePageResponse.GroupMessageItem item = GroupMessagePageResponse.GroupMessageItem.from(msg);
                    if (msg.getSenderId() != null) {
                        User sender = userCache.computeIfAbsent(msg.getSenderId().value(),
                                id -> userRepository.findById(UserId.of(id)).orElse(null));
                        if (sender != null) {
                            item.setSenderName(sender.getUserName());
                            item.setSenderAvatar(sender.getUserAvatar());
                        }
                    }
                    return item;
                })
                .toList();

        return ResultUtils.success(items);
    }

    @GetMapping("/{groupId}/messages/latest")
    @Operation(summary = "获取群最新消息")
    public BaseResponse<List<GroupMessagePageResponse.GroupMessageItem>> getLatestMessages(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @RequestParam(defaultValue = "50") int limit) {

        List<GroupMessage> messages = groupChatService.getLatestMessages(groupId, userId, limit);

        // 批量获取发送者信息
        Map<Long, User> userCache = new HashMap<>();
        List<GroupMessagePageResponse.GroupMessageItem> items = messages.stream()
                .map(msg -> {
                    GroupMessagePageResponse.GroupMessageItem item = GroupMessagePageResponse.GroupMessageItem.from(msg);
                    if (msg.getSenderId() != null) {
                        User sender = userCache.computeIfAbsent(msg.getSenderId().value(),
                                id -> userRepository.findById(UserId.of(id)).orElse(null));
                        if (sender != null) {
                            item.setSenderName(sender.getUserName());
                            item.setSenderAvatar(sender.getUserAvatar());
                        }
                    }
                    return item;
                })
                .toList();

        return ResultUtils.success(items);
    }

    @PostMapping("/{groupId}/messages/{messageId}/read")
    @Operation(summary = "标记消息已读")
    public BaseResponse<Void> markAsRead(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @PathVariable Long messageId) {

        groupChatService.markAsRead(groupId, userId, messageId);
        return ResultUtils.success(null);
    }

    @GetMapping("/{groupId}/unread/count")
    @Operation(summary = "获取群未读消息数")
    public BaseResponse<Integer> getUnreadCount(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId) {

        int count = groupChatService.getUnreadCount(groupId, userId);
        return ResultUtils.success(count);
    }

    @GetMapping("/messages/{messageId}/read-count")
    @Operation(summary = "获取消息已读人数")
    public BaseResponse<Integer> getReadCount(@PathVariable Long messageId) {
        int count = groupChatService.getReadCount(messageId);
        return ResultUtils.success(count);
    }

    @DeleteMapping("/{groupId}/messages/{messageId}")
    @Operation(summary = "删除消息")
    public BaseResponse<Void> deleteMessage(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @PathVariable Long messageId) {

        groupChatService.deleteMessage(groupId, userId, messageId);
        return ResultUtils.success(null);
    }
}
