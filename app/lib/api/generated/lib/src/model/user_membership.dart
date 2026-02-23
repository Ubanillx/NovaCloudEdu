//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/user_id.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_membership.g.dart';

/// UserMembership
///
/// Properties:
/// * [id]
/// * [userId]
/// * [planId]
/// * [orderNo]
/// * [startTime]
/// * [expireTime]
/// * [status]
/// * [createTime]
/// * [updateTime]
/// * [expired]
/// * [delete]
/// * [active]
@BuiltValue()
abstract class UserMembership
    implements Built<UserMembership, UserMembershipBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'userId')
  UserId? get userId;

  @BuiltValueField(wireName: r'planId')
  int? get planId;

  @BuiltValueField(wireName: r'orderNo')
  String? get orderNo;

  @BuiltValueField(wireName: r'startTime')
  DateTime? get startTime;

  @BuiltValueField(wireName: r'expireTime')
  DateTime? get expireTime;

  @BuiltValueField(wireName: r'status')
  UserMembershipStatusEnum? get status;
  // enum statusEnum {  PENDING,  ACTIVE,  EXPIRED,  CANCELLED,  };

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  @BuiltValueField(wireName: r'expired')
  bool? get expired;

  @BuiltValueField(wireName: r'delete')
  bool? get delete;

  @BuiltValueField(wireName: r'active')
  bool? get active;

  UserMembership._();

  factory UserMembership([void updates(UserMembershipBuilder b)]) =
      _$UserMembership;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserMembershipBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserMembership> get serializer =>
      _$UserMembershipSerializer();
}

class _$UserMembershipSerializer
    implements PrimitiveSerializer<UserMembership> {
  @override
  final Iterable<Type> types = const [UserMembership, _$UserMembership];

  @override
  final String wireName = r'UserMembership';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserMembership object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(UserId),
      );
    }
    if (object.planId != null) {
      yield r'planId';
      yield serializers.serialize(
        object.planId,
        specifiedType: const FullType(int),
      );
    }
    if (object.orderNo != null) {
      yield r'orderNo';
      yield serializers.serialize(
        object.orderNo,
        specifiedType: const FullType(String),
      );
    }
    if (object.startTime != null) {
      yield r'startTime';
      yield serializers.serialize(
        object.startTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.expireTime != null) {
      yield r'expireTime';
      yield serializers.serialize(
        object.expireTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(UserMembershipStatusEnum),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.expired != null) {
      yield r'expired';
      yield serializers.serialize(
        object.expired,
        specifiedType: const FullType(bool),
      );
    }
    if (object.delete != null) {
      yield r'delete';
      yield serializers.serialize(
        object.delete,
        specifiedType: const FullType(bool),
      );
    }
    if (object.active != null) {
      yield r'active';
      yield serializers.serialize(
        object.active,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserMembership object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserMembershipBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserId),
          ) as UserId;
          result.userId.replace(valueDes);
          break;
        case r'planId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.planId = valueDes;
          break;
        case r'orderNo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderNo = valueDes;
          break;
        case r'startTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startTime = valueDes;
          break;
        case r'expireTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expireTime = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserMembershipStatusEnum),
          ) as UserMembershipStatusEnum;
          result.status = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        case r'expired':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.expired = valueDes;
          break;
        case r'delete':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.delete = valueDes;
          break;
        case r'active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.active = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserMembership deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserMembershipBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class UserMembershipStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'PENDING')
  static const UserMembershipStatusEnum PENDING =
      _$userMembershipStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'ACTIVE')
  static const UserMembershipStatusEnum ACTIVE =
      _$userMembershipStatusEnum_ACTIVE;
  @BuiltValueEnumConst(wireName: r'EXPIRED')
  static const UserMembershipStatusEnum EXPIRED =
      _$userMembershipStatusEnum_EXPIRED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const UserMembershipStatusEnum CANCELLED =
      _$userMembershipStatusEnum_CANCELLED;

  static Serializer<UserMembershipStatusEnum> get serializer =>
      _$userMembershipStatusEnumSerializer;

  const UserMembershipStatusEnum._(String name) : super(name);

  static BuiltSet<UserMembershipStatusEnum> get values =>
      _$userMembershipStatusEnumValues;
  static UserMembershipStatusEnum valueOf(String name) =>
      _$userMembershipStatusEnumValueOf(name);
}
