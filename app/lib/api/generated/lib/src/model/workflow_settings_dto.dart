//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_settings_dto.g.dart';

/// 工作流设置
///
/// Properties:
/// * [maxExecutionTimeMs] - 最大执行时间（毫秒）
/// * [enableLogging] - 是否启用日志
/// * [logLevel] - 日志级别
/// * [enableDebug] - 是否启用调试模式
@BuiltValue()
abstract class WorkflowSettingsDTO
    implements Built<WorkflowSettingsDTO, WorkflowSettingsDTOBuilder> {
  /// 最大执行时间（毫秒）
  @BuiltValueField(wireName: r'maxExecutionTimeMs')
  int? get maxExecutionTimeMs;

  /// 是否启用日志
  @BuiltValueField(wireName: r'enableLogging')
  bool? get enableLogging;

  /// 日志级别
  @BuiltValueField(wireName: r'logLevel')
  String? get logLevel;

  /// 是否启用调试模式
  @BuiltValueField(wireName: r'enableDebug')
  bool? get enableDebug;

  WorkflowSettingsDTO._();

  factory WorkflowSettingsDTO([void updates(WorkflowSettingsDTOBuilder b)]) =
      _$WorkflowSettingsDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowSettingsDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowSettingsDTO> get serializer =>
      _$WorkflowSettingsDTOSerializer();
}

class _$WorkflowSettingsDTOSerializer
    implements PrimitiveSerializer<WorkflowSettingsDTO> {
  @override
  final Iterable<Type> types = const [
    WorkflowSettingsDTO,
    _$WorkflowSettingsDTO
  ];

  @override
  final String wireName = r'WorkflowSettingsDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowSettingsDTO object, {
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
        specifiedType: const FullType(String),
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
    WorkflowSettingsDTO object, {
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
    required WorkflowSettingsDTOBuilder result,
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
            specifiedType: const FullType(String),
          ) as String;
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
  WorkflowSettingsDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowSettingsDTOBuilder();
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
