//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'scraper_task_response.g.dart';

/// ScraperTaskResponse
///
/// Properties:
/// * [id]
/// * [configId]
/// * [configName]
/// * [status]
/// * [statusDescription]
/// * [totalArticles]
/// * [successCount]
/// * [failCount]
/// * [createdArticleIds]
/// * [errorMessage]
/// * [startTime]
/// * [endTime]
/// * [durationMs]
/// * [createTime]
@BuiltValue()
abstract class ScraperTaskResponse
    implements Built<ScraperTaskResponse, ScraperTaskResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'configId')
  int? get configId;

  @BuiltValueField(wireName: r'configName')
  String? get configName;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'statusDescription')
  String? get statusDescription;

  @BuiltValueField(wireName: r'totalArticles')
  int? get totalArticles;

  @BuiltValueField(wireName: r'successCount')
  int? get successCount;

  @BuiltValueField(wireName: r'failCount')
  int? get failCount;

  @BuiltValueField(wireName: r'createdArticleIds')
  BuiltList<int>? get createdArticleIds;

  @BuiltValueField(wireName: r'errorMessage')
  String? get errorMessage;

  @BuiltValueField(wireName: r'startTime')
  DateTime? get startTime;

  @BuiltValueField(wireName: r'endTime')
  DateTime? get endTime;

  @BuiltValueField(wireName: r'durationMs')
  int? get durationMs;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  ScraperTaskResponse._();

  factory ScraperTaskResponse([void updates(ScraperTaskResponseBuilder b)]) =
      _$ScraperTaskResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScraperTaskResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScraperTaskResponse> get serializer =>
      _$ScraperTaskResponseSerializer();
}

class _$ScraperTaskResponseSerializer
    implements PrimitiveSerializer<ScraperTaskResponse> {
  @override
  final Iterable<Type> types = const [
    ScraperTaskResponse,
    _$ScraperTaskResponse
  ];

  @override
  final String wireName = r'ScraperTaskResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScraperTaskResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.configId != null) {
      yield r'configId';
      yield serializers.serialize(
        object.configId,
        specifiedType: const FullType(int),
      );
    }
    if (object.configName != null) {
      yield r'configName';
      yield serializers.serialize(
        object.configName,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.statusDescription != null) {
      yield r'statusDescription';
      yield serializers.serialize(
        object.statusDescription,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalArticles != null) {
      yield r'totalArticles';
      yield serializers.serialize(
        object.totalArticles,
        specifiedType: const FullType(int),
      );
    }
    if (object.successCount != null) {
      yield r'successCount';
      yield serializers.serialize(
        object.successCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.failCount != null) {
      yield r'failCount';
      yield serializers.serialize(
        object.failCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.createdArticleIds != null) {
      yield r'createdArticleIds';
      yield serializers.serialize(
        object.createdArticleIds,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
    if (object.errorMessage != null) {
      yield r'errorMessage';
      yield serializers.serialize(
        object.errorMessage,
        specifiedType: const FullType(String),
      );
    }
    if (object.startTime != null) {
      yield r'startTime';
      yield serializers.serialize(
        object.startTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.endTime != null) {
      yield r'endTime';
      yield serializers.serialize(
        object.endTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.durationMs != null) {
      yield r'durationMs';
      yield serializers.serialize(
        object.durationMs,
        specifiedType: const FullType(int),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ScraperTaskResponse object, {
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
    required ScraperTaskResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'configId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.configId = valueDes;
          break;
        case r'configName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.configName = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'statusDescription':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.statusDescription = valueDes;
          break;
        case r'totalArticles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalArticles = valueDes;
          break;
        case r'successCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.successCount = valueDes;
          break;
        case r'failCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.failCount = valueDes;
          break;
        case r'createdArticleIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.createdArticleIds.replace(valueDes);
          break;
        case r'errorMessage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errorMessage = valueDes;
          break;
        case r'startTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startTime = valueDes;
          break;
        case r'endTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.endTime = valueDes;
          break;
        case r'durationMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.durationMs = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScraperTaskResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScraperTaskResponseBuilder();
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
