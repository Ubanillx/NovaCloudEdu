//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/class_schedule_item_response.dart';
import 'package:nova_api/src/model/class_schedule_setting_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'schedule_response.g.dart';

/// ScheduleResponse
///
/// Properties:
/// * [setting]
/// * [items]
@BuiltValue()
abstract class ScheduleResponse
    implements Built<ScheduleResponse, ScheduleResponseBuilder> {
  @BuiltValueField(wireName: r'setting')
  ClassScheduleSettingResponse? get setting;

  @BuiltValueField(wireName: r'items')
  BuiltList<ClassScheduleItemResponse>? get items;

  ScheduleResponse._();

  factory ScheduleResponse([void updates(ScheduleResponseBuilder b)]) =
      _$ScheduleResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScheduleResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScheduleResponse> get serializer =>
      _$ScheduleResponseSerializer();
}

class _$ScheduleResponseSerializer
    implements PrimitiveSerializer<ScheduleResponse> {
  @override
  final Iterable<Type> types = const [ScheduleResponse, _$ScheduleResponse];

  @override
  final String wireName = r'ScheduleResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScheduleResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.setting != null) {
      yield r'setting';
      yield serializers.serialize(
        object.setting,
        specifiedType: const FullType(ClassScheduleSettingResponse),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType:
            const FullType(BuiltList, [FullType(ClassScheduleItemResponse)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ScheduleResponse object, {
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
    required ScheduleResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'setting':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ClassScheduleSettingResponse),
          ) as ClassScheduleSettingResponse;
          result.setting.replace(valueDes);
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltList, [FullType(ClassScheduleItemResponse)]),
          ) as BuiltList<ClassScheduleItemResponse>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScheduleResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScheduleResponseBuilder();
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
