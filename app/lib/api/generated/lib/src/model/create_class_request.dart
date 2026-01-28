//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_class_request.g.dart';

/// 创建班级请求
///
/// Properties:
/// * [className] - 班级名称
/// * [description] - 班级描述
@BuiltValue()
abstract class CreateClassRequest
    implements Built<CreateClassRequest, CreateClassRequestBuilder> {
  /// 班级名称
  @BuiltValueField(wireName: r'className')
  String get className;

  /// 班级描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  CreateClassRequest._();

  factory CreateClassRequest([void updates(CreateClassRequestBuilder b)]) =
      _$CreateClassRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateClassRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateClassRequest> get serializer =>
      _$CreateClassRequestSerializer();
}

class _$CreateClassRequestSerializer
    implements PrimitiveSerializer<CreateClassRequest> {
  @override
  final Iterable<Type> types = const [CreateClassRequest, _$CreateClassRequest];

  @override
  final String wireName = r'CreateClassRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateClassRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'className';
    yield serializers.serialize(
      object.className,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateClassRequest object, {
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
    required CreateClassRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'className':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.className = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateClassRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateClassRequestBuilder();
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
