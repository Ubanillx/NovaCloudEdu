//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'source_scrape_request.g.dart';

/// SourceScrapeRequest
///
/// Properties:
/// * [sourceCode]
/// * [maxArticles]
@BuiltValue()
abstract class SourceScrapeRequest
    implements Built<SourceScrapeRequest, SourceScrapeRequestBuilder> {
  @BuiltValueField(wireName: r'sourceCode')
  String get sourceCode;

  @BuiltValueField(wireName: r'maxArticles')
  int? get maxArticles;

  SourceScrapeRequest._();

  factory SourceScrapeRequest([void updates(SourceScrapeRequestBuilder b)]) =
      _$SourceScrapeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SourceScrapeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SourceScrapeRequest> get serializer =>
      _$SourceScrapeRequestSerializer();
}

class _$SourceScrapeRequestSerializer
    implements PrimitiveSerializer<SourceScrapeRequest> {
  @override
  final Iterable<Type> types = const [
    SourceScrapeRequest,
    _$SourceScrapeRequest
  ];

  @override
  final String wireName = r'SourceScrapeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SourceScrapeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'sourceCode';
    yield serializers.serialize(
      object.sourceCode,
      specifiedType: const FullType(String),
    );
    if (object.maxArticles != null) {
      yield r'maxArticles';
      yield serializers.serialize(
        object.maxArticles,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SourceScrapeRequest object, {
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
    required SourceScrapeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sourceCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceCode = valueDes;
          break;
        case r'maxArticles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxArticles = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SourceScrapeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SourceScrapeRequestBuilder();
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
