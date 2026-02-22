//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/exam_paper_page_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_exam_paper_page_response.g.dart';

/// BaseResponseExamPaperPageResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseExamPaperPageResponse
    implements
        Built<BaseResponseExamPaperPageResponse,
            BaseResponseExamPaperPageResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  ExamPaperPageResponse? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseExamPaperPageResponse._();

  factory BaseResponseExamPaperPageResponse(
          [void updates(BaseResponseExamPaperPageResponseBuilder b)]) =
      _$BaseResponseExamPaperPageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseExamPaperPageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseExamPaperPageResponse> get serializer =>
      _$BaseResponseExamPaperPageResponseSerializer();
}

class _$BaseResponseExamPaperPageResponseSerializer
    implements PrimitiveSerializer<BaseResponseExamPaperPageResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseExamPaperPageResponse,
    _$BaseResponseExamPaperPageResponse
  ];

  @override
  final String wireName = r'BaseResponseExamPaperPageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseExamPaperPageResponse object, {
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
        specifiedType: const FullType(ExamPaperPageResponse),
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
    BaseResponseExamPaperPageResponse object, {
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
    required BaseResponseExamPaperPageResponseBuilder result,
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
            specifiedType: const FullType(ExamPaperPageResponse),
          ) as ExamPaperPageResponse;
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
  BaseResponseExamPaperPageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseExamPaperPageResponseBuilder();
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
