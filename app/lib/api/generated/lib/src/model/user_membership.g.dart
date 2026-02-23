// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_membership.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserMembershipStatusEnum _$userMembershipStatusEnum_PENDING =
    const UserMembershipStatusEnum._('PENDING');
const UserMembershipStatusEnum _$userMembershipStatusEnum_ACTIVE =
    const UserMembershipStatusEnum._('ACTIVE');
const UserMembershipStatusEnum _$userMembershipStatusEnum_EXPIRED =
    const UserMembershipStatusEnum._('EXPIRED');
const UserMembershipStatusEnum _$userMembershipStatusEnum_CANCELLED =
    const UserMembershipStatusEnum._('CANCELLED');

UserMembershipStatusEnum _$userMembershipStatusEnumValueOf(String name) {
  switch (name) {
    case 'PENDING':
      return _$userMembershipStatusEnum_PENDING;
    case 'ACTIVE':
      return _$userMembershipStatusEnum_ACTIVE;
    case 'EXPIRED':
      return _$userMembershipStatusEnum_EXPIRED;
    case 'CANCELLED':
      return _$userMembershipStatusEnum_CANCELLED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserMembershipStatusEnum> _$userMembershipStatusEnumValues =
    BuiltSet<UserMembershipStatusEnum>(const <UserMembershipStatusEnum>[
      _$userMembershipStatusEnum_PENDING,
      _$userMembershipStatusEnum_ACTIVE,
      _$userMembershipStatusEnum_EXPIRED,
      _$userMembershipStatusEnum_CANCELLED,
    ]);

Serializer<UserMembershipStatusEnum> _$userMembershipStatusEnumSerializer =
    _$UserMembershipStatusEnumSerializer();

class _$UserMembershipStatusEnumSerializer
    implements PrimitiveSerializer<UserMembershipStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'ACTIVE': 'ACTIVE',
    'EXPIRED': 'EXPIRED',
    'CANCELLED': 'CANCELLED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'ACTIVE': 'ACTIVE',
    'EXPIRED': 'EXPIRED',
    'CANCELLED': 'CANCELLED',
  };

  @override
  final Iterable<Type> types = const <Type>[UserMembershipStatusEnum];
  @override
  final String wireName = 'UserMembershipStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    UserMembershipStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UserMembershipStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UserMembershipStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UserMembership extends UserMembership {
  @override
  final int? id;
  @override
  final UserId? userId;
  @override
  final int? planId;
  @override
  final String? orderNo;
  @override
  final DateTime? startTime;
  @override
  final DateTime? expireTime;
  @override
  final UserMembershipStatusEnum? status;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;
  @override
  final bool? expired;
  @override
  final bool? delete;
  @override
  final bool? active;

  factory _$UserMembership([void Function(UserMembershipBuilder)? updates]) =>
      (UserMembershipBuilder()..update(updates))._build();

  _$UserMembership._({
    this.id,
    this.userId,
    this.planId,
    this.orderNo,
    this.startTime,
    this.expireTime,
    this.status,
    this.createTime,
    this.updateTime,
    this.expired,
    this.delete,
    this.active,
  }) : super._();
  @override
  UserMembership rebuild(void Function(UserMembershipBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserMembershipBuilder toBuilder() => UserMembershipBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserMembership &&
        id == other.id &&
        userId == other.userId &&
        planId == other.planId &&
        orderNo == other.orderNo &&
        startTime == other.startTime &&
        expireTime == other.expireTime &&
        status == other.status &&
        createTime == other.createTime &&
        updateTime == other.updateTime &&
        expired == other.expired &&
        delete == other.delete &&
        active == other.active;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, planId.hashCode);
    _$hash = $jc(_$hash, orderNo.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, expireTime.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jc(_$hash, expired.hashCode);
    _$hash = $jc(_$hash, delete.hashCode);
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserMembership')
          ..add('id', id)
          ..add('userId', userId)
          ..add('planId', planId)
          ..add('orderNo', orderNo)
          ..add('startTime', startTime)
          ..add('expireTime', expireTime)
          ..add('status', status)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime)
          ..add('expired', expired)
          ..add('delete', delete)
          ..add('active', active))
        .toString();
  }
}

class UserMembershipBuilder
    implements Builder<UserMembership, UserMembershipBuilder> {
  _$UserMembership? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  UserIdBuilder? _userId;
  UserIdBuilder get userId => _$this._userId ??= UserIdBuilder();
  set userId(UserIdBuilder? userId) => _$this._userId = userId;

  int? _planId;
  int? get planId => _$this._planId;
  set planId(int? planId) => _$this._planId = planId;

  String? _orderNo;
  String? get orderNo => _$this._orderNo;
  set orderNo(String? orderNo) => _$this._orderNo = orderNo;

  DateTime? _startTime;
  DateTime? get startTime => _$this._startTime;
  set startTime(DateTime? startTime) => _$this._startTime = startTime;

  DateTime? _expireTime;
  DateTime? get expireTime => _$this._expireTime;
  set expireTime(DateTime? expireTime) => _$this._expireTime = expireTime;

  UserMembershipStatusEnum? _status;
  UserMembershipStatusEnum? get status => _$this._status;
  set status(UserMembershipStatusEnum? status) => _$this._status = status;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  bool? _expired;
  bool? get expired => _$this._expired;
  set expired(bool? expired) => _$this._expired = expired;

  bool? _delete;
  bool? get delete => _$this._delete;
  set delete(bool? delete) => _$this._delete = delete;

  bool? _active;
  bool? get active => _$this._active;
  set active(bool? active) => _$this._active = active;

  UserMembershipBuilder() {
    UserMembership._defaults(this);
  }

  UserMembershipBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId?.toBuilder();
      _planId = $v.planId;
      _orderNo = $v.orderNo;
      _startTime = $v.startTime;
      _expireTime = $v.expireTime;
      _status = $v.status;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _expired = $v.expired;
      _delete = $v.delete;
      _active = $v.active;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserMembership other) {
    _$v = other as _$UserMembership;
  }

  @override
  void update(void Function(UserMembershipBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserMembership build() => _build();

  _$UserMembership _build() {
    _$UserMembership _$result;
    try {
      _$result =
          _$v ??
          _$UserMembership._(
            id: id,
            userId: _userId?.build(),
            planId: planId,
            orderNo: orderNo,
            startTime: startTime,
            expireTime: expireTime,
            status: status,
            createTime: createTime,
            updateTime: updateTime,
            expired: expired,
            delete: delete,
            active: active,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userId';
        _userId?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UserMembership',
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
