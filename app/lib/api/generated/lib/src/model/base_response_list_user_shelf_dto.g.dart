// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_user_shelf_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListUserShelfDTO extends BaseResponseListUserShelfDTO {
  @override
  final int? code;
  @override
  final BuiltList<UserShelfDTO>? data;
  @override
  final String? message;

  factory _$BaseResponseListUserShelfDTO([
    void Function(BaseResponseListUserShelfDTOBuilder)? updates,
  ]) => (BaseResponseListUserShelfDTOBuilder()..update(updates))._build();

  _$BaseResponseListUserShelfDTO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListUserShelfDTO rebuild(
    void Function(BaseResponseListUserShelfDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListUserShelfDTOBuilder toBuilder() =>
      BaseResponseListUserShelfDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListUserShelfDTO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListUserShelfDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListUserShelfDTOBuilder
    implements
        Builder<
          BaseResponseListUserShelfDTO,
          BaseResponseListUserShelfDTOBuilder
        > {
  _$BaseResponseListUserShelfDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<UserShelfDTO>? _data;
  ListBuilder<UserShelfDTO> get data =>
      _$this._data ??= ListBuilder<UserShelfDTO>();
  set data(ListBuilder<UserShelfDTO>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListUserShelfDTOBuilder() {
    BaseResponseListUserShelfDTO._defaults(this);
  }

  BaseResponseListUserShelfDTOBuilder get _$this {
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
  void replace(BaseResponseListUserShelfDTO other) {
    _$v = other as _$BaseResponseListUserShelfDTO;
  }

  @override
  void update(void Function(BaseResponseListUserShelfDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListUserShelfDTO build() => _build();

  _$BaseResponseListUserShelfDTO _build() {
    _$BaseResponseListUserShelfDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListUserShelfDTO._(
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
          r'BaseResponseListUserShelfDTO',
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
