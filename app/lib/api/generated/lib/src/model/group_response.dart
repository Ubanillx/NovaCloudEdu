//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'group_response.g.dart';

/// GroupResponse
///
/// Properties:
/// * [id]
/// * [groupName]
/// * [avatar]
/// * [description]
/// * [ownerId]
/// * [classId]
/// * [maxMembers]
/// * [memberCount]
/// * [inviteMode]
/// * [joinMode]
/// * [announcement]
/// * [announcementTime]
/// * [createTime]
/// * [mute]
@BuiltValue()
abstract class GroupResponse
    implements Built<GroupResponse, GroupResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'groupName')
  String? get groupName;

  @BuiltValueField(wireName: r'avatar')
  String? get avatar;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'ownerId')
  int? get ownerId;

  @BuiltValueField(wireName: r'classId')
  int? get classId;

  @BuiltValueField(wireName: r'maxMembers')
  int? get maxMembers;

  @BuiltValueField(wireName: r'memberCount')
  int? get memberCount;

  @BuiltValueField(wireName: r'inviteMode')
  int? get inviteMode;

  @BuiltValueField(wireName: r'joinMode')
  int? get joinMode;

  @BuiltValueField(wireName: r'announcement')
  String? get announcement;

  @BuiltValueField(wireName: r'announcementTime')
  DateTime? get announcementTime;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'mute')
  bool? get mute;

  GroupResponse._();

  factory GroupResponse([void updates(GroupResponseBuilder b)]) =
      _$GroupResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GroupResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GroupResponse> get serializer =>
      _$GroupResponseSerializer();
}

class _$GroupResponseSerializer implements PrimitiveSerializer<GroupResponse> {
  @override
  final Iterable<Type> types = const [GroupResponse, _$GroupResponse];

  @override
  final String wireName = r'GroupResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GroupResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.groupName != null) {
      yield r'groupName';
      yield serializers.serialize(
        object.groupName,
        specifiedType: const FullType(String),
      );
    }
    if (object.avatar != null) {
      yield r'avatar';
      yield serializers.serialize(
        object.avatar,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.ownerId != null) {
      yield r'ownerId';
      yield serializers.serialize(
        object.ownerId,
        specifiedType: const FullType(int),
      );
    }
    if (object.classId != null) {
      yield r'classId';
      yield serializers.serialize(
        object.classId,
        specifiedType: const FullType(int),
      );
    }
    if (object.maxMembers != null) {
      yield r'maxMembers';
      yield serializers.serialize(
        object.maxMembers,
        specifiedType: const FullType(int),
      );
    }
    if (object.memberCount != null) {
      yield r'memberCount';
      yield serializers.serialize(
        object.memberCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.inviteMode != null) {
      yield r'inviteMode';
      yield serializers.serialize(
        object.inviteMode,
        specifiedType: const FullType(int),
      );
    }
    if (object.joinMode != null) {
      yield r'joinMode';
      yield serializers.serialize(
        object.joinMode,
        specifiedType: const FullType(int),
      );
    }
    if (object.announcement != null) {
      yield r'announcement';
      yield serializers.serialize(
        object.announcement,
        specifiedType: const FullType(String),
      );
    }
    if (object.announcementTime != null) {
      yield r'announcementTime';
      yield serializers.serialize(
        object.announcementTime,
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
    if (object.mute != null) {
      yield r'mute';
      yield serializers.serialize(
        object.mute,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GroupResponse object, {
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
    required GroupResponseBuilder result,
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
        case r'groupName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.groupName = valueDes;
          break;
        case r'avatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.avatar = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'ownerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ownerId = valueDes;
          break;
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.classId = valueDes;
          break;
        case r'maxMembers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxMembers = valueDes;
          break;
        case r'memberCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.memberCount = valueDes;
          break;
        case r'inviteMode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.inviteMode = valueDes;
          break;
        case r'joinMode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.joinMode = valueDes;
          break;
        case r'announcement':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.announcement = valueDes;
          break;
        case r'announcementTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.announcementTime = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'mute':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mute = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GroupResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GroupResponseBuilder();
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
