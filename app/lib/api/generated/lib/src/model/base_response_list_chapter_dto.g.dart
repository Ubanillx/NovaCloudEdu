// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_chapter_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListChapterDTO extends BaseResponseListChapterDTO {
  @override
  final int? code;
  @override
  final BuiltList<ChapterDTO>? data;
  @override
  final String? message;

  factory _$BaseResponseListChapterDTO([
    void Function(BaseResponseListChapterDTOBuilder)? updates,
  ]) => (BaseResponseListChapterDTOBuilder()..update(updates))._build();

  _$BaseResponseListChapterDTO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListChapterDTO rebuild(
    void Function(BaseResponseListChapterDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListChapterDTOBuilder toBuilder() =>
      BaseResponseListChapterDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListChapterDTO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListChapterDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListChapterDTOBuilder
    implements
        Builder<BaseResponseListChapterDTO, BaseResponseListChapterDTOBuilder> {
  _$BaseResponseListChapterDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ChapterDTO>? _data;
  ListBuilder<ChapterDTO> get data =>
      _$this._data ??= ListBuilder<ChapterDTO>();
  set data(ListBuilder<ChapterDTO>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListChapterDTOBuilder() {
    BaseResponseListChapterDTO._defaults(this);
  }

  BaseResponseListChapterDTOBuilder get _$this {
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
  void replace(BaseResponseListChapterDTO other) {
    _$v = other as _$BaseResponseListChapterDTO;
  }

  @override
  void update(void Function(BaseResponseListChapterDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListChapterDTO build() => _build();

  _$BaseResponseListChapterDTO _build() {
    _$BaseResponseListChapterDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListChapterDTO._(
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
          r'BaseResponseListChapterDTO',
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
