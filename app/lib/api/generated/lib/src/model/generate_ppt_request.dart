//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generate_ppt_request.g.dart';

/// 生成PPT请求
///
/// Properties:
/// * [templateId] - 模板ID
/// * [title] - PPT标题
/// * [author] - 作者
/// * [slides] - 每页幻灯片的克隆来源和填充内容
@BuiltValue()
abstract class GeneratePptRequest
    implements Built<GeneratePptRequest, GeneratePptRequestBuilder> {
  /// 模板ID
  @BuiltValueField(wireName: r'templateId')
  int? get templateId;

  /// PPT标题
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 作者
  @BuiltValueField(wireName: r'author')
  String? get author;

  /// 每页幻灯片的克隆来源和填充内容
  @BuiltValueField(wireName: r'slides')
  BuiltList<BuiltMap<String, JsonObject>>? get slides;

  GeneratePptRequest._();

  factory GeneratePptRequest([void updates(GeneratePptRequestBuilder b)]) =
      _$GeneratePptRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GeneratePptRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GeneratePptRequest> get serializer =>
      _$GeneratePptRequestSerializer();
}

class _$GeneratePptRequestSerializer
    implements PrimitiveSerializer<GeneratePptRequest> {
  @override
  final Iterable<Type> types = const [GeneratePptRequest, _$GeneratePptRequest];

  @override
  final String wireName = r'GeneratePptRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GeneratePptRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.templateId != null) {
      yield r'templateId';
      yield serializers.serialize(
        object.templateId,
        specifiedType: const FullType(int),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.author != null) {
      yield r'author';
      yield serializers.serialize(
        object.author,
        specifiedType: const FullType(String),
      );
    }
    if (object.slides != null) {
      yield r'slides';
      yield serializers.serialize(
        object.slides,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GeneratePptRequest object, {
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
    required GeneratePptRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'templateId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.templateId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.author = valueDes;
          break;
        case r'slides':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.slides.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GeneratePptRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GeneratePptRequestBuilder();
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
