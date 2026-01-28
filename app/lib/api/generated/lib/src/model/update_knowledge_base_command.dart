//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_knowledge_base_command.g.dart';

/// UpdateKnowledgeBaseCommand
///
/// Properties:
/// * [name]
/// * [description]
/// * [chunkSize]
/// * [chunkOverlap]
@BuiltValue()
abstract class UpdateKnowledgeBaseCommand
    implements
        Built<UpdateKnowledgeBaseCommand, UpdateKnowledgeBaseCommandBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'chunkSize')
  int? get chunkSize;

  @BuiltValueField(wireName: r'chunkOverlap')
  int? get chunkOverlap;

  UpdateKnowledgeBaseCommand._();

  factory UpdateKnowledgeBaseCommand(
          [void updates(UpdateKnowledgeBaseCommandBuilder b)]) =
      _$UpdateKnowledgeBaseCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateKnowledgeBaseCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateKnowledgeBaseCommand> get serializer =>
      _$UpdateKnowledgeBaseCommandSerializer();
}

class _$UpdateKnowledgeBaseCommandSerializer
    implements PrimitiveSerializer<UpdateKnowledgeBaseCommand> {
  @override
  final Iterable<Type> types = const [
    UpdateKnowledgeBaseCommand,
    _$UpdateKnowledgeBaseCommand
  ];

  @override
  final String wireName = r'UpdateKnowledgeBaseCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateKnowledgeBaseCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
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
    UpdateKnowledgeBaseCommand object, {
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
    required UpdateKnowledgeBaseCommandBuilder result,
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
  UpdateKnowledgeBaseCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateKnowledgeBaseCommandBuilder();
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
