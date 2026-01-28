//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/daily_word_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_daily_word_response.g.dart';

/// 用户每日单词响应
///
/// Properties:
/// * [id] - ID
/// * [userId] - 用户ID
/// * [wordId] - 单词ID
/// * [studied] - 是否学习
/// * [collected] - 是否收藏
/// * [masteryLevel] - 掌握程度
/// * [masteryLevelDesc] - 掌握程度描述
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
/// * [word]
@BuiltValue()
abstract class UserDailyWordResponse
    implements Built<UserDailyWordResponse, UserDailyWordResponseBuilder> {
  /// ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  /// 单词ID
  @BuiltValueField(wireName: r'wordId')
  int? get wordId;

  /// 是否学习
  @BuiltValueField(wireName: r'studied')
  bool? get studied;

  /// 是否收藏
  @BuiltValueField(wireName: r'collected')
  bool? get collected;

  /// 掌握程度
  @BuiltValueField(wireName: r'masteryLevel')
  int? get masteryLevel;

  /// 掌握程度描述
  @BuiltValueField(wireName: r'masteryLevelDesc')
  String? get masteryLevelDesc;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  @BuiltValueField(wireName: r'word')
  DailyWordResponse? get word;

  UserDailyWordResponse._();

  factory UserDailyWordResponse(
      [void updates(UserDailyWordResponseBuilder b)]) = _$UserDailyWordResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserDailyWordResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserDailyWordResponse> get serializer =>
      _$UserDailyWordResponseSerializer();
}

class _$UserDailyWordResponseSerializer
    implements PrimitiveSerializer<UserDailyWordResponse> {
  @override
  final Iterable<Type> types = const [
    UserDailyWordResponse,
    _$UserDailyWordResponse
  ];

  @override
  final String wireName = r'UserDailyWordResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserDailyWordResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.wordId != null) {
      yield r'wordId';
      yield serializers.serialize(
        object.wordId,
        specifiedType: const FullType(int),
      );
    }
    if (object.studied != null) {
      yield r'studied';
      yield serializers.serialize(
        object.studied,
        specifiedType: const FullType(bool),
      );
    }
    if (object.collected != null) {
      yield r'collected';
      yield serializers.serialize(
        object.collected,
        specifiedType: const FullType(bool),
      );
    }
    if (object.masteryLevel != null) {
      yield r'masteryLevel';
      yield serializers.serialize(
        object.masteryLevel,
        specifiedType: const FullType(int),
      );
    }
    if (object.masteryLevelDesc != null) {
      yield r'masteryLevelDesc';
      yield serializers.serialize(
        object.masteryLevelDesc,
        specifiedType: const FullType(String),
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
    if (object.word != null) {
      yield r'word';
      yield serializers.serialize(
        object.word,
        specifiedType: const FullType(DailyWordResponse),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserDailyWordResponse object, {
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
    required UserDailyWordResponseBuilder result,
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
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'wordId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.wordId = valueDes;
          break;
        case r'studied':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.studied = valueDes;
          break;
        case r'collected':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.collected = valueDes;
          break;
        case r'masteryLevel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.masteryLevel = valueDes;
          break;
        case r'masteryLevelDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.masteryLevelDesc = valueDes;
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
        case r'word':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyWordResponse),
          ) as DailyWordResponse;
          result.word.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserDailyWordResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserDailyWordResponseBuilder();
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
