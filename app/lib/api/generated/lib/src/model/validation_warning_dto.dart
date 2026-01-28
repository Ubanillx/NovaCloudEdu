//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'validation_warning_dto.g.dart';

/// 验证警告
///
/// Properties:
/// * [code] - 警告代码
/// * [message] - 警告消息
/// * [nodeId] - 相关节点ID
@BuiltValue()
abstract class ValidationWarningDTO
    implements Built<ValidationWarningDTO, ValidationWarningDTOBuilder> {
  /// 警告代码
  @BuiltValueField(wireName: r'code')
  String? get code;

  /// 警告消息
  @BuiltValueField(wireName: r'message')
  String? get message;

  /// 相关节点ID
  @BuiltValueField(wireName: r'nodeId')
  String? get nodeId;

  ValidationWarningDTO._();

  factory ValidationWarningDTO([void updates(ValidationWarningDTOBuilder b)]) =
      _$ValidationWarningDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ValidationWarningDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ValidationWarningDTO> get serializer =>
      _$ValidationWarningDTOSerializer();
}

class _$ValidationWarningDTOSerializer
    implements PrimitiveSerializer<ValidationWarningDTO> {
  @override
  final Iterable<Type> types = const [
    ValidationWarningDTO,
    _$ValidationWarningDTO
  ];

  @override
  final String wireName = r'ValidationWarningDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ValidationWarningDTO object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ValidationWarningDTO object, {
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
    required ValidationWarningDTOBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ValidationWarningDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ValidationWarningDTOBuilder();
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
