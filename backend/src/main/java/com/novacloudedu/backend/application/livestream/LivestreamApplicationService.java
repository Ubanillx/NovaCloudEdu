package com.novacloudedu.backend.application.livestream;

import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.clazz.repository.ClassInfoRepository;
import com.novacloudedu.backend.domain.clazz.repository.ClassMemberRepository;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.livestream.entity.LiveRoom;
import com.novacloudedu.backend.domain.livestream.entity.LiveRoomMessage;
import com.novacloudedu.backend.domain.livestream.repository.LiveRoomMessageRepository;
import com.novacloudedu.backend.domain.livestream.repository.LiveRoomRepository;
import com.novacloudedu.backend.domain.livestream.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 直播应用服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class LivestreamApplicationService {

    private final LiveRoomRepository liveRoomRepository;
    private final LiveRoomMessageRepository messageRepository;
    private final ClassInfoRepository classInfoRepository;
    private final ClassMemberRepository classMemberRepository;

    /**
     * 创建公开直播间
     */
    @Transactional
    public LiveRoom createPublicRoom(String title, String description, String coverUrl, Long hostUserId) {
        LiveRoom room = LiveRoom.createPublic(title, description, coverUrl, UserId.of(hostUserId));
        return liveRoomRepository.save(room);
    }

    /**
     * 创建班级专属直播间
     */
    @Transactional
    public LiveRoom createClassRoom(String title, String description, String coverUrl,
                                     Long hostUserId, Long classId) {
        // 验证班级存在
        classInfoRepository.findById(ClassId.of(classId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "班级不存在"));
        LiveRoom room = LiveRoom.createClassOnly(title, description, coverUrl, UserId.of(hostUserId), classId);
        return liveRoomRepository.save(room);
    }

    /**
     * 获取直播间详情（含权限校验）
     */
    public LiveRoom getRoomDetail(Long roomId, Long currentUserId) {
        LiveRoom room = liveRoomRepository.findById(LiveRoomId.of(roomId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "直播间不存在"));
        checkViewPermission(room, currentUserId);
        return room;
    }

    /**
     * 获取推流信息（仅主播）
     */
    public LiveRoom startStreaming(Long roomId, Long currentUserId) {
        LiveRoom room = liveRoomRepository.findById(LiveRoomId.of(roomId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "直播间不存在"));
        if (!room.isHost(UserId.of(currentUserId))) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "仅主播可以获取推流信息");
        }
        return room;
    }

    /**
     * 手动结束直播（仅主播）
     */
    @Transactional
    public LiveRoom stopStreaming(Long roomId, Long currentUserId) {
        LiveRoom room = liveRoomRepository.findById(LiveRoomId.of(roomId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "直播间不存在"));
        if (!room.isHost(UserId.of(currentUserId))) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "仅主播可以结束直播");
        }
        room.endLive();
        liveRoomRepository.update(room);
        log.info("直播手动结束: roomId={}, hostUserId={}", roomId, currentUserId);
        return room;
    }

    /**
     * 删除直播间（主播或管理员）
     */
    @Transactional
    public void deleteRoom(Long roomId, Long currentUserId, String currentUserRole) {
        LiveRoom room = liveRoomRepository.findById(LiveRoomId.of(roomId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "直播间不存在"));
        if (!room.isHost(UserId.of(currentUserId)) && !"admin".equalsIgnoreCase(currentUserRole)) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "无权删除此直播间");
        }
        liveRoomRepository.delete(LiveRoomId.of(roomId));
        log.info("直播间已删除: roomId={}, operatorId={}", roomId, currentUserId);
    }

    /**
     * 直播间列表（公开）
     */
    public LiveRoomRepository.RoomPage listRooms(String status, int pageNum, int pageSize) {
        LiveRoomStatus roomStatus = status != null ? LiveRoomStatus.fromValue(status) : null;
        return liveRoomRepository.findAll(roomStatus, pageNum, pageSize);
    }

    /**
     * 按班级查询直播间
     */
    public LiveRoomRepository.RoomPage listRoomsByClass(Long classId, String status, int pageNum, int pageSize) {
        LiveRoomStatus roomStatus = status != null ? LiveRoomStatus.fromValue(status) : null;
        return liveRoomRepository.findByClassId(classId, roomStatus, pageNum, pageSize);
    }

    /**
     * 我的直播间
     */
    public LiveRoomRepository.RoomPage myRooms(Long hostUserId, int pageNum, int pageSize) {
        return liveRoomRepository.findByHostUserId(UserId.of(hostUserId), pageNum, pageSize);
    }

    /**
     * 获取聊天历史
     */
    public LiveRoomMessageRepository.MessagePage getChatHistory(Long roomId, Long currentUserId,
                                                                  int pageNum, int pageSize) {
        LiveRoom room = liveRoomRepository.findById(LiveRoomId.of(roomId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "直播间不存在"));
        checkViewPermission(room, currentUserId);
        return messageRepository.findByRoomId(LiveRoomId.of(roomId), pageNum, pageSize);
    }

    /**
     * 保存聊天消息
     */
    @Transactional
    public LiveRoomMessage saveChatMessage(Long roomId, Long senderId, String content) {
        LiveRoomMessage message = LiveRoomMessage.createUserMessage(
                LiveRoomId.of(roomId), UserId.of(senderId), content);
        return messageRepository.save(message);
    }

    /**
     * 保存系统消息
     */
    @Transactional
    public LiveRoomMessage saveSystemMessage(Long roomId, String content) {
        LiveRoomMessage message = LiveRoomMessage.createSystemMessage(LiveRoomId.of(roomId), content);
        return messageRepository.save(message);
    }

    // ========== SRS 回调处理 ==========

    /**
     * SRS on_publish 回调：推流鉴权
     */
    @Transactional
    public boolean onPublish(String streamKey) {
        return liveRoomRepository.findByStreamKey(StreamKey.of(streamKey))
                .map(room -> {
                    room.goLive();
                    liveRoomRepository.update(room);
                    log.info("直播开始: roomId={}, streamKey={}", room.getId().value(), streamKey);
                    return true;
                })
                .orElse(false);
    }

    /**
     * SRS on_unpublish 回调：推流结束
     */
    @Transactional
    public void onUnpublish(String streamKey) {
        liveRoomRepository.findByStreamKey(StreamKey.of(streamKey))
                .ifPresent(room -> {
                    if (room.isLive()) {
                        room.endLive();
                        liveRoomRepository.update(room);
                        log.info("直播结束: roomId={}, duration={}s", room.getId().value(), room.getDuration());
                    }
                });
    }

    /**
     * SRS on_play 回调：观众加入
     */
    @Transactional
    public void onPlay(String streamKey) {
        liveRoomRepository.findByStreamKey(StreamKey.of(streamKey))
                .ifPresent(room -> {
                    room.incrementViewer();
                    liveRoomRepository.update(room);
                });
    }

    /**
     * SRS on_stop 回调：观众离开
     */
    @Transactional
    public void onStop(String streamKey) {
        liveRoomRepository.findByStreamKey(StreamKey.of(streamKey))
                .ifPresent(room -> {
                    room.decrementViewer();
                    liveRoomRepository.update(room);
                });
    }

    // ========== 权限校验 ==========

    /**
     * 校验观看权限
     */
    private void checkViewPermission(LiveRoom room, Long currentUserId) {
        if (room.isClassOnly() && room.getClassId() != null) {
            // 班级专属：检查用户是否属于该班级（主播本人可看）
            if (!room.isHost(UserId.of(currentUserId))) {
                boolean isMember = classMemberRepository.findByClassIdAndUserId(
                        ClassId.of(room.getClassId()), UserId.of(currentUserId)).isPresent();
                if (!isMember) {
                    throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "仅班级成员可观看此直播");
                }
            }
        }
    }
}
