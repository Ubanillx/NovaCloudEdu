//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/group_message_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_list_group_message_item.g.dart';

/// BaseResponseListGroupMessageItem
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseListGroupMessageItem
    implements
        Built<BaseResponseListGroupMessageItem,
            BaseResponseListGroupMessageItemBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  BuiltList<GroupMessageItem>? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseListGroupMessageItem._();

  factory BaseResponseListGroupMessageItem(
          [void updates(BaseResponseListGroupMessageItemBuilder b)]) =
      _$BaseResponseListGroupMessageItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseListGroupMessageItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseListGroupMessageItem> get serializer =>
      _$BaseResponseListGroupMessageItemSerializer();
}

class _$BaseResponseListGroupMessageItemSerializer
    implements PrimitiveSerializer<BaseResponseListGroupMessageItem> {
  @override
  final Iterable<Type> types = const [
    BaseResponseListGroupMessageItem,
    _$BaseResponseListGroupMessageItem
  ];

  @override
  final String wireName = r'BaseResponseListGroupMessageItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseListGroupMessageItem object, {
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
        specifiedType: const FullType(BuiltList, [FullType(GroupMessageItem)]),
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
    BaseResponseListGroupMessageItem object, {
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
    required BaseResponseListGroupMessageItemBuilder result,
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
            specifiedType:
                const FullType(BuiltList, [FullType(GroupMessageItem)]),
          ) as BuiltList<GroupMessageItem>;
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
  BaseResponseListGroupMessageItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseListGroupMessageItemBuilder();
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
