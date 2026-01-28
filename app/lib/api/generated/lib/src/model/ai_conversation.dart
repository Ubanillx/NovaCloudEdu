//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/user_id.dart';
import 'package:nova_api/src/model/conversation_message.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/chapter_id.dart';
import 'package:nova_api/src/model/book_id.dart';
import 'package:nova_api/src/model/ai_conversation_id.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ai_conversation.g.dart';

/// AiConversation
///
/// Properties:
/// * [id]
/// * [userId]
/// * [bookId]
/// * [chapterId]
/// * [conversationType]
/// * [messages]
/// * [createTime]
/// * [updateTime]
/// * [messageCount]
@BuiltValue()
abstract class AiConversation
    implements Built<AiConversation, AiConversationBuilder> {
  @BuiltValueField(wireName: r'id')
  AiConversationId? get id;

  @BuiltValueField(wireName: r'userId')
  UserId? get userId;

  @BuiltValueField(wireName: r'bookId')
  BookId? get bookId;

  @BuiltValueField(wireName: r'chapterId')
  ChapterId? get chapterId;

  @BuiltValueField(wireName: r'conversationType')
  AiConversationConversationTypeEnum? get conversationType;
  // enum conversationTypeEnum {  SUMMARY,  QA,  KNOWLEDGE,  QUIZ,  };

  @BuiltValueField(wireName: r'messages')
  BuiltList<ConversationMessage>? get messages;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  @BuiltValueField(wireName: r'messageCount')
  int? get messageCount;

  AiConversation._();

  factory AiConversation([void updates(AiConversationBuilder b)]) =
      _$AiConversation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AiConversationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AiConversation> get serializer =>
      _$AiConversationSerializer();
}

class _$AiConversationSerializer
    implements PrimitiveSerializer<AiConversation> {
  @override
  final Iterable<Type> types = const [AiConversation, _$AiConversation];

  @override
  final String wireName = r'AiConversation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AiConversation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(AiConversationId),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(UserId),
      );
    }
    if (object.bookId != null) {
      yield r'bookId';
      yield serializers.serialize(
        object.bookId,
        specifiedType: const FullType(BookId),
      );
    }
    if (object.chapterId != null) {
      yield r'chapterId';
      yield serializers.serialize(
        object.chapterId,
        specifiedType: const FullType(ChapterId),
      );
    }
    if (object.conversationType != null) {
      yield r'conversationType';
      yield serializers.serialize(
        object.conversationType,
        specifiedType: const FullType(AiConversationConversationTypeEnum),
      );
    }
    if (object.messages != null) {
      yield r'messages';
      yield serializers.serialize(
        object.messages,
        specifiedType:
            const FullType(BuiltList, [FullType(ConversationMessage)]),
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
    if (object.messageCount != null) {
      yield r'messageCount';
      yield serializers.serialize(
        object.messageCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AiConversation object, {
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
    required AiConversationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AiConversationId),
          ) as AiConversationId;
          result.id.replace(valueDes);
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserId),
          ) as UserId;
          result.userId.replace(valueDes);
          break;
        case r'bookId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BookId),
          ) as BookId;
          result.bookId.replace(valueDes);
          break;
        case r'chapterId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChapterId),
          ) as ChapterId;
          result.chapterId.replace(valueDes);
          break;
        case r'conversationType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AiConversationConversationTypeEnum),
          ) as AiConversationConversationTypeEnum;
          result.conversationType = valueDes;
          break;
        case r'messages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(ConversationMessage)]),
          ) as BuiltList<ConversationMessage>;
          result.messages.replace(valueDes);
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
        case r'messageCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.messageCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AiConversation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AiConversationBuilder();
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

class AiConversationConversationTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'SUMMARY')
  static const AiConversationConversationTypeEnum SUMMARY =
      _$aiConversationConversationTypeEnum_SUMMARY;
  @BuiltValueEnumConst(wireName: r'QA')
  static const AiConversationConversationTypeEnum QA =
      _$aiConversationConversationTypeEnum_QA;
  @BuiltValueEnumConst(wireName: r'KNOWLEDGE')
  static const AiConversationConversationTypeEnum KNOWLEDGE =
      _$aiConversationConversationTypeEnum_KNOWLEDGE;
  @BuiltValueEnumConst(wireName: r'QUIZ')
  static const AiConversationConversationTypeEnum QUIZ =
      _$aiConversationConversationTypeEnum_QUIZ;

  static Serializer<AiConversationConversationTypeEnum> get serializer =>
      _$aiConversationConversationTypeEnumSerializer;

  const AiConversationConversationTypeEnum._(String name) : super(name);

  static BuiltSet<AiConversationConversationTypeEnum> get values =>
      _$aiConversationConversationTypeEnumValues;
  static AiConversationConversationTypeEnum valueOf(String name) =>
      _$aiConversationConversationTypeEnumValueOf(name);
}
