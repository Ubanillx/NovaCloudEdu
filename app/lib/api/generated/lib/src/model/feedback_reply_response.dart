//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'feedback_reply_response.g.dart';

/// FeedbackReplyResponse
///
/// Properties:
/// * [id]
/// * [feedbackId]
/// * [senderId]
/// * [senderRole]
/// * [senderRoleDesc]
/// * [content]
/// * [attachment]
/// * [isRead]
/// * [createTime]
/// * [updateTime]
@BuiltValue()
abstract class FeedbackReplyResponse
    implements Built<FeedbackReplyResponse, FeedbackReplyResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'feedbackId')
  int? get feedbackId;

  @BuiltValueField(wireName: r'senderId')
  int? get senderId;

  @BuiltValueField(wireName: r'senderRole')
  int? get senderRole;

  @BuiltValueField(wireName: r'senderRoleDesc')
  String? get senderRoleDesc;

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'attachment')
  String? get attachment;

  @BuiltValueField(wireName: r'isRead')
  bool? get isRead;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  FeedbackReplyResponse._();

  factory FeedbackReplyResponse(
      [void updates(FeedbackReplyResponseBuilder b)]) = _$FeedbackReplyResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FeedbackReplyResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FeedbackReplyResponse> get serializer =>
      _$FeedbackReplyResponseSerializer();
}

class _$FeedbackReplyResponseSerializer
    implements PrimitiveSerializer<FeedbackReplyResponse> {
  @override
  final Iterable<Type> types = const [
    FeedbackReplyResponse,
    _$FeedbackReplyResponse
  ];

  @override
  final String wireName = r'FeedbackReplyResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FeedbackReplyResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.feedbackId != null) {
      yield r'feedbackId';
      yield serializers.serialize(
        object.feedbackId,
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
    if (object.senderRole != null) {
      yield r'senderRole';
      yield serializers.serialize(
        object.senderRole,
        specifiedType: const FullType(int),
      );
    }
    if (object.senderRoleDesc != null) {
      yield r'senderRoleDesc';
      yield serializers.serialize(
        object.senderRoleDesc,
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
    if (object.attachment != null) {
      yield r'attachment';
      yield serializers.serialize(
        object.attachment,
        specifiedType: const FullType(String),
      );
    }
    if (object.isRead != null) {
      yield r'isRead';
      yield serializers.serialize(
        object.isRead,
        specifiedType: const FullType(bool),
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
    FeedbackReplyResponse object, {
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
    required FeedbackReplyResponseBuilder result,
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
        case r'feedbackId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.feedbackId = valueDes;
          break;
        case r'senderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.senderId = valueDes;
          break;
        case r'senderRole':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.senderRole = valueDes;
          break;
        case r'senderRoleDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.senderRoleDesc = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'attachment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.attachment = valueDes;
          break;
        case r'isRead':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isRead = valueDes;
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
  FeedbackReplyResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FeedbackReplyResponseBuilder();
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
