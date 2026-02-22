//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/subject_profile_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_subject_profile_summary.g.dart';

/// BaseResponseSubjectProfileSummary
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseSubjectProfileSummary
    implements
        Built<BaseResponseSubjectProfileSummary,
            BaseResponseSubjectProfileSummaryBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  SubjectProfileSummary? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseSubjectProfileSummary._();

  factory BaseResponseSubjectProfileSummary(
          [void updates(BaseResponseSubjectProfileSummaryBuilder b)]) =
      _$BaseResponseSubjectProfileSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseSubjectProfileSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseSubjectProfileSummary> get serializer =>
      _$BaseResponseSubjectProfileSummarySerializer();
}

class _$BaseResponseSubjectProfileSummarySerializer
    implements PrimitiveSerializer<BaseResponseSubjectProfileSummary> {
  @override
  final Iterable<Type> types = const [
    BaseResponseSubjectProfileSummary,
    _$BaseResponseSubjectProfileSummary
  ];

  @override
  final String wireName = r'BaseResponseSubjectProfileSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseSubjectProfileSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(int),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(SubjectProfileSummary),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BaseResponseSubjectProfileSummary object, {
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
    required BaseResponseSubjectProfileSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.code = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SubjectProfileSummary),
          ) as SubjectProfileSummary;
          result.data.replace(valueDes);
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BaseResponseSubjectProfileSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseSubjectProfileSummaryBuilder();
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
