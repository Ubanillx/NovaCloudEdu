//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/scrape_config_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'batch_scrape_request.g.dart';

/// BatchScrapeRequest
///
/// Properties:
/// * [urls]
/// * [config]
@BuiltValue()
abstract class BatchScrapeRequest
    implements Built<BatchScrapeRequest, BatchScrapeRequestBuilder> {
  @BuiltValueField(wireName: r'urls')
  BuiltList<String> get urls;

  @BuiltValueField(wireName: r'config')
  ScrapeConfigRequest? get config;

  BatchScrapeRequest._();

  factory BatchScrapeRequest([void updates(BatchScrapeRequestBuilder b)]) =
      _$BatchScrapeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BatchScrapeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BatchScrapeRequest> get serializer =>
      _$BatchScrapeRequestSerializer();
}

class _$BatchScrapeRequestSerializer
    implements PrimitiveSerializer<BatchScrapeRequest> {
  @override
  final Iterable<Type> types = const [BatchScrapeRequest, _$BatchScrapeRequest];

  @override
  final String wireName = r'BatchScrapeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BatchScrapeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'urls';
    yield serializers.serialize(
      object.urls,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    if (object.config != null) {
      yield r'config';
      yield serializers.serialize(
        object.config,
        specifiedType: const FullType(ScrapeConfigRequest),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BatchScrapeRequest object, {
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
    required BatchScrapeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'urls':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.urls.replace(valueDes);
          break;
        case r'config':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ScrapeConfigRequest),
          ) as ScrapeConfigRequest;
          result.config.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BatchScrapeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BatchScrapeRequestBuilder();
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
