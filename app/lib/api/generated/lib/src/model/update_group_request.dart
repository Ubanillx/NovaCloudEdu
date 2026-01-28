//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_group_request.g.dart';

/// UpdateGroupRequest
///
/// Properties:
/// * [groupName]
/// * [description]
/// * [avatar]
@BuiltValue()
abstract class UpdateGroupRequest
    implements Built<UpdateGroupRequest, UpdateGroupRequestBuilder> {
  @BuiltValueField(wireName: r'groupName')
  String? get groupName;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'avatar')
  String? get avatar;

  UpdateGroupRequest._();

  factory UpdateGroupRequest([void updates(UpdateGroupRequestBuilder b)]) =
      _$UpdateGroupRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateGroupRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateGroupRequest> get serializer =>
      _$UpdateGroupRequestSerializer();
}

class _$UpdateGroupRequestSerializer
    implements PrimitiveSerializer<UpdateGroupRequest> {
  @override
  final Iterable<Type> types = const [UpdateGroupRequest, _$UpdateGroupRequest];

  @override
  final String wireName = r'UpdateGroupRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateGroupRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.groupName != null) {
      yield r'groupName';
      yield serializers.serialize(
        object.groupName,
        specifiedType: const FullType(String),
      );
    }
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
    UpdateGroupRequest object, {
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
    required UpdateGroupRequestBuilder result,
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
  UpdateGroupRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateGroupRequestBuilder();
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
