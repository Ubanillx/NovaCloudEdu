//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_application_response.g.dart';

/// 讲师申请响应
///
/// Properties:
/// * [id] - 申请ID
/// * [userId] - 用户ID
/// * [name] - 讲师姓名
/// * [introduction] - 讲师简介
/// * [expertise] - 专业领域
/// * [certificateUrl] - 资质证书URL
/// * [status] - 状态：0-待审核，1-已通过，2-已拒绝
/// * [statusDesc] - 状态描述
/// * [rejectReason] - 拒绝原因
/// * [reviewerId] - 审核人ID
/// * [reviewTime] - 审核时间
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class TeacherApplicationResponse
    implements
        Built<TeacherApplicationResponse, TeacherApplicationResponseBuilder> {
  /// 申请ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  /// 讲师姓名
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 讲师简介
  @BuiltValueField(wireName: r'introduction')
  String? get introduction;

  /// 专业领域
  @BuiltValueField(wireName: r'expertise')
  BuiltList<String>? get expertise;

  /// 资质证书URL
  @BuiltValueField(wireName: r'certificateUrl')
  String? get certificateUrl;

  /// 状态：0-待审核，1-已通过，2-已拒绝
  @BuiltValueField(wireName: r'status')
  int? get status;

  /// 状态描述
  @BuiltValueField(wireName: r'statusDesc')
  String? get statusDesc;

  /// 拒绝原因
  @BuiltValueField(wireName: r'rejectReason')
  String? get rejectReason;

  /// 审核人ID
  @BuiltValueField(wireName: r'reviewerId')
  int? get reviewerId;

  /// 审核时间
  @BuiltValueField(wireName: r'reviewTime')
  DateTime? get reviewTime;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  TeacherApplicationResponse._();

  factory TeacherApplicationResponse(
          [void updates(TeacherApplicationResponseBuilder b)]) =
      _$TeacherApplicationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherApplicationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherApplicationResponse> get serializer =>
      _$TeacherApplicationResponseSerializer();
}

class _$TeacherApplicationResponseSerializer
    implements PrimitiveSerializer<TeacherApplicationResponse> {
  @override
  final Iterable<Type> types = const [
    TeacherApplicationResponse,
    _$TeacherApplicationResponse
  ];

  @override
  final String wireName = r'TeacherApplicationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherApplicationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.introduction != null) {
      yield r'introduction';
      yield serializers.serialize(
        object.introduction,
        specifiedType: const FullType(String),
      );
    }
    if (object.expertise != null) {
      yield r'expertise';
      yield serializers.serialize(
        object.expertise,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.certificateUrl != null) {
      yield r'certificateUrl';
      yield serializers.serialize(
        object.certificateUrl,
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
    if (object.rejectReason != null) {
      yield r'rejectReason';
      yield serializers.serialize(
        object.rejectReason,
        specifiedType: const FullType(String),
      );
    }
    if (object.reviewerId != null) {
      yield r'reviewerId';
      yield serializers.serialize(
        object.reviewerId,
        specifiedType: const FullType(int),
      );
    }
    if (object.reviewTime != null) {
      yield r'reviewTime';
      yield serializers.serialize(
        object.reviewTime,
        specifiedType: const FullType(DateTime),
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
    TeacherApplicationResponse object, {
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
    required TeacherApplicationResponseBuilder result,
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
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'introduction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.introduction = valueDes;
          break;
        case r'expertise':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.expertise.replace(valueDes);
          break;
        case r'certificateUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.certificateUrl = valueDes;
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
        case r'rejectReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rejectReason = valueDes;
          break;
        case r'reviewerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.reviewerId = valueDes;
          break;
        case r'reviewTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.reviewTime = valueDes;
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
  TeacherApplicationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherApplicationResponseBuilder();
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
