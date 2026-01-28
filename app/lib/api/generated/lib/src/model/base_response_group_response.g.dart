// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_group_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseGroupResponse extends BaseResponseGroupResponse {
  @override
  final int? code;
  @override
  final GroupResponse? data;
  @override
  final String? message;

  factory _$BaseResponseGroupResponse([
    void Function(BaseResponseGroupResponseBuilder)? updates,
  ]) => (BaseResponseGroupResponseBuilder()..update(updates))._build();

  _$BaseResponseGroupResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseGroupResponse rebuild(
    void Function(BaseResponseGroupResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseGroupResponseBuilder toBuilder() =>
      BaseResponseGroupResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseGroupResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseGroupResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseGroupResponseBuilder
    implements
        Builder<BaseResponseGroupResponse, BaseResponseGroupResponseBuilder> {
  _$BaseResponseGroupResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  GroupResponseBuilder? _data;
  GroupResponseBuilder get data => _$this._data ??= GroupResponseBuilder();
  set data(GroupResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseGroupResponseBuilder() {
    BaseResponseGroupResponse._defaults(this);
  }

  BaseResponseGroupResponseBuilder get _$this {
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
  void replace(BaseResponseGroupResponse other) {
    _$v = other as _$BaseResponseGroupResponse;
  }

  @override
  void update(void Function(BaseResponseGroupResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseGroupResponse build() => _build();

  _$BaseResponseGroupResponse _build() {
    _$BaseResponseGroupResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseGroupResponse._(
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
          r'BaseResponseGroupResponse',
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
