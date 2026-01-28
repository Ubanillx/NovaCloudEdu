// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_chapter_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListChapterResponse
    extends BaseResponseListChapterResponse {
  @override
  final int? code;
  @override
  final BuiltList<ChapterResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListChapterResponse([
    void Function(BaseResponseListChapterResponseBuilder)? updates,
  ]) => (BaseResponseListChapterResponseBuilder()..update(updates))._build();

  _$BaseResponseListChapterResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListChapterResponse rebuild(
    void Function(BaseResponseListChapterResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListChapterResponseBuilder toBuilder() =>
      BaseResponseListChapterResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListChapterResponse &&
        code == other.code &&
        data == other.data &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BaseResponseListChapterResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListChapterResponseBuilder
    implements
        Builder<
          BaseResponseListChapterResponse,
          BaseResponseListChapterResponseBuilder
        > {
  _$BaseResponseListChapterResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ChapterResponse>? _data;
  ListBuilder<ChapterResponse> get data =>
      _$this._data ??= ListBuilder<ChapterResponse>();
  set data(ListBuilder<ChapterResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListChapterResponseBuilder() {
    BaseResponseListChapterResponse._defaults(this);
  }

  BaseResponseListChapterResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _data = $v.data?.toBuilder();
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseResponseListChapterResponse other) {
    _$v = other as _$BaseResponseListChapterResponse;
  }

  @override
  void update(void Function(BaseResponseListChapterResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListChapterResponse build() => _build();

  _$BaseResponseListChapterResponse _build() {
    _$BaseResponseListChapterResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListChapterResponse._(
            code: code,
            data: _data?.build(),
            message: message,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BaseResponseListChapterResponse',
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
