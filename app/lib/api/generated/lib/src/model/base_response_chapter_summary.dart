//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/chapter_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_chapter_summary.g.dart';

/// BaseResponseChapterSummary
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseChapterSummary
    implements
        Built<BaseResponseChapterSummary, BaseResponseChapterSummaryBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  ChapterSummary? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseChapterSummary._();

  factory BaseResponseChapterSummary(
          [void updates(BaseResponseChapterSummaryBuilder b)]) =
      _$BaseResponseChapterSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseChapterSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseChapterSummary> get serializer =>
      _$BaseResponseChapterSummarySerializer();
}

class _$BaseResponseChapterSummarySerializer
    implements PrimitiveSerializer<BaseResponseChapterSummary> {
  @override
  final Iterable<Type> types = const [
    BaseResponseChapterSummary,
    _$BaseResponseChapterSummary
  ];

  @override
  final String wireName = r'BaseResponseChapterSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseChapterSummary object, {
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
        specifiedType: const FullType(ChapterSummary),
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
    BaseResponseChapterSummary object, {
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
    required BaseResponseChapterSummaryBuilder result,
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
            specifiedType: const FullType(ChapterSummary),
          ) as ChapterSummary;
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
  BaseResponseChapterSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseChapterSummaryBuilder();
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
