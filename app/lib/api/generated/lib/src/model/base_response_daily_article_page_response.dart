//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/daily_article_page_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_daily_article_page_response.g.dart';

/// BaseResponseDailyArticlePageResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseDailyArticlePageResponse
    implements
        Built<BaseResponseDailyArticlePageResponse,
            BaseResponseDailyArticlePageResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  DailyArticlePageResponse? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseDailyArticlePageResponse._();

  factory BaseResponseDailyArticlePageResponse(
          [void updates(BaseResponseDailyArticlePageResponseBuilder b)]) =
      _$BaseResponseDailyArticlePageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseDailyArticlePageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseDailyArticlePageResponse> get serializer =>
      _$BaseResponseDailyArticlePageResponseSerializer();
}

class _$BaseResponseDailyArticlePageResponseSerializer
    implements PrimitiveSerializer<BaseResponseDailyArticlePageResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseDailyArticlePageResponse,
    _$BaseResponseDailyArticlePageResponse
  ];

  @override
  final String wireName = r'BaseResponseDailyArticlePageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseDailyArticlePageResponse object, {
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
        specifiedType: const FullType(DailyArticlePageResponse),
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
    BaseResponseDailyArticlePageResponse object, {
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
    required BaseResponseDailyArticlePageResponseBuilder result,
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
            specifiedType: const FullType(DailyArticlePageResponse),
          ) as DailyArticlePageResponse;
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
  BaseResponseDailyArticlePageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseDailyArticlePageResponseBuilder();
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
