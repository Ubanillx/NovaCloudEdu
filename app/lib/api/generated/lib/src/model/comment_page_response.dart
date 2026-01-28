//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/comment_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'comment_page_response.g.dart';

/// CommentPageResponse
///
/// Properties:
/// * [comments]
/// * [total]
/// * [pageNum]
/// * [pageSize]
/// * [totalPages]
@BuiltValue()
abstract class CommentPageResponse
    implements Built<CommentPageResponse, CommentPageResponseBuilder> {
  @BuiltValueField(wireName: r'comments')
  BuiltList<CommentResponse>? get comments;

  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  @BuiltValueField(wireName: r'totalPages')
  int? get totalPages;

  CommentPageResponse._();

  factory CommentPageResponse([void updates(CommentPageResponseBuilder b)]) =
      _$CommentPageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CommentPageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CommentPageResponse> get serializer =>
      _$CommentPageResponseSerializer();
}

class _$CommentPageResponseSerializer
    implements PrimitiveSerializer<CommentPageResponse> {
  @override
  final Iterable<Type> types = const [
    CommentPageResponse,
    _$CommentPageResponse
  ];

  @override
  final String wireName = r'CommentPageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CommentPageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.comments != null) {
      yield r'comments';
      yield serializers.serialize(
        object.comments,
        specifiedType: const FullType(BuiltList, [FullType(CommentResponse)]),
      );
    }
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
    if (object.pageNum != null) {
      yield r'pageNum';
      yield serializers.serialize(
        object.pageNum,
        specifiedType: const FullType(int),
      );
    }
    if (object.pageSize != null) {
      yield r'pageSize';
      yield serializers.serialize(
        object.pageSize,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalPages != null) {
      yield r'totalPages';
      yield serializers.serialize(
        object.totalPages,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CommentPageResponse object, {
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
    required CommentPageResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'comments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(CommentResponse)]),
          ) as BuiltList<CommentResponse>;
          result.comments.replace(valueDes);
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        case r'pageNum':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageNum = valueDes;
          break;
        case r'pageSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageSize = valueDes;
          break;
        case r'totalPages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPages = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CommentPageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CommentPageResponseBuilder();
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
