//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/chapter_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_list_chapter_summary.g.dart';

/// BaseResponseListChapterSummary
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseListChapterSummary
    implements
        Built<BaseResponseListChapterSummary,
            BaseResponseListChapterSummaryBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  BuiltList<ChapterSummary>? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseListChapterSummary._();

  factory BaseResponseListChapterSummary(
          [void updates(BaseResponseListChapterSummaryBuilder b)]) =
      _$BaseResponseListChapterSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseListChapterSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseListChapterSummary> get serializer =>
      _$BaseResponseListChapterSummarySerializer();
}

class _$BaseResponseListChapterSummarySerializer
    implements PrimitiveSerializer<BaseResponseListChapterSummary> {
  @override
  final Iterable<Type> types = const [
    BaseResponseListChapterSummary,
    _$BaseResponseListChapterSummary
  ];

  @override
  final String wireName = r'BaseResponseListChapterSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseListChapterSummary object, {
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
        specifiedType: const FullType(BuiltList, [FullType(ChapterSummary)]),
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
    BaseResponseListChapterSummary object, {
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
    required BaseResponseListChapterSummaryBuilder result,
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
            specifiedType:
                const FullType(BuiltList, [FullType(ChapterSummary)]),
          ) as BuiltList<ChapterSummary>;
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
  BaseResponseListChapterSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseListChapterSummaryBuilder();
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
