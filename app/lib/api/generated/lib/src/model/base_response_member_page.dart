//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/member_page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_member_page.g.dart';

/// BaseResponseMemberPage
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseMemberPage
    implements Built<BaseResponseMemberPage, BaseResponseMemberPageBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  MemberPage? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseMemberPage._();

  factory BaseResponseMemberPage(
          [void updates(BaseResponseMemberPageBuilder b)]) =
      _$BaseResponseMemberPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseMemberPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseMemberPage> get serializer =>
      _$BaseResponseMemberPageSerializer();
}

class _$BaseResponseMemberPageSerializer
    implements PrimitiveSerializer<BaseResponseMemberPage> {
  @override
  final Iterable<Type> types = const [
    BaseResponseMemberPage,
    _$BaseResponseMemberPage
  ];

  @override
  final String wireName = r'BaseResponseMemberPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseMemberPage object, {
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
        specifiedType: const FullType(MemberPage),
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
    BaseResponseMemberPage object, {
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
    required BaseResponseMemberPageBuilder result,
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
            specifiedType: const FullType(MemberPage),
          ) as MemberPage;
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
  BaseResponseMemberPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseMemberPageBuilder();
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
