//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_class_request.g.dart';

/// 更新班级请求
///
/// Properties:
/// * [className] - 班级名称
/// * [description] - 班级描述
@BuiltValue()
abstract class UpdateClassRequest
    implements Built<UpdateClassRequest, UpdateClassRequestBuilder> {
  /// 班级名称
  @BuiltValueField(wireName: r'className')
  String? get className;

  /// 班级描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  UpdateClassRequest._();

  factory UpdateClassRequest([void updates(UpdateClassRequestBuilder b)]) =
      _$UpdateClassRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateClassRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateClassRequest> get serializer =>
      _$UpdateClassRequestSerializer();
}

class _$UpdateClassRequestSerializer
    implements PrimitiveSerializer<UpdateClassRequest> {
  @override
  final Iterable<Type> types = const [UpdateClassRequest, _$UpdateClassRequest];

  @override
  final String wireName = r'UpdateClassRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateClassRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.className != null) {
      yield r'className';
      yield serializers.serialize(
        object.className,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateClassRequest object, {
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
    required UpdateClassRequestBuilder result,
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
  UpdateClassRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateClassRequestBuilder();
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
