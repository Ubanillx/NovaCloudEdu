// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_reading_bookmark_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListReadingBookmarkDTO
    extends BaseResponseListReadingBookmarkDTO {
  @override
  final int? code;
  @override
  final BuiltList<ReadingBookmarkDTO>? data;
  @override
  final String? message;

  factory _$BaseResponseListReadingBookmarkDTO([
    void Function(BaseResponseListReadingBookmarkDTOBuilder)? updates,
  ]) => (BaseResponseListReadingBookmarkDTOBuilder()..update(updates))._build();

  _$BaseResponseListReadingBookmarkDTO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListReadingBookmarkDTO rebuild(
    void Function(BaseResponseListReadingBookmarkDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListReadingBookmarkDTOBuilder toBuilder() =>
      BaseResponseListReadingBookmarkDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListReadingBookmarkDTO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListReadingBookmarkDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListReadingBookmarkDTOBuilder
    implements
        Builder<
          BaseResponseListReadingBookmarkDTO,
          BaseResponseListReadingBookmarkDTOBuilder
        > {
  _$BaseResponseListReadingBookmarkDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ReadingBookmarkDTO>? _data;
  ListBuilder<ReadingBookmarkDTO> get data =>
      _$this._data ??= ListBuilder<ReadingBookmarkDTO>();
  set data(ListBuilder<ReadingBookmarkDTO>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListReadingBookmarkDTOBuilder() {
    BaseResponseListReadingBookmarkDTO._defaults(this);
  }

  BaseResponseListReadingBookmarkDTOBuilder get _$this {
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
  void replace(BaseResponseListReadingBookmarkDTO other) {
    _$v = other as _$BaseResponseListReadingBookmarkDTO;
  }

  @override
  void update(
    void Function(BaseResponseListReadingBookmarkDTOBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListReadingBookmarkDTO build() => _build();

  _$BaseResponseListReadingBookmarkDTO _build() {
    _$BaseResponseListReadingBookmarkDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListReadingBookmarkDTO._(
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
          r'BaseResponseListReadingBookmarkDTO',
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
