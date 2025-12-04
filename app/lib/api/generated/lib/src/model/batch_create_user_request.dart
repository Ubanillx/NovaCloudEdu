//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/create_user_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'batch_create_user_request.g.dart';

/// BatchCreateUserRequest
///
/// Properties:
/// * [users]
@BuiltValue()
abstract class BatchCreateUserRequest
    implements Built<BatchCreateUserRequest, BatchCreateUserRequestBuilder> {
  @BuiltValueField(wireName: r'users')
  BuiltList<CreateUserRequest> get users;

  BatchCreateUserRequest._();

  factory BatchCreateUserRequest(
          [void updates(BatchCreateUserRequestBuilder b)]) =
      _$BatchCreateUserRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BatchCreateUserRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BatchCreateUserRequest> get serializer =>
      _$BatchCreateUserRequestSerializer();
}

class _$BatchCreateUserRequestSerializer
    implements PrimitiveSerializer<BatchCreateUserRequest> {
  @override
  final Iterable<Type> types = const [
    BatchCreateUserRequest,
    _$BatchCreateUserRequest
  ];

  @override
  final String wireName = r'BatchCreateUserRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BatchCreateUserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'users';
    yield serializers.serialize(
      object.users,
      specifiedType: const FullType(BuiltList, [FullType(CreateUserRequest)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BatchCreateUserRequest object, {
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
    required BatchCreateUserRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'users':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(CreateUserRequest)]),
          ) as BuiltList<CreateUserRequest>;
          result.users.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BatchCreateUserRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BatchCreateUserRequestBuilder();
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
