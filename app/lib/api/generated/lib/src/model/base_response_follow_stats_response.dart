//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/follow_stats_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_follow_stats_response.g.dart';

/// BaseResponseFollowStatsResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseFollowStatsResponse
    implements
        Built<BaseResponseFollowStatsResponse,
            BaseResponseFollowStatsResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  FollowStatsResponse? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseFollowStatsResponse._();

  factory BaseResponseFollowStatsResponse(
          [void updates(BaseResponseFollowStatsResponseBuilder b)]) =
      _$BaseResponseFollowStatsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseFollowStatsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseFollowStatsResponse> get serializer =>
      _$BaseResponseFollowStatsResponseSerializer();
}

class _$BaseResponseFollowStatsResponseSerializer
    implements PrimitiveSerializer<BaseResponseFollowStatsResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseFollowStatsResponse,
    _$BaseResponseFollowStatsResponse
  ];

  @override
  final String wireName = r'BaseResponseFollowStatsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseFollowStatsResponse object, {
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
        specifiedType: const FullType(FollowStatsResponse),
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
    BaseResponseFollowStatsResponse object, {
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
    required BaseResponseFollowStatsResponseBuilder result,
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
            specifiedType: const FullType(FollowStatsResponse),
          ) as FollowStatsResponse;
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
  BaseResponseFollowStatsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseFollowStatsResponseBuilder();
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
