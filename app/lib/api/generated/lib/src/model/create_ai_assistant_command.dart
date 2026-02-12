//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_ai_assistant_command.g.dart';

/// CreateAiAssistantCommand
///
/// Properties:
/// * [name]
/// * [description]
/// * [avatarUrl]
/// * [tags]
/// * [category]
/// * [systemPrompt]
/// * [openingMessage]
/// * [suggestedQuestions]
/// * [modelName]
/// * [temperature]
/// * [topP]
/// * [maxTokens]
/// * [knowledgeBaseIds]
/// * [mcpServerIds]
@BuiltValue()
abstract class CreateAiAssistantCommand
    implements
        Built<CreateAiAssistantCommand, CreateAiAssistantCommandBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'avatarUrl')
  String? get avatarUrl;

  @BuiltValueField(wireName: r'tags')
  BuiltList<String>? get tags;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'systemPrompt')
  String? get systemPrompt;

  @BuiltValueField(wireName: r'openingMessage')
  String? get openingMessage;

  @BuiltValueField(wireName: r'suggestedQuestions')
  BuiltList<String>? get suggestedQuestions;

  @BuiltValueField(wireName: r'modelName')
  String? get modelName;

  @BuiltValueField(wireName: r'temperature')
  num? get temperature;

  @BuiltValueField(wireName: r'topP')
  num? get topP;

  @BuiltValueField(wireName: r'maxTokens')
  int? get maxTokens;

  @BuiltValueField(wireName: r'knowledgeBaseIds')
  BuiltList<int>? get knowledgeBaseIds;

  @BuiltValueField(wireName: r'mcpServerIds')
  BuiltList<int>? get mcpServerIds;

  CreateAiAssistantCommand._();

  factory CreateAiAssistantCommand(
          [void updates(CreateAiAssistantCommandBuilder b)]) =
      _$CreateAiAssistantCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAiAssistantCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAiAssistantCommand> get serializer =>
      _$CreateAiAssistantCommandSerializer();
}

class _$CreateAiAssistantCommandSerializer
    implements PrimitiveSerializer<CreateAiAssistantCommand> {
  @override
  final Iterable<Type> types = const [
    CreateAiAssistantCommand,
    _$CreateAiAssistantCommand
  ];

  @override
  final String wireName = r'CreateAiAssistantCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAiAssistantCommand object, {
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
    if (object.avatarUrl != null) {
      yield r'avatarUrl';
      yield serializers.serialize(
        object.avatarUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    if (object.systemPrompt != null) {
      yield r'systemPrompt';
      yield serializers.serialize(
        object.systemPrompt,
        specifiedType: const FullType(String),
      );
    }
    if (object.openingMessage != null) {
      yield r'openingMessage';
      yield serializers.serialize(
        object.openingMessage,
        specifiedType: const FullType(String),
      );
    }
    if (object.suggestedQuestions != null) {
      yield r'suggestedQuestions';
      yield serializers.serialize(
        object.suggestedQuestions,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.modelName != null) {
      yield r'modelName';
      yield serializers.serialize(
        object.modelName,
        specifiedType: const FullType(String),
      );
    }
    if (object.temperature != null) {
      yield r'temperature';
      yield serializers.serialize(
        object.temperature,
        specifiedType: const FullType(num),
      );
    }
    if (object.topP != null) {
      yield r'topP';
      yield serializers.serialize(
        object.topP,
        specifiedType: const FullType(num),
      );
    }
    if (object.maxTokens != null) {
      yield r'maxTokens';
      yield serializers.serialize(
        object.maxTokens,
        specifiedType: const FullType(int),
      );
    }
    if (object.knowledgeBaseIds != null) {
      yield r'knowledgeBaseIds';
      yield serializers.serialize(
        object.knowledgeBaseIds,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
    if (object.mcpServerIds != null) {
      yield r'mcpServerIds';
      yield serializers.serialize(
        object.mcpServerIds,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateAiAssistantCommand object, {
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
    required CreateAiAssistantCommandBuilder result,
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
        case r'avatarUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.avatarUrl = valueDes;
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.tags.replace(valueDes);
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'systemPrompt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.systemPrompt = valueDes;
          break;
        case r'openingMessage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.openingMessage = valueDes;
          break;
        case r'suggestedQuestions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.suggestedQuestions.replace(valueDes);
          break;
        case r'modelName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.modelName = valueDes;
          break;
        case r'temperature':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.temperature = valueDes;
          break;
        case r'topP':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.topP = valueDes;
          break;
        case r'maxTokens':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxTokens = valueDes;
          break;
        case r'knowledgeBaseIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.knowledgeBaseIds.replace(valueDes);
          break;
        case r'mcpServerIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.mcpServerIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateAiAssistantCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAiAssistantCommandBuilder();
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
