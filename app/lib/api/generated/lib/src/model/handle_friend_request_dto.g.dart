// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handle_friend_request_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HandleFriendRequestDTO extends HandleFriendRequestDTO {
  @override
  final int requestId;
  @override
  final bool accept;

  factory _$HandleFriendRequestDTO([
    void Function(HandleFriendRequestDTOBuilder)? updates,
  ]) => (HandleFriendRequestDTOBuilder()..update(updates))._build();

  _$HandleFriendRequestDTO._({required this.requestId, required this.accept})
    : super._();
  @override
  HandleFriendRequestDTO rebuild(
    void Function(HandleFriendRequestDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HandleFriendRequestDTOBuilder toBuilder() =>
      HandleFriendRequestDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HandleFriendRequestDTO &&
        requestId == other.requestId &&
        accept == other.accept;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, accept.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HandleFriendRequestDTO')
          ..add('requestId', requestId)
          ..add('accept', accept))
        .toString();
  }
}

class HandleFriendRequestDTOBuilder
    implements Builder<HandleFriendRequestDTO, HandleFriendRequestDTOBuilder> {
  _$HandleFriendRequestDTO? _$v;

  int? _requestId;
  int? get requestId => _$this._requestId;
  set requestId(int? requestId) => _$this._requestId = requestId;

  bool? _accept;
  bool? get accept => _$this._accept;
  set accept(bool? accept) => _$this._accept = accept;

  HandleFriendRequestDTOBuilder() {
    HandleFriendRequestDTO._defaults(this);
  }

  HandleFriendRequestDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _requestId = $v.requestId;
      _accept = $v.accept;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HandleFriendRequestDTO other) {
    _$v = other as _$HandleFriendRequestDTO;
  }

  @override
  void update(void Function(HandleFriendRequestDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HandleFriendRequestDTO build() => _build();

  _$HandleFriendRequestDTO _build() {
    final _$result =
        _$v ??
        _$HandleFriendRequestDTO._(
          requestId: BuiltValueNullFieldError.checkNotNull(
            requestId,
            r'HandleFriendRequestDTO',
            'requestId',
          ),
          accept: BuiltValueNullFieldError.checkNotNull(
            accept,
            r'HandleFriendRequestDTO',
            'accept',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
