// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_reading_bookmark_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseReadingBookmarkDTO extends BaseResponseReadingBookmarkDTO {
  @override
  final int? code;
  @override
  final ReadingBookmarkDTO? data;
  @override
  final String? message;

  factory _$BaseResponseReadingBookmarkDTO([
    void Function(BaseResponseReadingBookmarkDTOBuilder)? updates,
  ]) => (BaseResponseReadingBookmarkDTOBuilder()..update(updates))._build();

  _$BaseResponseReadingBookmarkDTO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseReadingBookmarkDTO rebuild(
    void Function(BaseResponseReadingBookmarkDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseReadingBookmarkDTOBuilder toBuilder() =>
      BaseResponseReadingBookmarkDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseReadingBookmarkDTO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseReadingBookmarkDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseReadingBookmarkDTOBuilder
    implements
        Builder<
          BaseResponseReadingBookmarkDTO,
          BaseResponseReadingBookmarkDTOBuilder
        > {
  _$BaseResponseReadingBookmarkDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ReadingBookmarkDTOBuilder? _data;
  ReadingBookmarkDTOBuilder get data =>
      _$this._data ??= ReadingBookmarkDTOBuilder();
  set data(ReadingBookmarkDTOBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseReadingBookmarkDTOBuilder() {
    BaseResponseReadingBookmarkDTO._defaults(this);
  }

  BaseResponseReadingBookmarkDTOBuilder get _$this {
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
  void replace(BaseResponseReadingBookmarkDTO other) {
    _$v = other as _$BaseResponseReadingBookmarkDTO;
  }

  @override
  void update(void Function(BaseResponseReadingBookmarkDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseReadingBookmarkDTO build() => _build();

  _$BaseResponseReadingBookmarkDTO _build() {
    _$BaseResponseReadingBookmarkDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseReadingBookmarkDTO._(
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
          r'BaseResponseReadingBookmarkDTO',
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
