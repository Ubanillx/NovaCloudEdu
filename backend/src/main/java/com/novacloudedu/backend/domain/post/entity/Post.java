package com.novacloudedu.backend.domain.post.entity;

import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.post.valueobject.PostType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 帖子实体
 */
@Getter
public class Post {

    private PostId id;
    private String title;
    private String content;
    private List<String> tags;
    private int thumbNum;
    private int favourNum;
    private int commentNum;
    private UserId userId;
    private String ipAddress;
    private PostType postType;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private boolean isDelete;

    private Post() {}

    /**
     * 创建帖子
     */
    public static Post create(String title, String content, List<String> tags, UserId userId, PostType postType) {
        Post post = new Post();
        post.title = title;
        post.content = content;
        post.tags = tags;
        post.userId = userId;
        post.postType = postType;
        post.thumbNum = 0;
        post.favourNum = 0;
        post.commentNum = 0;
        post.isDelete = false;
        post.createTime = LocalDateTime.now();
        post.updateTime = LocalDateTime.now();
        return post;
    }

    /**
     * 重建帖子（从数据库恢复）
     */
    public static Post reconstruct(PostId id, String title, String content, List<String> tags,
                                   int thumbNum, int favourNum, int commentNum, UserId userId,
                                   String ipAddress, PostType postType, LocalDateTime createTime,
                                   LocalDateTime updateTime, boolean isDelete) {
        Post post = new Post();
        post.id = id;
        post.title = title;
        post.content = content;
        post.tags = tags;
        post.thumbNum = thumbNum;
        post.favourNum = favourNum;
        post.commentNum = commentNum;
        post.userId = userId;
        post.ipAddress = ipAddress;
        post.postType = postType;
        post.createTime = createTime;
        post.updateTime = updateTime;
        post.isDelete = isDelete;
        return post;
    }

    /**
     * 分配ID
     */
    public void assignId(PostId id) {
        this.id = id;
    }

    /**
     * 设置IP地址
     */
    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    /**
     * 更新帖子
     */
    public void update(String title, String content, List<String> tags, PostType postType) {
        if (title != null && !title.isBlank()) {
            this.title = title;
        }
        if (content != null) {
            this.content = content;
        }
        if (tags != null) {
            this.tags = tags;
        }
        if (postType != null) {
            this.postType = postType;
        }
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 增加点赞数
     */
    public void incrementThumbNum() {
        this.thumbNum++;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 减少点赞数
     */
    public void decrementThumbNum() {
        if (this.thumbNum > 0) {
            this.thumbNum--;
        }
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 增加收藏数
     */
    public void incrementFavourNum() {
        this.favourNum++;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 减少收藏数
     */
    public void decrementFavourNum() {
        if (this.favourNum > 0) {
            this.favourNum--;
        }
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 增加评论数
     */
    public void incrementCommentNum() {
        this.commentNum++;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 减少评论数
     */
    public void decrementCommentNum() {
        if (this.commentNum > 0) {
            this.commentNum--;
        }
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 删除帖子
     */
    public void delete() {
        this.isDelete = true;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 检查是否是作者
     */
    public boolean isAuthor(UserId userId) {
        return this.userId.equals(userId);
    }
}
