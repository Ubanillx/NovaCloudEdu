//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'batch_ban_user_request.g.dart';

/// BatchBanUserRequest
///
/// Properties:
/// * [userIds]
/// * [banned]
@BuiltValue()
abstract class BatchBanUserRequest
    implements Built<BatchBanUserRequest, BatchBanUserRequestBuilder> {
  @BuiltValueField(wireName: r'userIds')
  BuiltList<int> get userIds;

  @BuiltValueField(wireName: r'banned')
  bool get banned;

  BatchBanUserRequest._();

  factory BatchBanUserRequest([void updates(BatchBanUserRequestBuilder b)]) =
      _$BatchBanUserRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BatchBanUserRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BatchBanUserRequest> get serializer =>
      _$BatchBanUserRequestSerializer();
}

class _$BatchBanUserRequestSerializer
    implements PrimitiveSerializer<BatchBanUserRequest> {
  @override
  final Iterable<Type> types = const [
    BatchBanUserRequest,
    _$BatchBanUserRequest
  ];

  @override
  final String wireName = r'BatchBanUserRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BatchBanUserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userIds';
    yield serializers.serialize(
      object.userIds,
      specifiedType: const FullType(BuiltList, [FullType(int)]),
    );
    yield r'banned';
    yield serializers.serialize(
      object.banned,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BatchBanUserRequest object, {
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
    required BatchBanUserRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.userIds.replace(valueDes);
          break;
        case r'banned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.banned = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BatchBanUserRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BatchBanUserRequestBuilder();
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
