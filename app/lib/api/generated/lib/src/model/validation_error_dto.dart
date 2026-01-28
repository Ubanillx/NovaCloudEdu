//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'validation_error_dto.g.dart';

/// 验证错误
///
/// Properties:
/// * [code] - 错误代码
/// * [message] - 错误消息
/// * [nodeId] - 相关节点ID
/// * [edgeId] - 相关连接线ID
@BuiltValue()
abstract class ValidationErrorDTO
    implements Built<ValidationErrorDTO, ValidationErrorDTOBuilder> {
  /// 错误代码
  @BuiltValueField(wireName: r'code')
  String? get code;

  /// 错误消息
  @BuiltValueField(wireName: r'message')
  String? get message;

  /// 相关节点ID
  @BuiltValueField(wireName: r'nodeId')
  String? get nodeId;

  /// 相关连接线ID
  @BuiltValueField(wireName: r'edgeId')
  String? get edgeId;

  ValidationErrorDTO._();

  factory ValidationErrorDTO([void updates(ValidationErrorDTOBuilder b)]) =
      _$ValidationErrorDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ValidationErrorDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ValidationErrorDTO> get serializer =>
      _$ValidationErrorDTOSerializer();
}

class _$ValidationErrorDTOSerializer
    implements PrimitiveSerializer<ValidationErrorDTO> {
  @override
  final Iterable<Type> types = const [ValidationErrorDTO, _$ValidationErrorDTO];

  @override
  final String wireName = r'ValidationErrorDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ValidationErrorDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(String),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.nodeId != null) {
      yield r'nodeId';
      yield serializers.serialize(
        object.nodeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.edgeId != null) {
      yield r'edgeId';
      yield serializers.serialize(
        object.edgeId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ValidationErrorDTO object, {
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
    required ValidationErrorDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'nodeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nodeId = valueDes;
          break;
        case r'edgeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.edgeId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ValidationErrorDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ValidationErrorDTOBuilder();
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
