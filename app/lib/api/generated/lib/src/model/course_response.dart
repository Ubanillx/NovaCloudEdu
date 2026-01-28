//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'course_response.g.dart';

/// 课程信息响应
///
/// Properties:
/// * [id] - 课程ID
/// * [title] - 课程标题
/// * [subtitle] - 课程副标题
/// * [description] - 课程描述
/// * [coverImage] - 封面图片URL
/// * [price] - 课程价格
/// * [courseType] - 课程类型：0-公开课，1-付费课，2-会员课
/// * [courseTypeDesc] - 课程类型描述
/// * [difficulty] - 难度等级：1-入门，2-初级，3-中级，4-高级，5-专家
/// * [difficultyDesc] - 难度等级描述
/// * [status] - 状态：0-未发布，1-已发布，2-已下架
/// * [statusDesc] - 状态描述
/// * [teacherId] - 讲师ID
/// * [totalDuration] - 总时长(分钟)
/// * [totalChapters] - 总章节数
/// * [totalSections] - 总小节数
/// * [studentCount] - 学习人数
/// * [ratingScore] - 评分
/// * [tags] - 标签列表
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class CourseResponse
    implements Built<CourseResponse, CourseResponseBuilder> {
  /// 课程ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 课程标题
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 课程副标题
  @BuiltValueField(wireName: r'subtitle')
  String? get subtitle;

  /// 课程描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 封面图片URL
  @BuiltValueField(wireName: r'coverImage')
  String? get coverImage;

  /// 课程价格
  @BuiltValueField(wireName: r'price')
  num? get price;

  /// 课程类型：0-公开课，1-付费课，2-会员课
  @BuiltValueField(wireName: r'courseType')
  int? get courseType;

  /// 课程类型描述
  @BuiltValueField(wireName: r'courseTypeDesc')
  String? get courseTypeDesc;

  /// 难度等级：1-入门，2-初级，3-中级，4-高级，5-专家
  @BuiltValueField(wireName: r'difficulty')
  int? get difficulty;

  /// 难度等级描述
  @BuiltValueField(wireName: r'difficultyDesc')
  String? get difficultyDesc;

  /// 状态：0-未发布，1-已发布，2-已下架
  @BuiltValueField(wireName: r'status')
  int? get status;

  /// 状态描述
  @BuiltValueField(wireName: r'statusDesc')
  String? get statusDesc;

  /// 讲师ID
  @BuiltValueField(wireName: r'teacherId')
  int? get teacherId;

  /// 总时长(分钟)
  @BuiltValueField(wireName: r'totalDuration')
  int? get totalDuration;

  /// 总章节数
  @BuiltValueField(wireName: r'totalChapters')
  int? get totalChapters;

  /// 总小节数
  @BuiltValueField(wireName: r'totalSections')
  int? get totalSections;

  /// 学习人数
  @BuiltValueField(wireName: r'studentCount')
  int? get studentCount;

  /// 评分
  @BuiltValueField(wireName: r'ratingScore')
  num? get ratingScore;

  /// 标签列表
  @BuiltValueField(wireName: r'tags')
  BuiltList<String>? get tags;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  CourseResponse._();

  factory CourseResponse([void updates(CourseResponseBuilder b)]) =
      _$CourseResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CourseResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CourseResponse> get serializer =>
      _$CourseResponseSerializer();
}

class _$CourseResponseSerializer
    implements PrimitiveSerializer<CourseResponse> {
  @override
  final Iterable<Type> types = const [CourseResponse, _$CourseResponse];

  @override
  final String wireName = r'CourseResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CourseResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.subtitle != null) {
      yield r'subtitle';
      yield serializers.serialize(
        object.subtitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.coverImage != null) {
      yield r'coverImage';
      yield serializers.serialize(
        object.coverImage,
        specifiedType: const FullType(String),
      );
    }
    if (object.price != null) {
      yield r'price';
      yield serializers.serialize(
        object.price,
        specifiedType: const FullType(num),
      );
    }
    if (object.courseType != null) {
      yield r'courseType';
      yield serializers.serialize(
        object.courseType,
        specifiedType: const FullType(int),
      );
    }
    if (object.courseTypeDesc != null) {
      yield r'courseTypeDesc';
      yield serializers.serialize(
        object.courseTypeDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.difficulty != null) {
      yield r'difficulty';
      yield serializers.serialize(
        object.difficulty,
        specifiedType: const FullType(int),
      );
    }
    if (object.difficultyDesc != null) {
      yield r'difficultyDesc';
      yield serializers.serialize(
        object.difficultyDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(int),
      );
    }
    if (object.statusDesc != null) {
      yield r'statusDesc';
      yield serializers.serialize(
        object.statusDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.teacherId != null) {
      yield r'teacherId';
      yield serializers.serialize(
        object.teacherId,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalDuration != null) {
      yield r'totalDuration';
      yield serializers.serialize(
        object.totalDuration,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalChapters != null) {
      yield r'totalChapters';
      yield serializers.serialize(
        object.totalChapters,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalSections != null) {
      yield r'totalSections';
      yield serializers.serialize(
        object.totalSections,
        specifiedType: const FullType(int),
      );
    }
    if (object.studentCount != null) {
      yield r'studentCount';
      yield serializers.serialize(
        object.studentCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.ratingScore != null) {
      yield r'ratingScore';
      yield serializers.serialize(
        object.ratingScore,
        specifiedType: const FullType(num),
      );
    }
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CourseResponse object, {
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
    required CourseResponseBuilder result,
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'subtitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subtitle = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'coverImage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.coverImage = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.price = valueDes;
          break;
        case r'courseType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseType = valueDes;
          break;
        case r'courseTypeDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.courseTypeDesc = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficulty = valueDes;
          break;
        case r'difficultyDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.difficultyDesc = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.status = valueDes;
          break;
        case r'statusDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.statusDesc = valueDes;
          break;
        case r'teacherId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.teacherId = valueDes;
          break;
        case r'totalDuration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalDuration = valueDes;
          break;
        case r'totalChapters':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalChapters = valueDes;
          break;
        case r'totalSections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalSections = valueDes;
          break;
        case r'studentCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentCount = valueDes;
          break;
        case r'ratingScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.ratingScore = valueDes;
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.tags.replace(valueDes);
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CourseResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CourseResponseBuilder();
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
