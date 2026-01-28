//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_workflow_settings_request.g.dart';

/// 更新工作流设置请求
///
/// Properties:
/// * [maxExecutionTimeMs] - 最大执行时间（毫秒）
/// * [enableLogging] - 是否启用日志
/// * [logLevel] - 日志级别
/// * [enableDebug] - 是否启用调试模式
@BuiltValue()
abstract class UpdateWorkflowSettingsRequest
    implements
        Built<UpdateWorkflowSettingsRequest,
            UpdateWorkflowSettingsRequestBuilder> {
  /// 最大执行时间（毫秒）
  @BuiltValueField(wireName: r'maxExecutionTimeMs')
  int? get maxExecutionTimeMs;

  /// 是否启用日志
  @BuiltValueField(wireName: r'enableLogging')
  bool? get enableLogging;

  /// 日志级别
  @BuiltValueField(wireName: r'logLevel')
  UpdateWorkflowSettingsRequestLogLevelEnum? get logLevel;
  // enum logLevelEnum {  DEBUG,  INFO,  WARN,  ERROR,  };

  /// 是否启用调试模式
  @BuiltValueField(wireName: r'enableDebug')
  bool? get enableDebug;

  UpdateWorkflowSettingsRequest._();

  factory UpdateWorkflowSettingsRequest(
          [void updates(UpdateWorkflowSettingsRequestBuilder b)]) =
      _$UpdateWorkflowSettingsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateWorkflowSettingsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateWorkflowSettingsRequest> get serializer =>
      _$UpdateWorkflowSettingsRequestSerializer();
}

class _$UpdateWorkflowSettingsRequestSerializer
    implements PrimitiveSerializer<UpdateWorkflowSettingsRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateWorkflowSettingsRequest,
    _$UpdateWorkflowSettingsRequest
  ];

  @override
  final String wireName = r'UpdateWorkflowSettingsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateWorkflowSettingsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.maxExecutionTimeMs != null) {
      yield r'maxExecutionTimeMs';
      yield serializers.serialize(
        object.maxExecutionTimeMs,
        specifiedType: const FullType(int),
      );
    }
    if (object.enableLogging != null) {
      yield r'enableLogging';
      yield serializers.serialize(
        object.enableLogging,
        specifiedType: const FullType(bool),
      );
    }
    if (object.logLevel != null) {
      yield r'logLevel';
      yield serializers.serialize(
        object.logLevel,
        specifiedType:
            const FullType(UpdateWorkflowSettingsRequestLogLevelEnum),
      );
    }
    if (object.enableDebug != null) {
      yield r'enableDebug';
      yield serializers.serialize(
        object.enableDebug,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateWorkflowSettingsRequest object, {
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
    required UpdateWorkflowSettingsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'maxExecutionTimeMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxExecutionTimeMs = valueDes;
          break;
        case r'enableLogging':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enableLogging = valueDes;
          break;
        case r'logLevel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(UpdateWorkflowSettingsRequestLogLevelEnum),
          ) as UpdateWorkflowSettingsRequestLogLevelEnum;
          result.logLevel = valueDes;
          break;
        case r'enableDebug':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enableDebug = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateWorkflowSettingsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateWorkflowSettingsRequestBuilder();
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

class UpdateWorkflowSettingsRequestLogLevelEnum extends EnumClass {
  /// 日志级别
  @BuiltValueEnumConst(wireName: r'DEBUG')
  static const UpdateWorkflowSettingsRequestLogLevelEnum DEBUG =
      _$updateWorkflowSettingsRequestLogLevelEnum_DEBUG;

  /// 日志级别
  @BuiltValueEnumConst(wireName: r'INFO')
  static const UpdateWorkflowSettingsRequestLogLevelEnum INFO =
      _$updateWorkflowSettingsRequestLogLevelEnum_INFO;

  /// 日志级别
  @BuiltValueEnumConst(wireName: r'WARN')
  static const UpdateWorkflowSettingsRequestLogLevelEnum WARN =
      _$updateWorkflowSettingsRequestLogLevelEnum_WARN;

  /// 日志级别
  @BuiltValueEnumConst(wireName: r'ERROR')
  static const UpdateWorkflowSettingsRequestLogLevelEnum ERROR =
      _$updateWorkflowSettingsRequestLogLevelEnum_ERROR;

  static Serializer<UpdateWorkflowSettingsRequestLogLevelEnum> get serializer =>
      _$updateWorkflowSettingsRequestLogLevelEnumSerializer;

  const UpdateWorkflowSettingsRequestLogLevelEnum._(String name) : super(name);

  static BuiltSet<UpdateWorkflowSettingsRequestLogLevelEnum> get values =>
      _$updateWorkflowSettingsRequestLogLevelEnumValues;
  static UpdateWorkflowSettingsRequestLogLevelEnum valueOf(String name) =>
      _$updateWorkflowSettingsRequestLogLevelEnumValueOf(name);
}
