//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/checkin_status_result.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_checkin_status_result.g.dart';

/// BaseResponseCheckinStatusResult
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseCheckinStatusResult
    implements
        Built<BaseResponseCheckinStatusResult,
            BaseResponseCheckinStatusResultBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  CheckinStatusResult? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseCheckinStatusResult._();

  factory BaseResponseCheckinStatusResult(
          [void updates(BaseResponseCheckinStatusResultBuilder b)]) =
      _$BaseResponseCheckinStatusResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseCheckinStatusResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseCheckinStatusResult> get serializer =>
      _$BaseResponseCheckinStatusResultSerializer();
}

class _$BaseResponseCheckinStatusResultSerializer
    implements PrimitiveSerializer<BaseResponseCheckinStatusResult> {
  @override
  final Iterable<Type> types = const [
    BaseResponseCheckinStatusResult,
    _$BaseResponseCheckinStatusResult
  ];

  @override
  final String wireName = r'BaseResponseCheckinStatusResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseCheckinStatusResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(int),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(CheckinStatusResult),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BaseResponseCheckinStatusResult object, {
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
    required BaseResponseCheckinStatusResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.code = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CheckinStatusResult),
          ) as CheckinStatusResult;
          result.data.replace(valueDes);
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BaseResponseCheckinStatusResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseCheckinStatusResultBuilder();
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
