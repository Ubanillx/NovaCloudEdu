// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_chapter_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseChapterResponse extends BaseResponseChapterResponse {
  @override
  final int? code;
  @override
  final ChapterResponse? data;
  @override
  final String? message;

  factory _$BaseResponseChapterResponse([
    void Function(BaseResponseChapterResponseBuilder)? updates,
  ]) => (BaseResponseChapterResponseBuilder()..update(updates))._build();

  _$BaseResponseChapterResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseChapterResponse rebuild(
    void Function(BaseResponseChapterResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseChapterResponseBuilder toBuilder() =>
      BaseResponseChapterResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseChapterResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseChapterResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseChapterResponseBuilder
    implements
        Builder<
          BaseResponseChapterResponse,
          BaseResponseChapterResponseBuilder
        > {
  _$BaseResponseChapterResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ChapterResponseBuilder? _data;
  ChapterResponseBuilder get data => _$this._data ??= ChapterResponseBuilder();
  set data(ChapterResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseChapterResponseBuilder() {
    BaseResponseChapterResponse._defaults(this);
  }

  BaseResponseChapterResponseBuilder get _$this {
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
  void replace(BaseResponseChapterResponse other) {
    _$v = other as _$BaseResponseChapterResponse;
  }

  @override
  void update(void Function(BaseResponseChapterResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseChapterResponse build() => _build();

  _$BaseResponseChapterResponse _build() {
    _$BaseResponseChapterResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseChapterResponse._(
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
          r'BaseResponseChapterResponse',
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
