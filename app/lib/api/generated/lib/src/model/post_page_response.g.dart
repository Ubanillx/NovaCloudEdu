// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PostPageResponse extends PostPageResponse {
  @override
  final BuiltList<PostResponse>? posts;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$PostPageResponse([
    void Function(PostPageResponseBuilder)? updates,
  ]) => (PostPageResponseBuilder()..update(updates))._build();

  _$PostPageResponse._({
    this.posts,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  PostPageResponse rebuild(void Function(PostPageResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PostPageResponseBuilder toBuilder() =>
      PostPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostPageResponse &&
        posts == other.posts &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, posts.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PostPageResponse')
          ..add('posts', posts)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class PostPageResponseBuilder
    implements Builder<PostPageResponse, PostPageResponseBuilder> {
  _$PostPageResponse? _$v;

  ListBuilder<PostResponse>? _posts;
  ListBuilder<PostResponse> get posts =>
      _$this._posts ??= ListBuilder<PostResponse>();
  set posts(ListBuilder<PostResponse>? posts) => _$this._posts = posts;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  PostPageResponseBuilder() {
    PostPageResponse._defaults(this);
  }

  PostPageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _posts = $v.posts?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PostPageResponse other) {
    _$v = other as _$PostPageResponse;
  }

  @override
  void update(void Function(PostPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PostPageResponse build() => _build();

  _$PostPageResponse _build() {
    _$PostPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$PostPageResponse._(
            posts: _posts?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'posts';
        _posts?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PostPageResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
