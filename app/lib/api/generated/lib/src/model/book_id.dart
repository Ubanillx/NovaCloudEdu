//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'book_id.g.dart';

/// BookId
///
/// Properties:
/// * [value]
@BuiltValue()
abstract class BookId implements Built<BookId, BookIdBuilder> {
  @BuiltValueField(wireName: r'value')
  int? get value;

  BookId._();

  factory BookId([void updates(BookIdBuilder b)]) = _$BookId;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BookIdBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BookId> get serializer => _$BookIdSerializer();
}

class _$BookIdSerializer implements PrimitiveSerializer<BookId> {
  @override
  final Iterable<Type> types = const [BookId, _$BookId];

  @override
  final String wireName = r'BookId';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BookId object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.value != null) {
      yield r'value';
      yield serializers.serialize(
        object.value,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BookId object, {
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
    required BookIdBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.value = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BookId deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BookIdBuilder();
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
