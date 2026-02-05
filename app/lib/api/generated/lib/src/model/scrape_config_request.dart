//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'scrape_config_request.g.dart';

/// ScrapeConfigRequest
///
/// Properties:
/// * [titleSelector]
/// * [authorSelector]
/// * [sourceSelector]
/// * [contentSelector]
/// * [dateSelector]
/// * [imageSelector]
/// * [linkSelector]
/// * [maxDepth]
/// * [maxPages]
/// * [delayMs]
@BuiltValue()
abstract class ScrapeConfigRequest
    implements Built<ScrapeConfigRequest, ScrapeConfigRequestBuilder> {
  @BuiltValueField(wireName: r'titleSelector')
  String? get titleSelector;

  @BuiltValueField(wireName: r'authorSelector')
  String? get authorSelector;

  @BuiltValueField(wireName: r'sourceSelector')
  String? get sourceSelector;

  @BuiltValueField(wireName: r'contentSelector')
  String? get contentSelector;

  @BuiltValueField(wireName: r'dateSelector')
  String? get dateSelector;

  @BuiltValueField(wireName: r'imageSelector')
  String? get imageSelector;

  @BuiltValueField(wireName: r'linkSelector')
  String? get linkSelector;

  @BuiltValueField(wireName: r'maxDepth')
  int? get maxDepth;

  @BuiltValueField(wireName: r'maxPages')
  int? get maxPages;

  @BuiltValueField(wireName: r'delayMs')
  int? get delayMs;

  ScrapeConfigRequest._();

  factory ScrapeConfigRequest([void updates(ScrapeConfigRequestBuilder b)]) =
      _$ScrapeConfigRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScrapeConfigRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScrapeConfigRequest> get serializer =>
      _$ScrapeConfigRequestSerializer();
}

class _$ScrapeConfigRequestSerializer
    implements PrimitiveSerializer<ScrapeConfigRequest> {
  @override
  final Iterable<Type> types = const [
    ScrapeConfigRequest,
    _$ScrapeConfigRequest
  ];

  @override
  final String wireName = r'ScrapeConfigRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScrapeConfigRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.titleSelector != null) {
      yield r'titleSelector';
      yield serializers.serialize(
        object.titleSelector,
        specifiedType: const FullType(String),
      );
    }
    if (object.authorSelector != null) {
      yield r'authorSelector';
      yield serializers.serialize(
        object.authorSelector,
        specifiedType: const FullType(String),
      );
    }
    if (object.sourceSelector != null) {
      yield r'sourceSelector';
      yield serializers.serialize(
        object.sourceSelector,
        specifiedType: const FullType(String),
      );
    }
    if (object.contentSelector != null) {
      yield r'contentSelector';
      yield serializers.serialize(
        object.contentSelector,
        specifiedType: const FullType(String),
      );
    }
    if (object.dateSelector != null) {
      yield r'dateSelector';
      yield serializers.serialize(
        object.dateSelector,
        specifiedType: const FullType(String),
      );
    }
    if (object.imageSelector != null) {
      yield r'imageSelector';
      yield serializers.serialize(
        object.imageSelector,
        specifiedType: const FullType(String),
      );
    }
    if (object.linkSelector != null) {
      yield r'linkSelector';
      yield serializers.serialize(
        object.linkSelector,
        specifiedType: const FullType(String),
      );
    }
    if (object.maxDepth != null) {
      yield r'maxDepth';
      yield serializers.serialize(
        object.maxDepth,
        specifiedType: const FullType(int),
      );
    }
    if (object.maxPages != null) {
      yield r'maxPages';
      yield serializers.serialize(
        object.maxPages,
        specifiedType: const FullType(int),
      );
    }
    if (object.delayMs != null) {
      yield r'delayMs';
      yield serializers.serialize(
        object.delayMs,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ScrapeConfigRequest object, {
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
    required ScrapeConfigRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'titleSelector':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.titleSelector = valueDes;
          break;
        case r'authorSelector':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authorSelector = valueDes;
          break;
        case r'sourceSelector':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceSelector = valueDes;
          break;
        case r'contentSelector':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contentSelector = valueDes;
          break;
        case r'dateSelector':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.dateSelector = valueDes;
          break;
        case r'imageSelector':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageSelector = valueDes;
          break;
        case r'linkSelector':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.linkSelector = valueDes;
          break;
        case r'maxDepth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxDepth = valueDes;
          break;
        case r'maxPages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxPages = valueDes;
          break;
        case r'delayMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.delayMs = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScrapeConfigRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScrapeConfigRequestBuilder();
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
