import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

/// 帖子服务
class PostService {
  static final PostService _instance = PostService._internal();
  factory PostService() => _instance;
  PostService._internal();

  final DefaultApi _api = ApiClient.instance.defaultApi;

  /// 获取帖子列表（分页）
  Future<PostPageResponse?> getPostList({
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _api.getPostList(
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 根据类型获取帖子列表
  Future<PostPageResponse?> getPostListByType({
    required String postType,
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _api.getPostListByType(
        postType: postType,
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 搜索帖子（关键词搜索标题、内容）
  Future<PostPageResponse?> searchPosts({
    required String keyword,
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _api.searchPosts1(
        keyword: keyword,
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 根据标签搜索帖子
  Future<PostPageResponse?> searchPostsByTag({
    required String tag,
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _api.searchPostsByTag(
        tag: tag,
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取帖子详情
  Future<PostDetailResponse?> getPostDetail(int postId) async {
    try {
      final response = await _api.getPostDetail(postId: postId);
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 创建帖子
  Future<PostResponse?> createPost({
    required String title,
    required String content,
    List<String>? tags,
    String postType = 'normal',
  }) async {
    try {
      final response = await _api.createPost(
        createPostRequest: CreatePostRequest((b) => b
          ..title = title
          ..content = content
          ..tags.replace(tags ?? [])
          ..postType = postType),
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 更新帖子
  Future<bool> updatePost({
    required int postId,
    String? title,
    String? content,
    List<String>? tags,
    String? postType,
  }) async {
    try {
      final response = await _api.updatePost(
        postId: postId,
        updatePostRequest: UpdatePostRequest((b) {
          if (title != null) b.title = title;
          if (content != null) b.content = content;
          if (tags != null) b.tags.replace(tags);
          if (postType != null) b.postType = postType;
        }),
      );
      return response.data?.code == 0;
    } catch (e) {
      rethrow;
    }
  }

  /// 删除帖子
  Future<bool> deletePost(int postId) async {
    try {
      final response = await _api.deletePost(postId: postId);
      return response.data?.code == 0;
    } catch (e) {
      rethrow;
    }
  }

  /// 点赞/取消点赞
  Future<bool?> toggleThumb(int postId) async {
    try {
      final response = await _api.toggleThumb(postId: postId);
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 收藏/取消收藏
  Future<bool?> toggleFavour(int postId) async {
    try {
      final response = await _api.toggleFavour(postId: postId);
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取帖子评论列表
  Future<CommentPageResponse?> getPostComments({
    required int postId,
    int pageNum = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _api.getPostComments(
        postId: postId,
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 发表评论
  Future<CommentResponse?> createComment({
    required int postId,
    required String content,
  }) async {
    try {
      final response = await _api.createComment(
        postId: postId,
        createCommentRequest: CreateCommentRequest((b) => b..content = content),
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 删除评论
  Future<bool> deleteComment(int commentId) async {
    try {
      final response = await _api.deleteComment(commentId: commentId);
      return response.data?.code == 0;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取用户的帖子列表
  Future<List<PostResponse>?> getUserPosts(int targetUserId) async {
    try {
      final response = await _api.getUserPosts(targetUserId: targetUserId);
      return response.data?.data?.toList();
    } catch (e) {
      rethrow;
    }
  }

  /// 获取我收藏的帖子
  Future<PostPageResponse?> getMyFavourites({
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _api.getMyFavourites(
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取关注用户的帖子列表
  Future<PostPageResponse?> getFollowingPosts({
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _api.getFollowingPosts(
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取点赞排行榜（全部时间）
  Future<PostPageResponse?> getTopPosts({
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _api.getTopPosts(
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取点赞排行榜（指定天数内）
  Future<PostPageResponse?> getTopPostsByDays({
    int? days,
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _api.getTopPostsByDays(
        days: days,
        pageNum: pageNum,
        pageSize: pageSize,
      );
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 关注/取消关注用户
  Future<bool> toggleFollow(int targetUserId) async {
    try {
      // 先检查当前关注状态
      final currentStatus = await isFollowing(targetUserId);
      if (currentStatus == true) {
        // 已关注，调用取消关注接口
        await _api.unfollow(targetUserId: targetUserId);
        return false;
      } else {
        // 未关注，调用关注接口
        await _api.follow(targetUserId: targetUserId);
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 检查是否已关注用户
  Future<bool?> isFollowing(int targetUserId) async {
    try {
      final response = await _api.isFollowing(targetUserId: targetUserId);
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取用户公开信息（头像、昵称等）
  Future<UserPublicResponse?> getUserPublicInfo(int userId) async {
    try {
      final response = await _api.getUserPublicInfo(id: userId);
      return response.data?.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 批量获取用户公开信息（缓存优化）
  final Map<int, UserPublicResponse> _userInfoCache = {};
  
  Future<UserPublicResponse?> getCachedUserPublicInfo(int userId) async {
    if (_userInfoCache.containsKey(userId)) {
      return _userInfoCache[userId];
    }
    final info = await getUserPublicInfo(userId);
    if (info != null) {
      _userInfoCache[userId] = info;
    }
    return info;
  }

  void clearUserInfoCache() {
    _userInfoCache.clear();
  }
}
