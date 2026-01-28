// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TtsRequest extends TtsRequest {
  @override
  final String text;
  @override
  final String? voice;
  @override
  final int? volume;
  @override
  final int? speechRate;
  @override
  final int? pitchRate;
  @override
  final String? format;

  factory _$TtsRequest([void Function(TtsRequestBuilder)? updates]) =>
      (TtsRequestBuilder()..update(updates))._build();

  _$TtsRequest._({
    required this.text,
    this.voice,
    this.volume,
    this.speechRate,
    this.pitchRate,
    this.format,
  }) : super._();
  @override
  TtsRequest rebuild(void Function(TtsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TtsRequestBuilder toBuilder() => TtsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TtsRequest &&
        text == other.text &&
        voice == other.voice &&
        volume == other.volume &&
        speechRate == other.speechRate &&
        pitchRate == other.pitchRate &&
        format == other.format;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, voice.hashCode);
    _$hash = $jc(_$hash, volume.hashCode);
    _$hash = $jc(_$hash, speechRate.hashCode);
    _$hash = $jc(_$hash, pitchRate.hashCode);
    _$hash = $jc(_$hash, format.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TtsRequest')
          ..add('text', text)
          ..add('voice', voice)
          ..add('volume', volume)
          ..add('speechRate', speechRate)
          ..add('pitchRate', pitchRate)
          ..add('format', format))
        .toString();
  }
}

class TtsRequestBuilder implements Builder<TtsRequest, TtsRequestBuilder> {
  _$TtsRequest? _$v;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _voice;
  String? get voice => _$this._voice;
  set voice(String? voice) => _$this._voice = voice;

  int? _volume;
  int? get volume => _$this._volume;
  set volume(int? volume) => _$this._volume = volume;

  int? _speechRate;
  int? get speechRate => _$this._speechRate;
  set speechRate(int? speechRate) => _$this._speechRate = speechRate;

  int? _pitchRate;
  int? get pitchRate => _$this._pitchRate;
  set pitchRate(int? pitchRate) => _$this._pitchRate = pitchRate;

  String? _format;
  String? get format => _$this._format;
  set format(String? format) => _$this._format = format;

  TtsRequestBuilder() {
    TtsRequest._defaults(this);
  }

  TtsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _text = $v.text;
      _voice = $v.voice;
      _volume = $v.volume;
      _speechRate = $v.speechRate;
      _pitchRate = $v.pitchRate;
      _format = $v.format;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TtsRequest other) {
    _$v = other as _$TtsRequest;
  }

  @override
  void update(void Function(TtsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TtsRequest build() => _build();

  _$TtsRequest _build() {
    final _$result =
        _$v ??
        _$TtsRequest._(
          text: BuiltValueNullFieldError.checkNotNull(
            text,
            r'TtsRequest',
            'text',
          ),
          voice: voice,
          volume: volume,
          speechRate: speechRate,
          pitchRate: pitchRate,
          format: format,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
