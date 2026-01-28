//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_group_request.g.dart';

/// CreateGroupRequest
///
/// Properties:
/// * [groupName]
/// * [description]
/// * [avatar]
@BuiltValue()
abstract class CreateGroupRequest
    implements Built<CreateGroupRequest, CreateGroupRequestBuilder> {
  @BuiltValueField(wireName: r'groupName')
  String get groupName;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'avatar')
  String? get avatar;

  CreateGroupRequest._();

  factory CreateGroupRequest([void updates(CreateGroupRequestBuilder b)]) =
      _$CreateGroupRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateGroupRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateGroupRequest> get serializer =>
      _$CreateGroupRequestSerializer();
}

class _$CreateGroupRequestSerializer
    implements PrimitiveSerializer<CreateGroupRequest> {
  @override
  final Iterable<Type> types = const [CreateGroupRequest, _$CreateGroupRequest];

  @override
  final String wireName = r'CreateGroupRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateGroupRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'groupName';
    yield serializers.serialize(
      object.groupName,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.avatar != null) {
      yield r'avatar';
      yield serializers.serialize(
        object.avatar,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateGroupRequest object, {
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
    required CreateGroupRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'groupName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.groupName = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'avatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.avatar = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateGroupRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateGroupRequestBuilder();
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
