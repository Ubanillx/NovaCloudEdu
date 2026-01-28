//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat_history_request_dto.g.dart';

/// ChatHistoryRequestDTO
///
/// Properties:
/// * [partnerId]
/// * [page]
/// * [size]
/// * [beforeMessageId]
@BuiltValue()
abstract class ChatHistoryRequestDTO
    implements Built<ChatHistoryRequestDTO, ChatHistoryRequestDTOBuilder> {
  @BuiltValueField(wireName: r'partnerId')
  int get partnerId;

  @BuiltValueField(wireName: r'page')
  int? get page;

  @BuiltValueField(wireName: r'size')
  int? get size;

  @BuiltValueField(wireName: r'beforeMessageId')
  int? get beforeMessageId;

  ChatHistoryRequestDTO._();

  factory ChatHistoryRequestDTO(
      [void updates(ChatHistoryRequestDTOBuilder b)]) = _$ChatHistoryRequestDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatHistoryRequestDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChatHistoryRequestDTO> get serializer =>
      _$ChatHistoryRequestDTOSerializer();
}

class _$ChatHistoryRequestDTOSerializer
    implements PrimitiveSerializer<ChatHistoryRequestDTO> {
  @override
  final Iterable<Type> types = const [
    ChatHistoryRequestDTO,
    _$ChatHistoryRequestDTO
  ];

  @override
  final String wireName = r'ChatHistoryRequestDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChatHistoryRequestDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'partnerId';
    yield serializers.serialize(
      object.partnerId,
      specifiedType: const FullType(int),
    );
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
    if (object.beforeMessageId != null) {
      yield r'beforeMessageId';
      yield serializers.serialize(
        object.beforeMessageId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChatHistoryRequestDTO object, {
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
    required ChatHistoryRequestDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'partnerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.partnerId = valueDes;
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
        case r'beforeMessageId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.beforeMessageId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChatHistoryRequestDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatHistoryRequestDTOBuilder();
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
