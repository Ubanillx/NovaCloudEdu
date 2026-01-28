//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/daily_word_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_word_book_response.g.dart';

/// 用户生词本响应
///
/// Properties:
/// * [id] - ID
/// * [userId] - 用户ID
/// * [wordId] - 单词ID
/// * [learningStatus] - 学习状态
/// * [learningStatusDesc] - 学习状态描述
/// * [collectedTime] - 收藏时间
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
/// * [word]
@BuiltValue()
abstract class UserWordBookResponse
    implements Built<UserWordBookResponse, UserWordBookResponseBuilder> {
  /// ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  /// 单词ID
  @BuiltValueField(wireName: r'wordId')
  int? get wordId;

  /// 学习状态
  @BuiltValueField(wireName: r'learningStatus')
  int? get learningStatus;

  /// 学习状态描述
  @BuiltValueField(wireName: r'learningStatusDesc')
  String? get learningStatusDesc;

  /// 收藏时间
  @BuiltValueField(wireName: r'collectedTime')
  DateTime? get collectedTime;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  @BuiltValueField(wireName: r'word')
  DailyWordResponse? get word;

  UserWordBookResponse._();

  factory UserWordBookResponse([void updates(UserWordBookResponseBuilder b)]) =
      _$UserWordBookResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserWordBookResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserWordBookResponse> get serializer =>
      _$UserWordBookResponseSerializer();
}

class _$UserWordBookResponseSerializer
    implements PrimitiveSerializer<UserWordBookResponse> {
  @override
  final Iterable<Type> types = const [
    UserWordBookResponse,
    _$UserWordBookResponse
  ];

  @override
  final String wireName = r'UserWordBookResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserWordBookResponse object, {
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
    if (object.learningStatus != null) {
      yield r'learningStatus';
      yield serializers.serialize(
        object.learningStatus,
        specifiedType: const FullType(int),
      );
    }
    if (object.learningStatusDesc != null) {
      yield r'learningStatusDesc';
      yield serializers.serialize(
        object.learningStatusDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.collectedTime != null) {
      yield r'collectedTime';
      yield serializers.serialize(
        object.collectedTime,
        specifiedType: const FullType(DateTime),
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
    UserWordBookResponse object, {
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
    required UserWordBookResponseBuilder result,
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
        case r'learningStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.learningStatus = valueDes;
          break;
        case r'learningStatusDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.learningStatusDesc = valueDes;
          break;
        case r'collectedTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.collectedTime = valueDes;
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
  UserWordBookResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserWordBookResponseBuilder();
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
