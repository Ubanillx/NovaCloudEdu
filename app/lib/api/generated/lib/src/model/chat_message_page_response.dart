//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/chat_message_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat_message_page_response.g.dart';

/// ChatMessagePageResponse
///
/// Properties:
/// * [messages]
/// * [total]
/// * [page]
/// * [size]
/// * [totalPages]
/// * [hasMore]
@BuiltValue()
abstract class ChatMessagePageResponse
    implements Built<ChatMessagePageResponse, ChatMessagePageResponseBuilder> {
  @BuiltValueField(wireName: r'messages')
  BuiltList<ChatMessageResponse>? get messages;

  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'page')
  int? get page;

  @BuiltValueField(wireName: r'size')
  int? get size;

  @BuiltValueField(wireName: r'totalPages')
  int? get totalPages;

  @BuiltValueField(wireName: r'hasMore')
  bool? get hasMore;

  ChatMessagePageResponse._();

  factory ChatMessagePageResponse(
          [void updates(ChatMessagePageResponseBuilder b)]) =
      _$ChatMessagePageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatMessagePageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChatMessagePageResponse> get serializer =>
      _$ChatMessagePageResponseSerializer();
}

class _$ChatMessagePageResponseSerializer
    implements PrimitiveSerializer<ChatMessagePageResponse> {
  @override
  final Iterable<Type> types = const [
    ChatMessagePageResponse,
    _$ChatMessagePageResponse
  ];

  @override
  final String wireName = r'ChatMessagePageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChatMessagePageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.messages != null) {
      yield r'messages';
      yield serializers.serialize(
        object.messages,
        specifiedType:
            const FullType(BuiltList, [FullType(ChatMessageResponse)]),
      );
    }
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
    if (object.page != null) {
      yield r'page';
      yield serializers.serialize(
        object.page,
        specifiedType: const FullType(int),
      );
    }
    if (object.size != null) {
      yield r'size';
      yield serializers.serialize(
        object.size,
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
    if (object.hasMore != null) {
      yield r'hasMore';
      yield serializers.serialize(
        object.hasMore,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChatMessagePageResponse object, {
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
    required ChatMessagePageResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'messages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(ChatMessageResponse)]),
          ) as BuiltList<ChatMessageResponse>;
          result.messages.replace(valueDes);
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        case r'page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.page = valueDes;
          break;
        case r'size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.size = valueDes;
          break;
        case r'totalPages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPages = valueDes;
          break;
        case r'hasMore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasMore = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChatMessagePageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatMessagePageResponseBuilder();
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
