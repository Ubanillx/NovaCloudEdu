//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tts_response.g.dart';

/// 语音合成响应
///
/// Properties:
/// * [audioBase64] - Base64 编码的音频数据
/// * [format] - 音频格式
/// * [size] - 音频数据大小（字节）
/// * [durationMs] - 音频时长（毫秒），如果可用
@BuiltValue()
abstract class TtsResponse implements Built<TtsResponse, TtsResponseBuilder> {
  /// Base64 编码的音频数据
  @BuiltValueField(wireName: r'audioBase64')
  String? get audioBase64;

  /// 音频格式
  @BuiltValueField(wireName: r'format')
  String? get format;

  /// 音频数据大小（字节）
  @BuiltValueField(wireName: r'size')
  int? get size;

  /// 音频时长（毫秒），如果可用
  @BuiltValueField(wireName: r'durationMs')
  int? get durationMs;

  TtsResponse._();

  factory TtsResponse([void updates(TtsResponseBuilder b)]) = _$TtsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TtsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TtsResponse> get serializer => _$TtsResponseSerializer();
}

class _$TtsResponseSerializer implements PrimitiveSerializer<TtsResponse> {
  @override
  final Iterable<Type> types = const [TtsResponse, _$TtsResponse];

  @override
  final String wireName = r'TtsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TtsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.audioBase64 != null) {
      yield r'audioBase64';
      yield serializers.serialize(
        object.audioBase64,
        specifiedType: const FullType(String),
      );
    }
    if (object.format != null) {
      yield r'format';
      yield serializers.serialize(
        object.format,
        specifiedType: const FullType(String),
      );
    }
    if (object.size != null) {
      yield r'size';
      yield serializers.serialize(
        object.size,
        specifiedType: const FullType(int),
      );
    }
    if (object.durationMs != null) {
      yield r'durationMs';
      yield serializers.serialize(
        object.durationMs,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TtsResponse object, {
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
    required TtsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'audioBase64':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.audioBase64 = valueDes;
          break;
        case r'format':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.format = valueDes;
          break;
        case r'size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.size = valueDes;
          break;
        case r'durationMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.durationMs = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TtsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TtsResponseBuilder();
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
