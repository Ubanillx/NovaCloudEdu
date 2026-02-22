//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/class_analytics_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_class_analytics_response.g.dart';

/// BaseResponseClassAnalyticsResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseClassAnalyticsResponse
    implements
        Built<BaseResponseClassAnalyticsResponse,
            BaseResponseClassAnalyticsResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  ClassAnalyticsResponse? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseClassAnalyticsResponse._();

  factory BaseResponseClassAnalyticsResponse(
          [void updates(BaseResponseClassAnalyticsResponseBuilder b)]) =
      _$BaseResponseClassAnalyticsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseClassAnalyticsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseClassAnalyticsResponse> get serializer =>
      _$BaseResponseClassAnalyticsResponseSerializer();
}

class _$BaseResponseClassAnalyticsResponseSerializer
    implements PrimitiveSerializer<BaseResponseClassAnalyticsResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseClassAnalyticsResponse,
    _$BaseResponseClassAnalyticsResponse
  ];

  @override
  final String wireName = r'BaseResponseClassAnalyticsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseClassAnalyticsResponse object, {
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
        specifiedType: const FullType(ClassAnalyticsResponse),
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
    BaseResponseClassAnalyticsResponse object, {
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
    required BaseResponseClassAnalyticsResponseBuilder result,
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
            specifiedType: const FullType(ClassAnalyticsResponse),
          ) as ClassAnalyticsResponse;
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
  BaseResponseClassAnalyticsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseClassAnalyticsResponseBuilder();
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
