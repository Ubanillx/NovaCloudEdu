// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_group_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListGroupResponse extends BaseResponseListGroupResponse {
  @override
  final int? code;
  @override
  final BuiltList<GroupResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListGroupResponse([
    void Function(BaseResponseListGroupResponseBuilder)? updates,
  ]) => (BaseResponseListGroupResponseBuilder()..update(updates))._build();

  _$BaseResponseListGroupResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListGroupResponse rebuild(
    void Function(BaseResponseListGroupResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListGroupResponseBuilder toBuilder() =>
      BaseResponseListGroupResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListGroupResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListGroupResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListGroupResponseBuilder
    implements
        Builder<
          BaseResponseListGroupResponse,
          BaseResponseListGroupResponseBuilder
        > {
  _$BaseResponseListGroupResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<GroupResponse>? _data;
  ListBuilder<GroupResponse> get data =>
      _$this._data ??= ListBuilder<GroupResponse>();
  set data(ListBuilder<GroupResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListGroupResponseBuilder() {
    BaseResponseListGroupResponse._defaults(this);
  }

  BaseResponseListGroupResponseBuilder get _$this {
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
  void replace(BaseResponseListGroupResponse other) {
    _$v = other as _$BaseResponseListGroupResponse;
  }

  @override
  void update(void Function(BaseResponseListGroupResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListGroupResponse build() => _build();

  _$BaseResponseListGroupResponse _build() {
    _$BaseResponseListGroupResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListGroupResponse._(
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
          r'BaseResponseListGroupResponse',
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
