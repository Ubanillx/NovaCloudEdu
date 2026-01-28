//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_knowledge_base_command.g.dart';

/// CreateKnowledgeBaseCommand
///
/// Properties:
/// * [name]
/// * [description]
/// * [chunkSize]
/// * [chunkOverlap]
@BuiltValue()
abstract class CreateKnowledgeBaseCommand
    implements
        Built<CreateKnowledgeBaseCommand, CreateKnowledgeBaseCommandBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'chunkSize')
  int? get chunkSize;

  @BuiltValueField(wireName: r'chunkOverlap')
  int? get chunkOverlap;

  CreateKnowledgeBaseCommand._();

  factory CreateKnowledgeBaseCommand(
          [void updates(CreateKnowledgeBaseCommandBuilder b)]) =
      _$CreateKnowledgeBaseCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateKnowledgeBaseCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateKnowledgeBaseCommand> get serializer =>
      _$CreateKnowledgeBaseCommandSerializer();
}

class _$CreateKnowledgeBaseCommandSerializer
    implements PrimitiveSerializer<CreateKnowledgeBaseCommand> {
  @override
  final Iterable<Type> types = const [
    CreateKnowledgeBaseCommand,
    _$CreateKnowledgeBaseCommand
  ];

  @override
  final String wireName = r'CreateKnowledgeBaseCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateKnowledgeBaseCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.chunkSize != null) {
      yield r'chunkSize';
      yield serializers.serialize(
        object.chunkSize,
        specifiedType: const FullType(int),
      );
    }
    if (object.chunkOverlap != null) {
      yield r'chunkOverlap';
      yield serializers.serialize(
        object.chunkOverlap,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateKnowledgeBaseCommand object, {
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
    required CreateKnowledgeBaseCommandBuilder result,
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
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'chunkSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chunkSize = valueDes;
          break;
        case r'chunkOverlap':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chunkOverlap = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateKnowledgeBaseCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateKnowledgeBaseCommandBuilder();
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
