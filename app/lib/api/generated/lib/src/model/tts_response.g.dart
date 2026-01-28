// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TtsResponse extends TtsResponse {
  @override
  final String? audioBase64;
  @override
  final String? format;
  @override
  final int? size;
  @override
  final int? durationMs;

  factory _$TtsResponse([void Function(TtsResponseBuilder)? updates]) =>
      (TtsResponseBuilder()..update(updates))._build();

  _$TtsResponse._({this.audioBase64, this.format, this.size, this.durationMs})
    : super._();
  @override
  TtsResponse rebuild(void Function(TtsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TtsResponseBuilder toBuilder() => TtsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TtsResponse &&
        audioBase64 == other.audioBase64 &&
        format == other.format &&
        size == other.size &&
        durationMs == other.durationMs;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, audioBase64.hashCode);
    _$hash = $jc(_$hash, format.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, durationMs.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TtsResponse')
          ..add('audioBase64', audioBase64)
          ..add('format', format)
          ..add('size', size)
          ..add('durationMs', durationMs))
        .toString();
  }
}

class TtsResponseBuilder implements Builder<TtsResponse, TtsResponseBuilder> {
  _$TtsResponse? _$v;

  String? _audioBase64;
  String? get audioBase64 => _$this._audioBase64;
  set audioBase64(String? audioBase64) => _$this._audioBase64 = audioBase64;

  String? _format;
  String? get format => _$this._format;
  set format(String? format) => _$this._format = format;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  int? _durationMs;
  int? get durationMs => _$this._durationMs;
  set durationMs(int? durationMs) => _$this._durationMs = durationMs;

  TtsResponseBuilder() {
    TtsResponse._defaults(this);
  }

  TtsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _audioBase64 = $v.audioBase64;
      _format = $v.format;
      _size = $v.size;
      _durationMs = $v.durationMs;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TtsResponse other) {
    _$v = other as _$TtsResponse;
  }

  @override
  void update(void Function(TtsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TtsResponse build() => _build();

  _$TtsResponse _build() {
    final _$result =
        _$v ??
        _$TtsResponse._(
          audioBase64: audioBase64,
          format: format,
          size: size,
          durationMs: durationMs,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
