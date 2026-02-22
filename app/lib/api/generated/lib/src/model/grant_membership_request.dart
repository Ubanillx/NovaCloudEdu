//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'grant_membership_request.g.dart';

/// 管理员为用户开通会员请求
///
/// Properties:
/// * [userId] - 用户ID
/// * [planId] - 会员计划ID
@BuiltValue()
abstract class GrantMembershipRequest
    implements Built<GrantMembershipRequest, GrantMembershipRequestBuilder> {
  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int get userId;

  /// 会员计划ID
  @BuiltValueField(wireName: r'planId')
  int get planId;

  GrantMembershipRequest._();

  factory GrantMembershipRequest(
          [void updates(GrantMembershipRequestBuilder b)]) =
      _$GrantMembershipRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GrantMembershipRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GrantMembershipRequest> get serializer =>
      _$GrantMembershipRequestSerializer();
}

class _$GrantMembershipRequestSerializer
    implements PrimitiveSerializer<GrantMembershipRequest> {
  @override
  final Iterable<Type> types = const [
    GrantMembershipRequest,
    _$GrantMembershipRequest
  ];

  @override
  final String wireName = r'GrantMembershipRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GrantMembershipRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'planId';
    yield serializers.serialize(
      object.planId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GrantMembershipRequest object, {
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
    required GrantMembershipRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'planId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.planId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GrantMembershipRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GrantMembershipRequestBuilder();
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
