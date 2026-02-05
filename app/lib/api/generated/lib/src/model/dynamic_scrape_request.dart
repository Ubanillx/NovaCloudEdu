//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/scrape_config_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dynamic_scrape_request.g.dart';

/// DynamicScrapeRequest
///
/// Properties:
/// * [url]
/// * [config]
/// * [recursive]
/// * [maxArticles]
/// * [waitForJsMs]
/// * [waitForSelector]
/// * [timeoutSeconds]
@BuiltValue()
abstract class DynamicScrapeRequest
    implements Built<DynamicScrapeRequest, DynamicScrapeRequestBuilder> {
  @BuiltValueField(wireName: r'url')
  String get url;

  @BuiltValueField(wireName: r'config')
  ScrapeConfigRequest? get config;

  @BuiltValueField(wireName: r'recursive')
  bool? get recursive;

  @BuiltValueField(wireName: r'maxArticles')
  int? get maxArticles;

  @BuiltValueField(wireName: r'waitForJsMs')
  int? get waitForJsMs;

  @BuiltValueField(wireName: r'waitForSelector')
  String? get waitForSelector;

  @BuiltValueField(wireName: r'timeoutSeconds')
  int? get timeoutSeconds;

  DynamicScrapeRequest._();

  factory DynamicScrapeRequest([void updates(DynamicScrapeRequestBuilder b)]) =
      _$DynamicScrapeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DynamicScrapeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DynamicScrapeRequest> get serializer =>
      _$DynamicScrapeRequestSerializer();
}

class _$DynamicScrapeRequestSerializer
    implements PrimitiveSerializer<DynamicScrapeRequest> {
  @override
  final Iterable<Type> types = const [
    DynamicScrapeRequest,
    _$DynamicScrapeRequest
  ];

  @override
  final String wireName = r'DynamicScrapeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DynamicScrapeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
    if (object.config != null) {
      yield r'config';
      yield serializers.serialize(
        object.config,
        specifiedType: const FullType(ScrapeConfigRequest),
      );
    }
    if (object.recursive != null) {
      yield r'recursive';
      yield serializers.serialize(
        object.recursive,
        specifiedType: const FullType(bool),
      );
    }
    if (object.maxArticles != null) {
      yield r'maxArticles';
      yield serializers.serialize(
        object.maxArticles,
        specifiedType: const FullType(int),
      );
    }
    if (object.waitForJsMs != null) {
      yield r'waitForJsMs';
      yield serializers.serialize(
        object.waitForJsMs,
        specifiedType: const FullType(int),
      );
    }
    if (object.waitForSelector != null) {
      yield r'waitForSelector';
      yield serializers.serialize(
        object.waitForSelector,
        specifiedType: const FullType(String),
      );
    }
    if (object.timeoutSeconds != null) {
      yield r'timeoutSeconds';
      yield serializers.serialize(
        object.timeoutSeconds,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DynamicScrapeRequest object, {
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
    required DynamicScrapeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'config':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ScrapeConfigRequest),
          ) as ScrapeConfigRequest;
          result.config.replace(valueDes);
          break;
        case r'recursive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.recursive = valueDes;
          break;
        case r'maxArticles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxArticles = valueDes;
          break;
        case r'waitForJsMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.waitForJsMs = valueDes;
          break;
        case r'waitForSelector':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.waitForSelector = valueDes;
          break;
        case r'timeoutSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.timeoutSeconds = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DynamicScrapeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DynamicScrapeRequestBuilder();
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
