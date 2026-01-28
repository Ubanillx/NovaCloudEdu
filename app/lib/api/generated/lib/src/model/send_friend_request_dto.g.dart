// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_friend_request_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendFriendRequestDTO extends SendFriendRequestDTO {
  @override
  final int receiverId;
  @override
  final String? message;

  factory _$SendFriendRequestDTO([
    void Function(SendFriendRequestDTOBuilder)? updates,
  ]) => (SendFriendRequestDTOBuilder()..update(updates))._build();

  _$SendFriendRequestDTO._({required this.receiverId, this.message})
    : super._();
  @override
  SendFriendRequestDTO rebuild(
    void Function(SendFriendRequestDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SendFriendRequestDTOBuilder toBuilder() =>
      SendFriendRequestDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendFriendRequestDTO &&
        receiverId == other.receiverId &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendFriendRequestDTO')
          ..add('receiverId', receiverId)
          ..add('message', message))
        .toString();
  }
}

class SendFriendRequestDTOBuilder
    implements Builder<SendFriendRequestDTO, SendFriendRequestDTOBuilder> {
  _$SendFriendRequestDTO? _$v;

  int? _receiverId;
  int? get receiverId => _$this._receiverId;
  set receiverId(int? receiverId) => _$this._receiverId = receiverId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SendFriendRequestDTOBuilder() {
    SendFriendRequestDTO._defaults(this);
  }

  SendFriendRequestDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _receiverId = $v.receiverId;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendFriendRequestDTO other) {
    _$v = other as _$SendFriendRequestDTO;
  }

  @override
  void update(void Function(SendFriendRequestDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendFriendRequestDTO build() => _build();

  _$SendFriendRequestDTO _build() {
    final _$result =
        _$v ??
        _$SendFriendRequestDTO._(
          receiverId: BuiltValueNullFieldError.checkNotNull(
            receiverId,
            r'SendFriendRequestDTO',
            'receiverId',
          ),
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
