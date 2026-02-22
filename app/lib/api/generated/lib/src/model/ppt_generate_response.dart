//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ppt_generate_response.g.dart';

/// PPT生成结果
///
/// Properties:
/// * [fileUrl] - 生成的PPTX文件URL
/// * [fileName] - 文件名
/// * [slideCount] - 页数
@BuiltValue()
abstract class PptGenerateResponse
    implements Built<PptGenerateResponse, PptGenerateResponseBuilder> {
  /// 生成的PPTX文件URL
  @BuiltValueField(wireName: r'fileUrl')
  String? get fileUrl;

  /// 文件名
  @BuiltValueField(wireName: r'fileName')
  String? get fileName;

  /// 页数
  @BuiltValueField(wireName: r'slideCount')
  int? get slideCount;

  PptGenerateResponse._();

  factory PptGenerateResponse([void updates(PptGenerateResponseBuilder b)]) =
      _$PptGenerateResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PptGenerateResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PptGenerateResponse> get serializer =>
      _$PptGenerateResponseSerializer();
}

class _$PptGenerateResponseSerializer
    implements PrimitiveSerializer<PptGenerateResponse> {
  @override
  final Iterable<Type> types = const [
    PptGenerateResponse,
    _$PptGenerateResponse
  ];

  @override
  final String wireName = r'PptGenerateResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PptGenerateResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.fileUrl != null) {
      yield r'fileUrl';
      yield serializers.serialize(
        object.fileUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.fileName != null) {
      yield r'fileName';
      yield serializers.serialize(
        object.fileName,
        specifiedType: const FullType(String),
      );
    }
    if (object.slideCount != null) {
      yield r'slideCount';
      yield serializers.serialize(
        object.slideCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PptGenerateResponse object, {
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
    required PptGenerateResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fileUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileUrl = valueDes;
          break;
        case r'fileName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileName = valueDes;
          break;
        case r'slideCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.slideCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PptGenerateResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PptGenerateResponseBuilder();
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
