package com.novacloudedu.backend.interfaces.rest.social.assembler;

import com.novacloudedu.backend.application.social.command.DeleteFriendCommand;
import com.novacloudedu.backend.application.social.command.HandleFriendRequestCommand;
import com.novacloudedu.backend.application.social.command.SendFriendRequestCommand;
import com.novacloudedu.backend.application.social.query.FriendListQuery;
import com.novacloudedu.backend.application.social.query.FriendRequestListQuery;
import com.novacloudedu.backend.application.social.query.SearchUserQuery;
import com.novacloudedu.backend.domain.social.entity.FriendRelationship;
import com.novacloudedu.backend.domain.social.entity.FriendRequest;
import com.novacloudedu.backend.domain.social.repository.FriendRelationshipRepository.FriendPage;
import com.novacloudedu.backend.domain.social.repository.FriendRequestRepository.FriendRequestPage;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository.UserPage;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.interfaces.rest.social.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.social.dto.response.*;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.function.Function;

/**
 * 好友模块装配器
 */
@Component
public class FriendAssembler {

    // ==================== Command 转换 ====================

    public SendFriendRequestCommand toSendCommand(SendFriendRequestDTO dto) {
        return new SendFriendRequestCommand(dto.receiverId(), dto.message());
    }

    public HandleFriendRequestCommand toHandleCommand(HandleFriendRequestDTO dto) {
        return new HandleFriendRequestCommand(dto.requestId(), dto.accept());
    }

    public DeleteFriendCommand toDeleteCommand(Long friendId) {
        return new DeleteFriendCommand(friendId);
    }

    // ==================== Query 转换 ====================

    public SearchUserQuery toSearchQuery(SearchUserRequestDTO dto) {
        return SearchUserQuery.of(dto.keyword(), dto.getPageNum(), dto.getPageSize());
    }

    public FriendListQuery toFriendListQuery(FriendListRequestDTO dto) {
        return FriendListQuery.of(dto.getPageNum(), dto.getPageSize());
    }

    public FriendRequestListQuery toRequestListQuery(FriendRequestListDTO dto) {
        return FriendRequestListQuery.of(dto.status(), dto.getPageNum(), dto.getPageSize());
    }

    // ==================== Response 转换 ====================

    public SearchUserPageResponse toSearchUserPageResponse(UserPage page, 
                                                            Function<Long, Boolean> isFriendChecker,
                                                            Function<Long, Boolean> hasPendingRequestChecker) {
        List<SearchUserResponse> records = page.users().stream()
                .map(user -> toSearchUserResponse(user, 
                        isFriendChecker.apply(user.getId().value()),
                        hasPendingRequestChecker.apply(user.getId().value())))
                .toList();

        return new SearchUserPageResponse(
                records,
                page.total(),
                page.pageNum(),
                page.pageSize(),
                page.getTotalPages()
        );
    }

    public SearchUserResponse toSearchUserResponse(User user, boolean isFriend, boolean hasPendingRequest) {
        return new SearchUserResponse(
                user.getId().value(),
                user.getAccount().value(),
                user.getUserName(),
                user.getUserAvatar(),
                user.getUserProfile(),
                isFriend,
                hasPendingRequest
        );
    }

    public FriendRequestPageResponse toRequestPageResponse(FriendRequestPage page, Map<Long, User> userMap) {
        List<FriendRequestResponse> records = page.requests().stream()
                .map(request -> toRequestResponse(request, userMap))
                .toList();

        return new FriendRequestPageResponse(
                records,
                page.total(),
                page.pageNum(),
                page.pageSize(),
                page.getTotalPages()
        );
    }

    public FriendRequestResponse toRequestResponse(FriendRequest request, Map<Long, User> userMap) {
        User sender = userMap.get(request.getSenderId().value());
        User receiver = userMap.get(request.getReceiverId().value());

        return new FriendRequestResponse(
                request.getId().value(),
                request.getSenderId().value(),
                sender != null ? sender.getUserName() : null,
                sender != null ? sender.getUserAvatar() : null,
                request.getReceiverId().value(),
                receiver != null ? receiver.getUserName() : null,
                receiver != null ? receiver.getUserAvatar() : null,
                request.getStatus().getValue(),
                request.getMessage(),
                request.getCreateTime()
        );
    }

    public FriendPageResponse toFriendPageResponse(FriendPage page, UserId currentUserId, Map<Long, User> userMap) {
        List<FriendResponse> records = page.friends().stream()
                .map(relationship -> toFriendResponse(relationship, currentUserId, userMap))
                .toList();

        return new FriendPageResponse(
                records,
                page.total(),
                page.pageNum(),
                page.pageSize(),
                page.getTotalPages()
        );
    }

    public FriendResponse toFriendResponse(FriendRelationship relationship, UserId currentUserId, Map<Long, User> userMap) {
        UserId friendUserId = relationship.getOtherUserId(currentUserId);
        User friend = userMap.get(friendUserId.value());

        return new FriendResponse(
                friendUserId.value(),
                friend != null ? friend.getAccount().value() : null,
                friend != null ? friend.getUserName() : null,
                friend != null ? friend.getUserAvatar() : null,
                friend != null ? friend.getUserProfile() : null,
                relationship.getCreateTime()
        );
    }

    public List<FriendResponse> toFriendResponseList(List<User> users, Map<Long, FriendRelationship> relationshipMap) {
        return users.stream()
                .map(user -> {
                    FriendRelationship relationship = relationshipMap.get(user.getId().value());
                    return new FriendResponse(
                            user.getId().value(),
                            user.getAccount().value(),
                            user.getUserName(),
                            user.getUserAvatar(),
                            user.getUserProfile(),
                            relationship != null ? relationship.getCreateTime() : null
                    );
                })
                .toList();
    }
}
