//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'knowledge_profile_response.g.dart';

/// 知识画像响应
///
/// Properties:
/// * [knowledgePoint] - 知识点名称
/// * [subject] - 学科
/// * [masteryLevel] - 掌握度 0.0~1.0
/// * [masteryGrade] - 掌握度等级: EXCELLENT/GOOD/MEDIUM/WEAK/VERY_WEAK
/// * [totalAttempts] - 总答题次数
/// * [correctCount] - 正确次数
/// * [correctRate] - 正确率
/// * [recentErrorCategories] - 近期错误类型
/// * [weakPoint] - 是否薄弱知识点
/// * [lastUpdated] - 最近更新时间
@BuiltValue()
abstract class KnowledgeProfileResponse
    implements
        Built<KnowledgeProfileResponse, KnowledgeProfileResponseBuilder> {
  /// 知识点名称
  @BuiltValueField(wireName: r'knowledgePoint')
  String? get knowledgePoint;

  /// 学科
  @BuiltValueField(wireName: r'subject')
  String? get subject;

  /// 掌握度 0.0~1.0
  @BuiltValueField(wireName: r'masteryLevel')
  double? get masteryLevel;

  /// 掌握度等级: EXCELLENT/GOOD/MEDIUM/WEAK/VERY_WEAK
  @BuiltValueField(wireName: r'masteryGrade')
  String? get masteryGrade;

  /// 总答题次数
  @BuiltValueField(wireName: r'totalAttempts')
  int? get totalAttempts;

  /// 正确次数
  @BuiltValueField(wireName: r'correctCount')
  int? get correctCount;

  /// 正确率
  @BuiltValueField(wireName: r'correctRate')
  double? get correctRate;

  /// 近期错误类型
  @BuiltValueField(wireName: r'recentErrorCategories')
  BuiltList<String>? get recentErrorCategories;

  /// 是否薄弱知识点
  @BuiltValueField(wireName: r'weakPoint')
  bool? get weakPoint;

  /// 最近更新时间
  @BuiltValueField(wireName: r'lastUpdated')
  DateTime? get lastUpdated;

  KnowledgeProfileResponse._();

  factory KnowledgeProfileResponse(
          [void updates(KnowledgeProfileResponseBuilder b)]) =
      _$KnowledgeProfileResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KnowledgeProfileResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KnowledgeProfileResponse> get serializer =>
      _$KnowledgeProfileResponseSerializer();
}

class _$KnowledgeProfileResponseSerializer
    implements PrimitiveSerializer<KnowledgeProfileResponse> {
  @override
  final Iterable<Type> types = const [
    KnowledgeProfileResponse,
    _$KnowledgeProfileResponse
  ];

  @override
  final String wireName = r'KnowledgeProfileResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KnowledgeProfileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.knowledgePoint != null) {
      yield r'knowledgePoint';
      yield serializers.serialize(
        object.knowledgePoint,
        specifiedType: const FullType(String),
      );
    }
    if (object.subject != null) {
      yield r'subject';
      yield serializers.serialize(
        object.subject,
        specifiedType: const FullType(String),
      );
    }
    if (object.masteryLevel != null) {
      yield r'masteryLevel';
      yield serializers.serialize(
        object.masteryLevel,
        specifiedType: const FullType(double),
      );
    }
    if (object.masteryGrade != null) {
      yield r'masteryGrade';
      yield serializers.serialize(
        object.masteryGrade,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalAttempts != null) {
      yield r'totalAttempts';
      yield serializers.serialize(
        object.totalAttempts,
        specifiedType: const FullType(int),
      );
    }
    if (object.correctCount != null) {
      yield r'correctCount';
      yield serializers.serialize(
        object.correctCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.correctRate != null) {
      yield r'correctRate';
      yield serializers.serialize(
        object.correctRate,
        specifiedType: const FullType(double),
      );
    }
    if (object.recentErrorCategories != null) {
      yield r'recentErrorCategories';
      yield serializers.serialize(
        object.recentErrorCategories,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.weakPoint != null) {
      yield r'weakPoint';
      yield serializers.serialize(
        object.weakPoint,
        specifiedType: const FullType(bool),
      );
    }
    if (object.lastUpdated != null) {
      yield r'lastUpdated';
      yield serializers.serialize(
        object.lastUpdated,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KnowledgeProfileResponse object, {
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
    required KnowledgeProfileResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'knowledgePoint':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.knowledgePoint = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'masteryLevel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.masteryLevel = valueDes;
          break;
        case r'masteryGrade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.masteryGrade = valueDes;
          break;
        case r'totalAttempts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalAttempts = valueDes;
          break;
        case r'correctCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.correctCount = valueDes;
          break;
        case r'correctRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.correctRate = valueDes;
          break;
        case r'recentErrorCategories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.recentErrorCategories.replace(valueDes);
          break;
        case r'weakPoint':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.weakPoint = valueDes;
          break;
        case r'lastUpdated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lastUpdated = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KnowledgeProfileResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KnowledgeProfileResponseBuilder();
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
