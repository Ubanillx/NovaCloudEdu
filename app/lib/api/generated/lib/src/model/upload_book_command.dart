//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'dart:typed_data';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upload_book_command.g.dart';

/// UploadBookCommand
///
/// Properties:
/// * [file]
/// * [title]
/// * [adminId]
/// * [author]
@BuiltValue()
abstract class UploadBookCommand
    implements Built<UploadBookCommand, UploadBookCommandBuilder> {
  @BuiltValueField(wireName: r'file')
  Uint8List get file;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'adminId')
  int get adminId;

  @BuiltValueField(wireName: r'author')
  String? get author;

  UploadBookCommand._();

  factory UploadBookCommand([void updates(UploadBookCommandBuilder b)]) =
      _$UploadBookCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UploadBookCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UploadBookCommand> get serializer =>
      _$UploadBookCommandSerializer();
}

class _$UploadBookCommandSerializer
    implements PrimitiveSerializer<UploadBookCommand> {
  @override
  final Iterable<Type> types = const [UploadBookCommand, _$UploadBookCommand];

  @override
  final String wireName = r'UploadBookCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UploadBookCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'file';
    yield serializers.serialize(
      object.file,
      specifiedType: const FullType(Uint8List),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'adminId';
    yield serializers.serialize(
      object.adminId,
      specifiedType: const FullType(int),
    );
    if (object.author != null) {
      yield r'author';
      yield serializers.serialize(
        object.author,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UploadBookCommand object, {
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
    required UploadBookCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'file':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Uint8List),
          ) as Uint8List;
          result.file = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'adminId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.adminId = valueDes;
          break;
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.author = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UploadBookCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UploadBookCommandBuilder();
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
