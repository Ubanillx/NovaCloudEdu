//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/user_id.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/group_id.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat_group_member.g.dart';

/// ChatGroupMember
///
/// Properties:
/// * [id]
/// * [groupId]
/// * [memberType]
/// * [userId]
/// * [aiRoleId]
/// * [role]
/// * [nickname]
/// * [muteUntil]
/// * [joinTime]
/// * [updateTime]
/// * [mute]
/// * [adminOrOwner]
/// * [owner]
/// * [delete]
/// * [muted]
@BuiltValue()
abstract class ChatGroupMember
    implements Built<ChatGroupMember, ChatGroupMemberBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'groupId')
  GroupId? get groupId;

  @BuiltValueField(wireName: r'memberType')
  ChatGroupMemberMemberTypeEnum? get memberType;
  // enum memberTypeEnum {  USER,  AI_ROLE,  };

  @BuiltValueField(wireName: r'userId')
  UserId? get userId;

  @BuiltValueField(wireName: r'aiRoleId')
  int? get aiRoleId;

  @BuiltValueField(wireName: r'role')
  ChatGroupMemberRoleEnum? get role;
  // enum roleEnum {  MEMBER,  ADMIN,  OWNER,  };

  @BuiltValueField(wireName: r'nickname')
  String? get nickname;

  @BuiltValueField(wireName: r'muteUntil')
  DateTime? get muteUntil;

  @BuiltValueField(wireName: r'joinTime')
  DateTime? get joinTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  @BuiltValueField(wireName: r'mute')
  bool? get mute;

  @BuiltValueField(wireName: r'adminOrOwner')
  bool? get adminOrOwner;

  @BuiltValueField(wireName: r'owner')
  bool? get owner;

  @BuiltValueField(wireName: r'delete')
  bool? get delete;

  @BuiltValueField(wireName: r'muted')
  bool? get muted;

  ChatGroupMember._();

  factory ChatGroupMember([void updates(ChatGroupMemberBuilder b)]) =
      _$ChatGroupMember;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatGroupMemberBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChatGroupMember> get serializer =>
      _$ChatGroupMemberSerializer();
}

class _$ChatGroupMemberSerializer
    implements PrimitiveSerializer<ChatGroupMember> {
  @override
  final Iterable<Type> types = const [ChatGroupMember, _$ChatGroupMember];

  @override
  final String wireName = r'ChatGroupMember';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChatGroupMember object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.groupId != null) {
      yield r'groupId';
      yield serializers.serialize(
        object.groupId,
        specifiedType: const FullType(GroupId),
      );
    }
    if (object.memberType != null) {
      yield r'memberType';
      yield serializers.serialize(
        object.memberType,
        specifiedType: const FullType(ChatGroupMemberMemberTypeEnum),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(UserId),
      );
    }
    if (object.aiRoleId != null) {
      yield r'aiRoleId';
      yield serializers.serialize(
        object.aiRoleId,
        specifiedType: const FullType(int),
      );
    }
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(ChatGroupMemberRoleEnum),
      );
    }
    if (object.nickname != null) {
      yield r'nickname';
      yield serializers.serialize(
        object.nickname,
        specifiedType: const FullType(String),
      );
    }
    if (object.muteUntil != null) {
      yield r'muteUntil';
      yield serializers.serialize(
        object.muteUntil,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.joinTime != null) {
      yield r'joinTime';
      yield serializers.serialize(
        object.joinTime,
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
    if (object.mute != null) {
      yield r'mute';
      yield serializers.serialize(
        object.mute,
        specifiedType: const FullType(bool),
      );
    }
    if (object.adminOrOwner != null) {
      yield r'adminOrOwner';
      yield serializers.serialize(
        object.adminOrOwner,
        specifiedType: const FullType(bool),
      );
    }
    if (object.owner != null) {
      yield r'owner';
      yield serializers.serialize(
        object.owner,
        specifiedType: const FullType(bool),
      );
    }
    if (object.delete != null) {
      yield r'delete';
      yield serializers.serialize(
        object.delete,
        specifiedType: const FullType(bool),
      );
    }
    if (object.muted != null) {
      yield r'muted';
      yield serializers.serialize(
        object.muted,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChatGroupMember object, {
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
    required ChatGroupMemberBuilder result,
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
        case r'groupId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GroupId),
          ) as GroupId;
          result.groupId.replace(valueDes);
          break;
        case r'memberType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChatGroupMemberMemberTypeEnum),
          ) as ChatGroupMemberMemberTypeEnum;
          result.memberType = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserId),
          ) as UserId;
          result.userId.replace(valueDes);
          break;
        case r'aiRoleId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiRoleId = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChatGroupMemberRoleEnum),
          ) as ChatGroupMemberRoleEnum;
          result.role = valueDes;
          break;
        case r'nickname':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nickname = valueDes;
          break;
        case r'muteUntil':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.muteUntil = valueDes;
          break;
        case r'joinTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.joinTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        case r'mute':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mute = valueDes;
          break;
        case r'adminOrOwner':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.adminOrOwner = valueDes;
          break;
        case r'owner':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.owner = valueDes;
          break;
        case r'delete':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.delete = valueDes;
          break;
        case r'muted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.muted = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChatGroupMember deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatGroupMemberBuilder();
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

class ChatGroupMemberMemberTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USER')
  static const ChatGroupMemberMemberTypeEnum USER =
      _$chatGroupMemberMemberTypeEnum_USER;
  @BuiltValueEnumConst(wireName: r'AI_ROLE')
  static const ChatGroupMemberMemberTypeEnum AI_ROLE =
      _$chatGroupMemberMemberTypeEnum_AI_ROLE;

  static Serializer<ChatGroupMemberMemberTypeEnum> get serializer =>
      _$chatGroupMemberMemberTypeEnumSerializer;

  const ChatGroupMemberMemberTypeEnum._(String name) : super(name);

  static BuiltSet<ChatGroupMemberMemberTypeEnum> get values =>
      _$chatGroupMemberMemberTypeEnumValues;
  static ChatGroupMemberMemberTypeEnum valueOf(String name) =>
      _$chatGroupMemberMemberTypeEnumValueOf(name);
}

class ChatGroupMemberRoleEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'MEMBER')
  static const ChatGroupMemberRoleEnum MEMBER =
      _$chatGroupMemberRoleEnum_MEMBER;
  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const ChatGroupMemberRoleEnum ADMIN = _$chatGroupMemberRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'OWNER')
  static const ChatGroupMemberRoleEnum OWNER = _$chatGroupMemberRoleEnum_OWNER;

  static Serializer<ChatGroupMemberRoleEnum> get serializer =>
      _$chatGroupMemberRoleEnumSerializer;

  const ChatGroupMemberRoleEnum._(String name) : super(name);

  static BuiltSet<ChatGroupMemberRoleEnum> get values =>
      _$chatGroupMemberRoleEnumValues;
  static ChatGroupMemberRoleEnum valueOf(String name) =>
      _$chatGroupMemberRoleEnumValueOf(name);
}
