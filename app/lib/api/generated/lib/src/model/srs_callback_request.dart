//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'srs_callback_request.g.dart';

/// SrsCallbackRequest
///
/// Properties:
/// * [action]
/// * [clientId]
/// * [ip]
/// * [vhost]
/// * [app]
/// * [stream]
/// * [param]
/// * [tcUrl]
/// * [pageUrl]
@BuiltValue()
abstract class SrsCallbackRequest
    implements Built<SrsCallbackRequest, SrsCallbackRequestBuilder> {
  @BuiltValueField(wireName: r'action')
  String? get action;

  @BuiltValueField(wireName: r'clientId')
  String? get clientId;

  @BuiltValueField(wireName: r'ip')
  String? get ip;

  @BuiltValueField(wireName: r'vhost')
  String? get vhost;

  @BuiltValueField(wireName: r'app')
  String? get app;

  @BuiltValueField(wireName: r'stream')
  String? get stream;

  @BuiltValueField(wireName: r'param')
  String? get param;

  @BuiltValueField(wireName: r'tcUrl')
  String? get tcUrl;

  @BuiltValueField(wireName: r'pageUrl')
  String? get pageUrl;

  SrsCallbackRequest._();

  factory SrsCallbackRequest([void updates(SrsCallbackRequestBuilder b)]) =
      _$SrsCallbackRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SrsCallbackRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SrsCallbackRequest> get serializer =>
      _$SrsCallbackRequestSerializer();
}

class _$SrsCallbackRequestSerializer
    implements PrimitiveSerializer<SrsCallbackRequest> {
  @override
  final Iterable<Type> types = const [SrsCallbackRequest, _$SrsCallbackRequest];

  @override
  final String wireName = r'SrsCallbackRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SrsCallbackRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.action != null) {
      yield r'action';
      yield serializers.serialize(
        object.action,
        specifiedType: const FullType(String),
      );
    }
    if (object.clientId != null) {
      yield r'clientId';
      yield serializers.serialize(
        object.clientId,
        specifiedType: const FullType(String),
      );
    }
    if (object.ip != null) {
      yield r'ip';
      yield serializers.serialize(
        object.ip,
        specifiedType: const FullType(String),
      );
    }
    if (object.vhost != null) {
      yield r'vhost';
      yield serializers.serialize(
        object.vhost,
        specifiedType: const FullType(String),
      );
    }
    if (object.app != null) {
      yield r'app';
      yield serializers.serialize(
        object.app,
        specifiedType: const FullType(String),
      );
    }
    if (object.stream != null) {
      yield r'stream';
      yield serializers.serialize(
        object.stream,
        specifiedType: const FullType(String),
      );
    }
    if (object.param != null) {
      yield r'param';
      yield serializers.serialize(
        object.param,
        specifiedType: const FullType(String),
      );
    }
    if (object.tcUrl != null) {
      yield r'tcUrl';
      yield serializers.serialize(
        object.tcUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.pageUrl != null) {
      yield r'pageUrl';
      yield serializers.serialize(
        object.pageUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SrsCallbackRequest object, {
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
    required SrsCallbackRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.action = valueDes;
          break;
        case r'clientId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientId = valueDes;
          break;
        case r'ip':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ip = valueDes;
          break;
        case r'vhost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.vhost = valueDes;
          break;
        case r'app':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.app = valueDes;
          break;
        case r'stream':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.stream = valueDes;
          break;
        case r'param':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.param = valueDes;
          break;
        case r'tcUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tcUrl = valueDes;
          break;
        case r'pageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pageUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SrsCallbackRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SrsCallbackRequestBuilder();
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
