//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'purchase_membership_request.g.dart';

/// 购买会员请求
///
/// Properties:
/// * [planId] - 会员计划ID
@BuiltValue()
abstract class PurchaseMembershipRequest
    implements
        Built<PurchaseMembershipRequest, PurchaseMembershipRequestBuilder> {
  /// 会员计划ID
  @BuiltValueField(wireName: r'planId')
  int get planId;

  PurchaseMembershipRequest._();

  factory PurchaseMembershipRequest(
          [void updates(PurchaseMembershipRequestBuilder b)]) =
      _$PurchaseMembershipRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PurchaseMembershipRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PurchaseMembershipRequest> get serializer =>
      _$PurchaseMembershipRequestSerializer();
}

class _$PurchaseMembershipRequestSerializer
    implements PrimitiveSerializer<PurchaseMembershipRequest> {
  @override
  final Iterable<Type> types = const [
    PurchaseMembershipRequest,
    _$PurchaseMembershipRequest
  ];

  @override
  final String wireName = r'PurchaseMembershipRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PurchaseMembershipRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'planId';
    yield serializers.serialize(
      object.planId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PurchaseMembershipRequest object, {
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
    required PurchaseMembershipRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  PurchaseMembershipRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PurchaseMembershipRequestBuilder();
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
