//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'error_handling_config.g.dart';

/// ErrorHandlingConfig
///
/// Properties:
/// * [onError]
/// * [retryCount]
/// * [retryDelayMs]
/// * [fallbackNodeId]
/// * [timeoutMs]
@BuiltValue()
abstract class ErrorHandlingConfig
    implements Built<ErrorHandlingConfig, ErrorHandlingConfigBuilder> {
  @BuiltValueField(wireName: r'onError')
  ErrorHandlingConfigOnErrorEnum? get onError;
  // enum onErrorEnum {  STOP,  CONTINUE,  RETRY,  FALLBACK,  };

  @BuiltValueField(wireName: r'retryCount')
  int? get retryCount;

  @BuiltValueField(wireName: r'retryDelayMs')
  int? get retryDelayMs;

  @BuiltValueField(wireName: r'fallbackNodeId')
  String? get fallbackNodeId;

  @BuiltValueField(wireName: r'timeoutMs')
  int? get timeoutMs;

  ErrorHandlingConfig._();

  factory ErrorHandlingConfig([void updates(ErrorHandlingConfigBuilder b)]) =
      _$ErrorHandlingConfig;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ErrorHandlingConfigBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ErrorHandlingConfig> get serializer =>
      _$ErrorHandlingConfigSerializer();
}

class _$ErrorHandlingConfigSerializer
    implements PrimitiveSerializer<ErrorHandlingConfig> {
  @override
  final Iterable<Type> types = const [
    ErrorHandlingConfig,
    _$ErrorHandlingConfig
  ];

  @override
  final String wireName = r'ErrorHandlingConfig';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ErrorHandlingConfig object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.onError != null) {
      yield r'onError';
      yield serializers.serialize(
        object.onError,
        specifiedType: const FullType(ErrorHandlingConfigOnErrorEnum),
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
    ErrorHandlingConfig object, {
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
    required ErrorHandlingConfigBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'onError':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ErrorHandlingConfigOnErrorEnum),
          ) as ErrorHandlingConfigOnErrorEnum;
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
  ErrorHandlingConfig deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ErrorHandlingConfigBuilder();
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

class ErrorHandlingConfigOnErrorEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'STOP')
  static const ErrorHandlingConfigOnErrorEnum STOP =
      _$errorHandlingConfigOnErrorEnum_STOP;
  @BuiltValueEnumConst(wireName: r'CONTINUE')
  static const ErrorHandlingConfigOnErrorEnum CONTINUE =
      _$errorHandlingConfigOnErrorEnum_CONTINUE;
  @BuiltValueEnumConst(wireName: r'RETRY')
  static const ErrorHandlingConfigOnErrorEnum RETRY =
      _$errorHandlingConfigOnErrorEnum_RETRY;
  @BuiltValueEnumConst(wireName: r'FALLBACK')
  static const ErrorHandlingConfigOnErrorEnum FALLBACK =
      _$errorHandlingConfigOnErrorEnum_FALLBACK;

  static Serializer<ErrorHandlingConfigOnErrorEnum> get serializer =>
      _$errorHandlingConfigOnErrorEnumSerializer;

  const ErrorHandlingConfigOnErrorEnum._(String name) : super(name);

  static BuiltSet<ErrorHandlingConfigOnErrorEnum> get values =>
      _$errorHandlingConfigOnErrorEnumValues;
  static ErrorHandlingConfigOnErrorEnum valueOf(String name) =>
      _$errorHandlingConfigOnErrorEnumValueOf(name);
}
