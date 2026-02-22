// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_reading_note_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseReadingNoteDTO extends BaseResponseReadingNoteDTO {
  @override
  final int? code;
  @override
  final ReadingNoteDTO? data;
  @override
  final String? message;

  factory _$BaseResponseReadingNoteDTO([
    void Function(BaseResponseReadingNoteDTOBuilder)? updates,
  ]) => (BaseResponseReadingNoteDTOBuilder()..update(updates))._build();

  _$BaseResponseReadingNoteDTO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseReadingNoteDTO rebuild(
    void Function(BaseResponseReadingNoteDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseReadingNoteDTOBuilder toBuilder() =>
      BaseResponseReadingNoteDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseReadingNoteDTO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseReadingNoteDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseReadingNoteDTOBuilder
    implements
        Builder<BaseResponseReadingNoteDTO, BaseResponseReadingNoteDTOBuilder> {
  _$BaseResponseReadingNoteDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ReadingNoteDTOBuilder? _data;
  ReadingNoteDTOBuilder get data => _$this._data ??= ReadingNoteDTOBuilder();
  set data(ReadingNoteDTOBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseReadingNoteDTOBuilder() {
    BaseResponseReadingNoteDTO._defaults(this);
  }

  BaseResponseReadingNoteDTOBuilder get _$this {
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
  void replace(BaseResponseReadingNoteDTO other) {
    _$v = other as _$BaseResponseReadingNoteDTO;
  }

  @override
  void update(void Function(BaseResponseReadingNoteDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseReadingNoteDTO build() => _build();

  _$BaseResponseReadingNoteDTO _build() {
    _$BaseResponseReadingNoteDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseReadingNoteDTO._(
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
          r'BaseResponseReadingNoteDTO',
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
