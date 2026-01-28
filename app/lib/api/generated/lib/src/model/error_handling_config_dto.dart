//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'error_handling_config_dto.g.dart';

/// 错误处理配置
///
/// Properties:
/// * [onError] - 错误处理策略
/// * [retryCount] - 重试次数
/// * [retryDelayMs] - 重试延迟（毫秒）
/// * [fallbackNodeId] - 回退节点ID
/// * [timeoutMs] - 超时时间（毫秒）
@BuiltValue()
abstract class ErrorHandlingConfigDTO
    implements Built<ErrorHandlingConfigDTO, ErrorHandlingConfigDTOBuilder> {
  /// 错误处理策略
  @BuiltValueField(wireName: r'onError')
  ErrorHandlingConfigDTOOnErrorEnum? get onError;
  // enum onErrorEnum {  STOP,  RETRY,  SKIP,  FALLBACK,  };

  /// 重试次数
  @BuiltValueField(wireName: r'retryCount')
  int? get retryCount;

  /// 重试延迟（毫秒）
  @BuiltValueField(wireName: r'retryDelayMs')
  int? get retryDelayMs;

  /// 回退节点ID
  @BuiltValueField(wireName: r'fallbackNodeId')
  String? get fallbackNodeId;

  /// 超时时间（毫秒）
  @BuiltValueField(wireName: r'timeoutMs')
  int? get timeoutMs;

  ErrorHandlingConfigDTO._();

  factory ErrorHandlingConfigDTO(
          [void updates(ErrorHandlingConfigDTOBuilder b)]) =
      _$ErrorHandlingConfigDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ErrorHandlingConfigDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ErrorHandlingConfigDTO> get serializer =>
      _$ErrorHandlingConfigDTOSerializer();
}

class _$ErrorHandlingConfigDTOSerializer
    implements PrimitiveSerializer<ErrorHandlingConfigDTO> {
  @override
  final Iterable<Type> types = const [
    ErrorHandlingConfigDTO,
    _$ErrorHandlingConfigDTO
  ];

  @override
  final String wireName = r'ErrorHandlingConfigDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ErrorHandlingConfigDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.onError != null) {
      yield r'onError';
      yield serializers.serialize(
        object.onError,
        specifiedType: const FullType(ErrorHandlingConfigDTOOnErrorEnum),
      );
    }
    if (object.retryCount != null) {
      yield r'retryCount';
      yield serializers.serialize(
        object.retryCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.retryDelayMs != null) {
      yield r'retryDelayMs';
      yield serializers.serialize(
        object.retryDelayMs,
        specifiedType: const FullType(int),
      );
    }
    if (object.fallbackNodeId != null) {
      yield r'fallbackNodeId';
      yield serializers.serialize(
        object.fallbackNodeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.timeoutMs != null) {
      yield r'timeoutMs';
      yield serializers.serialize(
        object.timeoutMs,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ErrorHandlingConfigDTO object, {
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
    required ErrorHandlingConfigDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'onError':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ErrorHandlingConfigDTOOnErrorEnum),
          ) as ErrorHandlingConfigDTOOnErrorEnum;
          result.onError = valueDes;
          break;
        case r'retryCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.retryCount = valueDes;
          break;
        case r'retryDelayMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.retryDelayMs = valueDes;
          break;
        case r'fallbackNodeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fallbackNodeId = valueDes;
          break;
        case r'timeoutMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.timeoutMs = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ErrorHandlingConfigDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ErrorHandlingConfigDTOBuilder();
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

class ErrorHandlingConfigDTOOnErrorEnum extends EnumClass {
  /// 错误处理策略
  @BuiltValueEnumConst(wireName: r'STOP')
  static const ErrorHandlingConfigDTOOnErrorEnum STOP =
      _$errorHandlingConfigDTOOnErrorEnum_STOP;

  /// 错误处理策略
  @BuiltValueEnumConst(wireName: r'RETRY')
  static const ErrorHandlingConfigDTOOnErrorEnum RETRY =
      _$errorHandlingConfigDTOOnErrorEnum_RETRY;

  /// 错误处理策略
  @BuiltValueEnumConst(wireName: r'SKIP')
  static const ErrorHandlingConfigDTOOnErrorEnum SKIP =
      _$errorHandlingConfigDTOOnErrorEnum_SKIP;

  /// 错误处理策略
  @BuiltValueEnumConst(wireName: r'FALLBACK')
  static const ErrorHandlingConfigDTOOnErrorEnum FALLBACK =
      _$errorHandlingConfigDTOOnErrorEnum_FALLBACK;

  static Serializer<ErrorHandlingConfigDTOOnErrorEnum> get serializer =>
      _$errorHandlingConfigDTOOnErrorEnumSerializer;

  const ErrorHandlingConfigDTOOnErrorEnum._(String name) : super(name);

  static BuiltSet<ErrorHandlingConfigDTOOnErrorEnum> get values =>
      _$errorHandlingConfigDTOOnErrorEnumValues;
  static ErrorHandlingConfigDTOOnErrorEnum valueOf(String name) =>
      _$errorHandlingConfigDTOOnErrorEnumValueOf(name);
}
