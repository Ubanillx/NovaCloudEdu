//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/word_book_stats.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_word_book_stats.g.dart';

/// BaseResponseWordBookStats
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseWordBookStats
    implements
        Built<BaseResponseWordBookStats, BaseResponseWordBookStatsBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  WordBookStats? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseWordBookStats._();

  factory BaseResponseWordBookStats(
          [void updates(BaseResponseWordBookStatsBuilder b)]) =
      _$BaseResponseWordBookStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseWordBookStatsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseWordBookStats> get serializer =>
      _$BaseResponseWordBookStatsSerializer();
}

class _$BaseResponseWordBookStatsSerializer
    implements PrimitiveSerializer<BaseResponseWordBookStats> {
  @override
  final Iterable<Type> types = const [
    BaseResponseWordBookStats,
    _$BaseResponseWordBookStats
  ];

  @override
  final String wireName = r'BaseResponseWordBookStats';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseWordBookStats object, {
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
        specifiedType: const FullType(WordBookStats),
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
    BaseResponseWordBookStats object, {
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
    required BaseResponseWordBookStatsBuilder result,
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
            specifiedType: const FullType(WordBookStats),
          ) as WordBookStats;
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
  BaseResponseWordBookStats deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseWordBookStatsBuilder();
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
