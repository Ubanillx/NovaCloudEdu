//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/paper_section_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_list_paper_section_response.g.dart';

/// BaseResponseListPaperSectionResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseListPaperSectionResponse
    implements
        Built<BaseResponseListPaperSectionResponse,
            BaseResponseListPaperSectionResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  BuiltList<PaperSectionResponse>? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseListPaperSectionResponse._();

  factory BaseResponseListPaperSectionResponse(
          [void updates(BaseResponseListPaperSectionResponseBuilder b)]) =
      _$BaseResponseListPaperSectionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseListPaperSectionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseListPaperSectionResponse> get serializer =>
      _$BaseResponseListPaperSectionResponseSerializer();
}

class _$BaseResponseListPaperSectionResponseSerializer
    implements PrimitiveSerializer<BaseResponseListPaperSectionResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseListPaperSectionResponse,
    _$BaseResponseListPaperSectionResponse
  ];

  @override
  final String wireName = r'BaseResponseListPaperSectionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseListPaperSectionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(int),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType:
            const FullType(BuiltList, [FullType(PaperSectionResponse)]),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BaseResponseListPaperSectionResponse object, {
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
    required BaseResponseListPaperSectionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.code = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(PaperSectionResponse)]),
          ) as BuiltList<PaperSectionResponse>;
          result.data.replace(valueDes);
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BaseResponseListPaperSectionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseListPaperSectionResponseBuilder();
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
