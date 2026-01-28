//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_settings.g.dart';

/// WorkflowSettings
///
/// Properties:
/// * [maxExecutionTimeMs]
/// * [enableLogging]
/// * [logLevel]
/// * [enableDebug]
@BuiltValue()
abstract class WorkflowSettings
    implements Built<WorkflowSettings, WorkflowSettingsBuilder> {
  @BuiltValueField(wireName: r'maxExecutionTimeMs')
  int? get maxExecutionTimeMs;

  @BuiltValueField(wireName: r'enableLogging')
  bool? get enableLogging;

  @BuiltValueField(wireName: r'logLevel')
  WorkflowSettingsLogLevelEnum? get logLevel;
  // enum logLevelEnum {  DEBUG,  INFO,  WARN,  ERROR,  };

  @BuiltValueField(wireName: r'enableDebug')
  bool? get enableDebug;

  WorkflowSettings._();

  factory WorkflowSettings([void updates(WorkflowSettingsBuilder b)]) =
      _$WorkflowSettings;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowSettingsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowSettings> get serializer =>
      _$WorkflowSettingsSerializer();
}

class _$WorkflowSettingsSerializer
    implements PrimitiveSerializer<WorkflowSettings> {
  @override
  final Iterable<Type> types = const [WorkflowSettings, _$WorkflowSettings];

  @override
  final String wireName = r'WorkflowSettings';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowSettings object, {
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
        specifiedType: const FullType(WorkflowSettingsLogLevelEnum),
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
    WorkflowSettings object, {
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
    required WorkflowSettingsBuilder result,
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
            specifiedType: const FullType(WorkflowSettingsLogLevelEnum),
          ) as WorkflowSettingsLogLevelEnum;
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
  WorkflowSettings deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowSettingsBuilder();
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

class WorkflowSettingsLogLevelEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'DEBUG')
  static const WorkflowSettingsLogLevelEnum DEBUG =
      _$workflowSettingsLogLevelEnum_DEBUG;
  @BuiltValueEnumConst(wireName: r'INFO')
  static const WorkflowSettingsLogLevelEnum INFO =
      _$workflowSettingsLogLevelEnum_INFO;
  @BuiltValueEnumConst(wireName: r'WARN')
  static const WorkflowSettingsLogLevelEnum WARN =
      _$workflowSettingsLogLevelEnum_WARN;
  @BuiltValueEnumConst(wireName: r'ERROR')
  static const WorkflowSettingsLogLevelEnum ERROR =
      _$workflowSettingsLogLevelEnum_ERROR;

  static Serializer<WorkflowSettingsLogLevelEnum> get serializer =>
      _$workflowSettingsLogLevelEnumSerializer;

  const WorkflowSettingsLogLevelEnum._(String name) : super(name);

  static BuiltSet<WorkflowSettingsLogLevelEnum> get values =>
      _$workflowSettingsLogLevelEnumValues;
  static WorkflowSettingsLogLevelEnum valueOf(String name) =>
      _$workflowSettingsLogLevelEnumValueOf(name);
}
