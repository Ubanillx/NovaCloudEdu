// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_chapter_content_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseChapterContentDTO extends BaseResponseChapterContentDTO {
  @override
  final int? code;
  @override
  final ChapterContentDTO? data;
  @override
  final String? message;

  factory _$BaseResponseChapterContentDTO([
    void Function(BaseResponseChapterContentDTOBuilder)? updates,
  ]) => (BaseResponseChapterContentDTOBuilder()..update(updates))._build();

  _$BaseResponseChapterContentDTO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseChapterContentDTO rebuild(
    void Function(BaseResponseChapterContentDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseChapterContentDTOBuilder toBuilder() =>
      BaseResponseChapterContentDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseChapterContentDTO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseChapterContentDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseChapterContentDTOBuilder
    implements
        Builder<
          BaseResponseChapterContentDTO,
          BaseResponseChapterContentDTOBuilder
        > {
  _$BaseResponseChapterContentDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ChapterContentDTOBuilder? _data;
  ChapterContentDTOBuilder get data =>
      _$this._data ??= ChapterContentDTOBuilder();
  set data(ChapterContentDTOBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseChapterContentDTOBuilder() {
    BaseResponseChapterContentDTO._defaults(this);
  }

  BaseResponseChapterContentDTOBuilder get _$this {
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
  void replace(BaseResponseChapterContentDTO other) {
    _$v = other as _$BaseResponseChapterContentDTO;
  }

  @override
  void update(void Function(BaseResponseChapterContentDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseChapterContentDTO build() => _build();

  _$BaseResponseChapterContentDTO _build() {
    _$BaseResponseChapterContentDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseChapterContentDTO._(
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
          r'BaseResponseChapterContentDTO',
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
