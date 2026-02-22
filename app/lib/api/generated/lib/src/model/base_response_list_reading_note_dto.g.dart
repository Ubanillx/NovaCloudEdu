// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_reading_note_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListReadingNoteDTO extends BaseResponseListReadingNoteDTO {
  @override
  final int? code;
  @override
  final BuiltList<ReadingNoteDTO>? data;
  @override
  final String? message;

  factory _$BaseResponseListReadingNoteDTO([
    void Function(BaseResponseListReadingNoteDTOBuilder)? updates,
  ]) => (BaseResponseListReadingNoteDTOBuilder()..update(updates))._build();

  _$BaseResponseListReadingNoteDTO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListReadingNoteDTO rebuild(
    void Function(BaseResponseListReadingNoteDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListReadingNoteDTOBuilder toBuilder() =>
      BaseResponseListReadingNoteDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListReadingNoteDTO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListReadingNoteDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListReadingNoteDTOBuilder
    implements
        Builder<
          BaseResponseListReadingNoteDTO,
          BaseResponseListReadingNoteDTOBuilder
        > {
  _$BaseResponseListReadingNoteDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ReadingNoteDTO>? _data;
  ListBuilder<ReadingNoteDTO> get data =>
      _$this._data ??= ListBuilder<ReadingNoteDTO>();
  set data(ListBuilder<ReadingNoteDTO>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListReadingNoteDTOBuilder() {
    BaseResponseListReadingNoteDTO._defaults(this);
  }

  BaseResponseListReadingNoteDTOBuilder get _$this {
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
  void replace(BaseResponseListReadingNoteDTO other) {
    _$v = other as _$BaseResponseListReadingNoteDTO;
  }

  @override
  void update(void Function(BaseResponseListReadingNoteDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListReadingNoteDTO build() => _build();

  _$BaseResponseListReadingNoteDTO _build() {
    _$BaseResponseListReadingNoteDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListReadingNoteDTO._(
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
          r'BaseResponseListReadingNoteDTO',
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
