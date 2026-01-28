//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'group_message_item.g.dart';

/// GroupMessageItem
///
/// Properties:
/// * [messageId]
/// * [groupId]
/// * [senderType]
/// * [senderId]
/// * [aiRoleId]
/// * [senderName]
/// * [senderAvatar]
/// * [content]
/// * [type]
/// * [replyTo]
/// * [createTime]
@BuiltValue()
abstract class GroupMessageItem
    implements Built<GroupMessageItem, GroupMessageItemBuilder> {
  @BuiltValueField(wireName: r'messageId')
  int? get messageId;

  @BuiltValueField(wireName: r'groupId')
  int? get groupId;

  @BuiltValueField(wireName: r'senderType')
  int? get senderType;

  @BuiltValueField(wireName: r'senderId')
  int? get senderId;

  @BuiltValueField(wireName: r'aiRoleId')
  int? get aiRoleId;

  @BuiltValueField(wireName: r'senderName')
  String? get senderName;

  @BuiltValueField(wireName: r'senderAvatar')
  String? get senderAvatar;

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'type')
  String? get type;

  @BuiltValueField(wireName: r'replyTo')
  int? get replyTo;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  GroupMessageItem._();

  factory GroupMessageItem([void updates(GroupMessageItemBuilder b)]) =
      _$GroupMessageItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GroupMessageItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GroupMessageItem> get serializer =>
      _$GroupMessageItemSerializer();
}

class _$GroupMessageItemSerializer
    implements PrimitiveSerializer<GroupMessageItem> {
  @override
  final Iterable<Type> types = const [GroupMessageItem, _$GroupMessageItem];

  @override
  final String wireName = r'GroupMessageItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GroupMessageItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.messageId != null) {
      yield r'messageId';
      yield serializers.serialize(
        object.messageId,
        specifiedType: const FullType(int),
      );
    }
    if (object.groupId != null) {
      yield r'groupId';
      yield serializers.serialize(
        object.groupId,
        specifiedType: const FullType(int),
      );
    }
    if (object.senderType != null) {
      yield r'senderType';
      yield serializers.serialize(
        object.senderType,
        specifiedType: const FullType(int),
      );
    }
    if (object.senderId != null) {
      yield r'senderId';
      yield serializers.serialize(
        object.senderId,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiRoleId != null) {
      yield r'aiRoleId';
      yield serializers.serialize(
        object.aiRoleId,
        specifiedType: const FullType(int),
      );
    }
    if (object.senderName != null) {
      yield r'senderName';
      yield serializers.serialize(
        object.senderName,
        specifiedType: const FullType(String),
      );
    }
    if (object.senderAvatar != null) {
      yield r'senderAvatar';
      yield serializers.serialize(
        object.senderAvatar,
        specifiedType: const FullType(String),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(String),
      );
    }
    if (object.replyTo != null) {
      yield r'replyTo';
      yield serializers.serialize(
        object.replyTo,
        specifiedType: const FullType(int),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GroupMessageItem object, {
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
    required GroupMessageItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'messageId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.messageId = valueDes;
          break;
        case r'groupId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.groupId = valueDes;
          break;
        case r'senderType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.senderType = valueDes;
          break;
        case r'senderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.senderId = valueDes;
          break;
        case r'aiRoleId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiRoleId = valueDes;
          break;
        case r'senderName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.senderName = valueDes;
          break;
        case r'senderAvatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.senderAvatar = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'replyTo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.replyTo = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GroupMessageItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GroupMessageItemBuilder();
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
