// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_live_room_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseLiveRoomResponse extends BaseResponseLiveRoomResponse {
  @override
  final int? code;
  @override
  final LiveRoomResponse? data;
  @override
  final String? message;

  factory _$BaseResponseLiveRoomResponse([
    void Function(BaseResponseLiveRoomResponseBuilder)? updates,
  ]) => (BaseResponseLiveRoomResponseBuilder()..update(updates))._build();

  _$BaseResponseLiveRoomResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseLiveRoomResponse rebuild(
    void Function(BaseResponseLiveRoomResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseLiveRoomResponseBuilder toBuilder() =>
      BaseResponseLiveRoomResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseLiveRoomResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseLiveRoomResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseLiveRoomResponseBuilder
    implements
        Builder<
          BaseResponseLiveRoomResponse,
          BaseResponseLiveRoomResponseBuilder
        > {
  _$BaseResponseLiveRoomResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  LiveRoomResponseBuilder? _data;
  LiveRoomResponseBuilder get data =>
      _$this._data ??= LiveRoomResponseBuilder();
  set data(LiveRoomResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseLiveRoomResponseBuilder() {
    BaseResponseLiveRoomResponse._defaults(this);
  }

  BaseResponseLiveRoomResponseBuilder get _$this {
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
  void replace(BaseResponseLiveRoomResponse other) {
    _$v = other as _$BaseResponseLiveRoomResponse;
  }

  @override
  void update(void Function(BaseResponseLiveRoomResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseLiveRoomResponse build() => _build();

  _$BaseResponseLiveRoomResponse _build() {
    _$BaseResponseLiveRoomResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseLiveRoomResponse._(
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
          r'BaseResponseLiveRoomResponse',
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
