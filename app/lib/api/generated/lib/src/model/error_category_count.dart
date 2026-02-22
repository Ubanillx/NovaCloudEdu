//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'error_category_count.g.dart';

/// 错因统计项
///
/// Properties:
/// * [category]
/// * [categoryName]
/// * [count]
@BuiltValue()
abstract class ErrorCategoryCount
    implements Built<ErrorCategoryCount, ErrorCategoryCountBuilder> {
  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'categoryName')
  String? get categoryName;

  @BuiltValueField(wireName: r'count')
  int? get count;

  ErrorCategoryCount._();

  factory ErrorCategoryCount([void updates(ErrorCategoryCountBuilder b)]) =
      _$ErrorCategoryCount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ErrorCategoryCountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ErrorCategoryCount> get serializer =>
      _$ErrorCategoryCountSerializer();
}

class _$ErrorCategoryCountSerializer
    implements PrimitiveSerializer<ErrorCategoryCount> {
  @override
  final Iterable<Type> types = const [ErrorCategoryCount, _$ErrorCategoryCount];

  @override
  final String wireName = r'ErrorCategoryCount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ErrorCategoryCount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    if (object.categoryName != null) {
      yield r'categoryName';
      yield serializers.serialize(
        object.categoryName,
        specifiedType: const FullType(String),
      );
    }
    if (object.count != null) {
      yield r'count';
      yield serializers.serialize(
        object.count,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ErrorCategoryCount object, {
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
    required ErrorCategoryCountBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'categoryName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.categoryName = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.count = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ErrorCategoryCount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ErrorCategoryCountBuilder();
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
