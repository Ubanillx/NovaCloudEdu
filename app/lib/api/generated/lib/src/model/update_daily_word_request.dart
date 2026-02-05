//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_daily_word_request.g.dart';

/// 更新每日单词请求
///
/// Properties:
/// * [word] - 单词
/// * [translation] - 翻译
/// * [difficulty] - 难度等级：1-简单，2-中等，3-困难
/// * [publishDate] - 发布日期
/// * [pronunciationUs] - 美式音标
/// * [pronunciationUk] - 英式音标
/// * [audioUrlUs] - 美式发音音频URL
/// * [audioUrlUk] - 英式发音音频URL
/// * [example] - 例句
/// * [exampleTranslation] - 例句翻译
/// * [category] - 单词分类
/// * [notes] - 单词笔记
@BuiltValue()
abstract class UpdateDailyWordRequest
    implements Built<UpdateDailyWordRequest, UpdateDailyWordRequestBuilder> {
  /// 单词
  @BuiltValueField(wireName: r'word')
  String get word;

  /// 翻译
  @BuiltValueField(wireName: r'translation')
  String get translation;

  /// 难度等级：1-简单，2-中等，3-困难
  @BuiltValueField(wireName: r'difficulty')
  int get difficulty;

  /// 发布日期
  @BuiltValueField(wireName: r'publishDate')
  Date get publishDate;

  /// 美式音标
  @BuiltValueField(wireName: r'pronunciationUs')
  String? get pronunciationUs;

  /// 英式音标
  @BuiltValueField(wireName: r'pronunciationUk')
  String? get pronunciationUk;

  /// 美式发音音频URL
  @BuiltValueField(wireName: r'audioUrlUs')
  String? get audioUrlUs;

  /// 英式发音音频URL
  @BuiltValueField(wireName: r'audioUrlUk')
  String? get audioUrlUk;

  /// 例句
  @BuiltValueField(wireName: r'example')
  String? get example;

  /// 例句翻译
  @BuiltValueField(wireName: r'exampleTranslation')
  String? get exampleTranslation;

  /// 单词分类
  @BuiltValueField(wireName: r'category')
  String? get category;

  /// 单词笔记
  @BuiltValueField(wireName: r'notes')
  String? get notes;

  UpdateDailyWordRequest._();

  factory UpdateDailyWordRequest(
          [void updates(UpdateDailyWordRequestBuilder b)]) =
      _$UpdateDailyWordRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateDailyWordRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateDailyWordRequest> get serializer =>
      _$UpdateDailyWordRequestSerializer();
}

class _$UpdateDailyWordRequestSerializer
    implements PrimitiveSerializer<UpdateDailyWordRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateDailyWordRequest,
    _$UpdateDailyWordRequest
  ];

  @override
  final String wireName = r'UpdateDailyWordRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateDailyWordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'word';
    yield serializers.serialize(
      object.word,
      specifiedType: const FullType(String),
    );
    yield r'translation';
    yield serializers.serialize(
      object.translation,
      specifiedType: const FullType(String),
    );
    yield r'difficulty';
    yield serializers.serialize(
      object.difficulty,
      specifiedType: const FullType(int),
    );
    yield r'publishDate';
    yield serializers.serialize(
      object.publishDate,
      specifiedType: const FullType(Date),
    );
    if (object.pronunciationUs != null) {
      yield r'pronunciationUs';
      yield serializers.serialize(
        object.pronunciationUs,
        specifiedType: const FullType(String),
      );
    }
    if (object.pronunciationUk != null) {
      yield r'pronunciationUk';
      yield serializers.serialize(
        object.pronunciationUk,
        specifiedType: const FullType(String),
      );
    }
    if (object.audioUrlUs != null) {
      yield r'audioUrlUs';
      yield serializers.serialize(
        object.audioUrlUs,
        specifiedType: const FullType(String),
      );
    }
    if (object.audioUrlUk != null) {
      yield r'audioUrlUk';
      yield serializers.serialize(
        object.audioUrlUk,
        specifiedType: const FullType(String),
      );
    }
    if (object.example != null) {
      yield r'example';
      yield serializers.serialize(
        object.example,
        specifiedType: const FullType(String),
      );
    }
    if (object.exampleTranslation != null) {
      yield r'exampleTranslation';
      yield serializers.serialize(
        object.exampleTranslation,
        specifiedType: const FullType(String),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateDailyWordRequest object, {
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
    required UpdateDailyWordRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'word':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.word = valueDes;
          break;
        case r'translation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.translation = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficulty = valueDes;
          break;
        case r'publishDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.publishDate = valueDes;
          break;
        case r'pronunciationUs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pronunciationUs = valueDes;
          break;
        case r'pronunciationUk':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pronunciationUk = valueDes;
          break;
        case r'audioUrlUs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.audioUrlUs = valueDes;
          break;
        case r'audioUrlUk':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.audioUrlUk = valueDes;
          break;
        case r'example':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.example = valueDes;
          break;
        case r'exampleTranslation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.exampleTranslation = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.notes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateDailyWordRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateDailyWordRequestBuilder();
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
