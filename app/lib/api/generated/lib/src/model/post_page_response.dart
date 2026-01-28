//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/post_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'post_page_response.g.dart';

/// PostPageResponse
///
/// Properties:
/// * [posts]
/// * [total]
/// * [pageNum]
/// * [pageSize]
/// * [totalPages]
@BuiltValue()
abstract class PostPageResponse
    implements Built<PostPageResponse, PostPageResponseBuilder> {
  @BuiltValueField(wireName: r'posts')
  BuiltList<PostResponse>? get posts;

  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  @BuiltValueField(wireName: r'totalPages')
  int? get totalPages;

  PostPageResponse._();

  factory PostPageResponse([void updates(PostPageResponseBuilder b)]) =
      _$PostPageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PostPageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PostPageResponse> get serializer =>
      _$PostPageResponseSerializer();
}

class _$PostPageResponseSerializer
    implements PrimitiveSerializer<PostPageResponse> {
  @override
  final Iterable<Type> types = const [PostPageResponse, _$PostPageResponse];

  @override
  final String wireName = r'PostPageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PostPageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.posts != null) {
      yield r'posts';
      yield serializers.serialize(
        object.posts,
        specifiedType: const FullType(BuiltList, [FullType(PostResponse)]),
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
    PostPageResponse object, {
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
    required PostPageResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'posts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PostResponse)]),
          ) as BuiltList<PostResponse>;
          result.posts.replace(valueDes);
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
  PostPageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PostPageResponseBuilder();
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
