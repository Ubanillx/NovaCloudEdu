//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tts_request.g.dart';

/// 语音合成请求
///
/// Properties:
/// * [text] - 要合成的文本
/// * [voice] - 发音人，可选值: xiaoyun, xiaogang, ruoxi 等
/// * [volume] - 音量 (0-100)
/// * [speechRate] - 语速 (-500 到 500)
/// * [pitchRate] - 语调 (-500 到 500)
/// * [format] - 音频格式: pcm, wav, mp3
@BuiltValue()
abstract class TtsRequest implements Built<TtsRequest, TtsRequestBuilder> {
  /// 要合成的文本
  @BuiltValueField(wireName: r'text')
  String get text;

  /// 发音人，可选值: xiaoyun, xiaogang, ruoxi 等
  @BuiltValueField(wireName: r'voice')
  String? get voice;

  /// 音量 (0-100)
  @BuiltValueField(wireName: r'volume')
  int? get volume;

  /// 语速 (-500 到 500)
  @BuiltValueField(wireName: r'speechRate')
  int? get speechRate;

  /// 语调 (-500 到 500)
  @BuiltValueField(wireName: r'pitchRate')
  int? get pitchRate;

  /// 音频格式: pcm, wav, mp3
  @BuiltValueField(wireName: r'format')
  String? get format;

  TtsRequest._();

  factory TtsRequest([void updates(TtsRequestBuilder b)]) = _$TtsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TtsRequestBuilder b) => b..format = 'mp3';

  @BuiltValueSerializer(custom: true)
  static Serializer<TtsRequest> get serializer => _$TtsRequestSerializer();
}

class _$TtsRequestSerializer implements PrimitiveSerializer<TtsRequest> {
  @override
  final Iterable<Type> types = const [TtsRequest, _$TtsRequest];

  @override
  final String wireName = r'TtsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TtsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'text';
    yield serializers.serialize(
      object.text,
      specifiedType: const FullType(String),
    );
    if (object.voice != null) {
      yield r'voice';
      yield serializers.serialize(
        object.voice,
        specifiedType: const FullType(String),
      );
    }
    if (object.volume != null) {
      yield r'volume';
      yield serializers.serialize(
        object.volume,
        specifiedType: const FullType(int),
      );
    }
    if (object.speechRate != null) {
      yield r'speechRate';
      yield serializers.serialize(
        object.speechRate,
        specifiedType: const FullType(int),
      );
    }
    if (object.pitchRate != null) {
      yield r'pitchRate';
      yield serializers.serialize(
        object.pitchRate,
        specifiedType: const FullType(int),
      );
    }
    if (object.format != null) {
      yield r'format';
      yield serializers.serialize(
        object.format,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TtsRequest object, {
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
    required TtsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'text':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.text = valueDes;
          break;
        case r'voice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.voice = valueDes;
          break;
        case r'volume':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.volume = valueDes;
          break;
        case r'speechRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.speechRate = valueDes;
          break;
        case r'pitchRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pitchRate = valueDes;
          break;
        case r'format':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.format = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TtsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TtsRequestBuilder();
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
