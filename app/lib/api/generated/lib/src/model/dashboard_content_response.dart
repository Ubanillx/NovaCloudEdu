//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_content_response.g.dart';

/// DashboardContentResponse
///
/// Properties:
/// * [totalCourses]
/// * [totalCourseStudents]
/// * [avgCourseRating]
/// * [topCourses]
/// * [totalArticles]
/// * [totalArticleViews]
/// * [totalArticleLikes]
/// * [topArticles]
/// * [totalWords]
/// * [totalExamPapers]
/// * [totalQuestions]
/// * [examPapersBySubject]
/// * [totalBooks]
/// * [totalPosts]
/// * [todayNewPosts]
/// * [totalPostLikes]
/// * [totalPostComments]
/// * [topPosts]
@BuiltValue()
abstract class DashboardContentResponse
    implements
        Built<DashboardContentResponse, DashboardContentResponseBuilder> {
  @BuiltValueField(wireName: r'totalCourses')
  int? get totalCourses;

  @BuiltValueField(wireName: r'totalCourseStudents')
  int? get totalCourseStudents;

  @BuiltValueField(wireName: r'avgCourseRating')
  double? get avgCourseRating;

  @BuiltValueField(wireName: r'topCourses')
  BuiltList<BuiltMap<String, JsonObject>>? get topCourses;

  @BuiltValueField(wireName: r'totalArticles')
  int? get totalArticles;

  @BuiltValueField(wireName: r'totalArticleViews')
  int? get totalArticleViews;

  @BuiltValueField(wireName: r'totalArticleLikes')
  int? get totalArticleLikes;

  @BuiltValueField(wireName: r'topArticles')
  BuiltList<BuiltMap<String, JsonObject>>? get topArticles;

  @BuiltValueField(wireName: r'totalWords')
  int? get totalWords;

  @BuiltValueField(wireName: r'totalExamPapers')
  int? get totalExamPapers;

  @BuiltValueField(wireName: r'totalQuestions')
  int? get totalQuestions;

  @BuiltValueField(wireName: r'examPapersBySubject')
  BuiltList<BuiltMap<String, JsonObject>>? get examPapersBySubject;

  @BuiltValueField(wireName: r'totalBooks')
  int? get totalBooks;

  @BuiltValueField(wireName: r'totalPosts')
  int? get totalPosts;

  @BuiltValueField(wireName: r'todayNewPosts')
  int? get todayNewPosts;

  @BuiltValueField(wireName: r'totalPostLikes')
  int? get totalPostLikes;

  @BuiltValueField(wireName: r'totalPostComments')
  int? get totalPostComments;

  @BuiltValueField(wireName: r'topPosts')
  BuiltList<BuiltMap<String, JsonObject>>? get topPosts;

  DashboardContentResponse._();

  factory DashboardContentResponse(
          [void updates(DashboardContentResponseBuilder b)]) =
      _$DashboardContentResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardContentResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardContentResponse> get serializer =>
      _$DashboardContentResponseSerializer();
}

class _$DashboardContentResponseSerializer
    implements PrimitiveSerializer<DashboardContentResponse> {
  @override
  final Iterable<Type> types = const [
    DashboardContentResponse,
    _$DashboardContentResponse
  ];

  @override
  final String wireName = r'DashboardContentResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardContentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.totalCourses != null) {
      yield r'totalCourses';
      yield serializers.serialize(
        object.totalCourses,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalCourseStudents != null) {
      yield r'totalCourseStudents';
      yield serializers.serialize(
        object.totalCourseStudents,
        specifiedType: const FullType(int),
      );
    }
    if (object.avgCourseRating != null) {
      yield r'avgCourseRating';
      yield serializers.serialize(
        object.avgCourseRating,
        specifiedType: const FullType(double),
      );
    }
    if (object.topCourses != null) {
      yield r'topCourses';
      yield serializers.serialize(
        object.topCourses,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.totalArticles != null) {
      yield r'totalArticles';
      yield serializers.serialize(
        object.totalArticles,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalArticleViews != null) {
      yield r'totalArticleViews';
      yield serializers.serialize(
        object.totalArticleViews,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalArticleLikes != null) {
      yield r'totalArticleLikes';
      yield serializers.serialize(
        object.totalArticleLikes,
        specifiedType: const FullType(int),
      );
    }
    if (object.topArticles != null) {
      yield r'topArticles';
      yield serializers.serialize(
        object.topArticles,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.totalWords != null) {
      yield r'totalWords';
      yield serializers.serialize(
        object.totalWords,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalExamPapers != null) {
      yield r'totalExamPapers';
      yield serializers.serialize(
        object.totalExamPapers,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalQuestions != null) {
      yield r'totalQuestions';
      yield serializers.serialize(
        object.totalQuestions,
        specifiedType: const FullType(int),
      );
    }
    if (object.examPapersBySubject != null) {
      yield r'examPapersBySubject';
      yield serializers.serialize(
        object.examPapersBySubject,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.totalBooks != null) {
      yield r'totalBooks';
      yield serializers.serialize(
        object.totalBooks,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalPosts != null) {
      yield r'totalPosts';
      yield serializers.serialize(
        object.totalPosts,
        specifiedType: const FullType(int),
      );
    }
    if (object.todayNewPosts != null) {
      yield r'todayNewPosts';
      yield serializers.serialize(
        object.todayNewPosts,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalPostLikes != null) {
      yield r'totalPostLikes';
      yield serializers.serialize(
        object.totalPostLikes,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalPostComments != null) {
      yield r'totalPostComments';
      yield serializers.serialize(
        object.totalPostComments,
        specifiedType: const FullType(int),
      );
    }
    if (object.topPosts != null) {
      yield r'topPosts';
      yield serializers.serialize(
        object.topPosts,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardContentResponse object, {
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
    required DashboardContentResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'totalCourses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCourses = valueDes;
          break;
        case r'totalCourseStudents':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCourseStudents = valueDes;
          break;
        case r'avgCourseRating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.avgCourseRating = valueDes;
          break;
        case r'topCourses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.topCourses.replace(valueDes);
          break;
        case r'totalArticles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalArticles = valueDes;
          break;
        case r'totalArticleViews':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalArticleViews = valueDes;
          break;
        case r'totalArticleLikes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalArticleLikes = valueDes;
          break;
        case r'topArticles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.topArticles.replace(valueDes);
          break;
        case r'totalWords':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalWords = valueDes;
          break;
        case r'totalExamPapers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalExamPapers = valueDes;
          break;
        case r'totalQuestions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalQuestions = valueDes;
          break;
        case r'examPapersBySubject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.examPapersBySubject.replace(valueDes);
          break;
        case r'totalBooks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalBooks = valueDes;
          break;
        case r'totalPosts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPosts = valueDes;
          break;
        case r'todayNewPosts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todayNewPosts = valueDes;
          break;
        case r'totalPostLikes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPostLikes = valueDes;
          break;
        case r'totalPostComments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPostComments = valueDes;
          break;
        case r'topPosts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.topPosts.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardContentResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardContentResponseBuilder();
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
