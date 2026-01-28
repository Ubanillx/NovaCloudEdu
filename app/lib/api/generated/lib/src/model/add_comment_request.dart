//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_comment_request.g.dart';

/// 添加评论请求
///
/// Properties:
/// * [content] - 评论内容
@BuiltValue()
abstract class AddCommentRequest
    implements Built<AddCommentRequest, AddCommentRequestBuilder> {
  /// 评论内容
  @BuiltValueField(wireName: r'content')
  String get content;

  AddCommentRequest._();

  factory AddCommentRequest([void updates(AddCommentRequestBuilder b)]) =
      _$AddCommentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddCommentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddCommentRequest> get serializer =>
      _$AddCommentRequestSerializer();
}

class _$AddCommentRequestSerializer
    implements PrimitiveSerializer<AddCommentRequest> {
  @override
  final Iterable<Type> types = const [AddCommentRequest, _$AddCommentRequest];

  @override
  final String wireName = r'AddCommentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddCommentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AddCommentRequest object, {
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
    required AddCommentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddCommentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddCommentRequestBuilder();
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
