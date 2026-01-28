//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'daily_word_response.g.dart';

/// 每日单词响应
///
/// Properties:
/// * [id] - ID
/// * [word] - 单词
/// * [pronunciation] - 音标
/// * [audioUrl] - 发音音频URL
/// * [translation] - 翻译
/// * [example] - 例句
/// * [exampleTranslation] - 例句翻译
/// * [difficulty] - 难度等级
/// * [difficultyDesc] - 难度描述
/// * [category] - 单词分类
/// * [notes] - 单词笔记
/// * [publishDate] - 发布日期
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class DailyWordResponse
    implements Built<DailyWordResponse, DailyWordResponseBuilder> {
  /// ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 单词
  @BuiltValueField(wireName: r'word')
  String? get word;

  /// 音标
  @BuiltValueField(wireName: r'pronunciation')
  String? get pronunciation;

  /// 发音音频URL
  @BuiltValueField(wireName: r'audioUrl')
  String? get audioUrl;

  /// 翻译
  @BuiltValueField(wireName: r'translation')
  String? get translation;

  /// 例句
  @BuiltValueField(wireName: r'example')
  String? get example;

  /// 例句翻译
  @BuiltValueField(wireName: r'exampleTranslation')
  String? get exampleTranslation;

  /// 难度等级
  @BuiltValueField(wireName: r'difficulty')
  int? get difficulty;

  /// 难度描述
  @BuiltValueField(wireName: r'difficultyDesc')
  String? get difficultyDesc;

  /// 单词分类
  @BuiltValueField(wireName: r'category')
  String? get category;

  /// 单词笔记
  @BuiltValueField(wireName: r'notes')
  String? get notes;

  /// 发布日期
  @BuiltValueField(wireName: r'publishDate')
  Date? get publishDate;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  DailyWordResponse._();

  factory DailyWordResponse([void updates(DailyWordResponseBuilder b)]) =
      _$DailyWordResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DailyWordResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DailyWordResponse> get serializer =>
      _$DailyWordResponseSerializer();
}

class _$DailyWordResponseSerializer
    implements PrimitiveSerializer<DailyWordResponse> {
  @override
  final Iterable<Type> types = const [DailyWordResponse, _$DailyWordResponse];

  @override
  final String wireName = r'DailyWordResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DailyWordResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.word != null) {
      yield r'word';
      yield serializers.serialize(
        object.word,
        specifiedType: const FullType(String),
      );
    }
    if (object.pronunciation != null) {
      yield r'pronunciation';
      yield serializers.serialize(
        object.pronunciation,
        specifiedType: const FullType(String),
      );
    }
    if (object.audioUrl != null) {
      yield r'audioUrl';
      yield serializers.serialize(
        object.audioUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.translation != null) {
      yield r'translation';
      yield serializers.serialize(
        object.translation,
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
    if (object.difficulty != null) {
      yield r'difficulty';
      yield serializers.serialize(
        object.difficulty,
        specifiedType: const FullType(int),
      );
    }
    if (object.difficultyDesc != null) {
      yield r'difficultyDesc';
      yield serializers.serialize(
        object.difficultyDesc,
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
    if (object.publishDate != null) {
      yield r'publishDate';
      yield serializers.serialize(
        object.publishDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DailyWordResponse object, {
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
    required DailyWordResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'word':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.word = valueDes;
          break;
        case r'pronunciation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pronunciation = valueDes;
          break;
        case r'audioUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.audioUrl = valueDes;
          break;
        case r'translation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.translation = valueDes;
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
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficulty = valueDes;
          break;
        case r'difficultyDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.difficultyDesc = valueDes;
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
        case r'publishDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.publishDate = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DailyWordResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DailyWordResponseBuilder();
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
