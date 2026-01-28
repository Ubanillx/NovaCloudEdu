//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'apply_teacher_request.g.dart';

/// 讲师申请请求
///
/// Properties:
/// * [name] - 讲师姓名
/// * [expertise] - 专业领域
/// * [introduction] - 讲师简介
/// * [certificateUrl] - 资质证书URL
@BuiltValue()
abstract class ApplyTeacherRequest
    implements Built<ApplyTeacherRequest, ApplyTeacherRequestBuilder> {
  /// 讲师姓名
  @BuiltValueField(wireName: r'name')
  String get name;

  /// 专业领域
  @BuiltValueField(wireName: r'expertise')
  BuiltList<String> get expertise;

  /// 讲师简介
  @BuiltValueField(wireName: r'introduction')
  String? get introduction;

  /// 资质证书URL
  @BuiltValueField(wireName: r'certificateUrl')
  String? get certificateUrl;

  ApplyTeacherRequest._();

  factory ApplyTeacherRequest([void updates(ApplyTeacherRequestBuilder b)]) =
      _$ApplyTeacherRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApplyTeacherRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApplyTeacherRequest> get serializer =>
      _$ApplyTeacherRequestSerializer();
}

class _$ApplyTeacherRequestSerializer
    implements PrimitiveSerializer<ApplyTeacherRequest> {
  @override
  final Iterable<Type> types = const [
    ApplyTeacherRequest,
    _$ApplyTeacherRequest
  ];

  @override
  final String wireName = r'ApplyTeacherRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApplyTeacherRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'expertise';
    yield serializers.serialize(
      object.expertise,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    if (object.introduction != null) {
      yield r'introduction';
      yield serializers.serialize(
        object.introduction,
        specifiedType: const FullType(String),
      );
    }
    if (object.certificateUrl != null) {
      yield r'certificateUrl';
      yield serializers.serialize(
        object.certificateUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApplyTeacherRequest object, {
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
    required ApplyTeacherRequestBuilder result,
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
        case r'expertise':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.expertise.replace(valueDes);
          break;
        case r'introduction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.introduction = valueDes;
          break;
        case r'certificateUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.certificateUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApplyTeacherRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApplyTeacherRequestBuilder();
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
