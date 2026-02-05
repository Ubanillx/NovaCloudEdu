//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'scraper_config_request.g.dart';

/// ScraperConfigRequest
///
/// Properties:
/// * [name]
/// * [sourceCode]
/// * [baseUrl]
/// * [id]
/// * [description]
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
/// * [useDynamic]
/// * [waitForJsMs]
/// * [cronExpression]
/// * [enabled]
/// * [defaultMaxArticles]
/// * [defaultCategory]
/// * [defaultDifficulty]
@BuiltValue()
abstract class ScraperConfigRequest
    implements Built<ScraperConfigRequest, ScraperConfigRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'sourceCode')
  String get sourceCode;

  @BuiltValueField(wireName: r'baseUrl')
  String get baseUrl;

  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'description')
  String? get description;

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

  @BuiltValueField(wireName: r'useDynamic')
  bool? get useDynamic;

  @BuiltValueField(wireName: r'waitForJsMs')
  int? get waitForJsMs;

  @BuiltValueField(wireName: r'cronExpression')
  String? get cronExpression;

  @BuiltValueField(wireName: r'enabled')
  bool? get enabled;

  @BuiltValueField(wireName: r'defaultMaxArticles')
  int? get defaultMaxArticles;

  @BuiltValueField(wireName: r'defaultCategory')
  String? get defaultCategory;

  @BuiltValueField(wireName: r'defaultDifficulty')
  int? get defaultDifficulty;

  ScraperConfigRequest._();

  factory ScraperConfigRequest([void updates(ScraperConfigRequestBuilder b)]) =
      _$ScraperConfigRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScraperConfigRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScraperConfigRequest> get serializer =>
      _$ScraperConfigRequestSerializer();
}

class _$ScraperConfigRequestSerializer
    implements PrimitiveSerializer<ScraperConfigRequest> {
  @override
  final Iterable<Type> types = const [
    ScraperConfigRequest,
    _$ScraperConfigRequest
  ];

  @override
  final String wireName = r'ScraperConfigRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScraperConfigRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'sourceCode';
    yield serializers.serialize(
      object.sourceCode,
      specifiedType: const FullType(String),
    );
    yield r'baseUrl';
    yield serializers.serialize(
      object.baseUrl,
      specifiedType: const FullType(String),
    );
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.useDynamic != null) {
      yield r'useDynamic';
      yield serializers.serialize(
        object.useDynamic,
        specifiedType: const FullType(bool),
      );
    }
    if (object.waitForJsMs != null) {
      yield r'waitForJsMs';
      yield serializers.serialize(
        object.waitForJsMs,
        specifiedType: const FullType(int),
      );
    }
    if (object.cronExpression != null) {
      yield r'cronExpression';
      yield serializers.serialize(
        object.cronExpression,
        specifiedType: const FullType(String),
      );
    }
    if (object.enabled != null) {
      yield r'enabled';
      yield serializers.serialize(
        object.enabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.defaultMaxArticles != null) {
      yield r'defaultMaxArticles';
      yield serializers.serialize(
        object.defaultMaxArticles,
        specifiedType: const FullType(int),
      );
    }
    if (object.defaultCategory != null) {
      yield r'defaultCategory';
      yield serializers.serialize(
        object.defaultCategory,
        specifiedType: const FullType(String),
      );
    }
    if (object.defaultDifficulty != null) {
      yield r'defaultDifficulty';
      yield serializers.serialize(
        object.defaultDifficulty,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ScraperConfigRequest object, {
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
    required ScraperConfigRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'sourceCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceCode = valueDes;
          break;
        case r'baseUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.baseUrl = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
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
        case r'useDynamic':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.useDynamic = valueDes;
          break;
        case r'waitForJsMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.waitForJsMs = valueDes;
          break;
        case r'cronExpression':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cronExpression = valueDes;
          break;
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled = valueDes;
          break;
        case r'defaultMaxArticles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.defaultMaxArticles = valueDes;
          break;
        case r'defaultCategory':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.defaultCategory = valueDes;
          break;
        case r'defaultDifficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.defaultDifficulty = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScraperConfigRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScraperConfigRequestBuilder();
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
