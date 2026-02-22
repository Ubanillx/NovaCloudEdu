// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_avatar_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenerateAvatarRequest extends GenerateAvatarRequest {
  @override
  final String prompt;

  factory _$GenerateAvatarRequest([
    void Function(GenerateAvatarRequestBuilder)? updates,
  ]) => (GenerateAvatarRequestBuilder()..update(updates))._build();

  _$GenerateAvatarRequest._({required this.prompt}) : super._();
  @override
  GenerateAvatarRequest rebuild(
    void Function(GenerateAvatarRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GenerateAvatarRequestBuilder toBuilder() =>
      GenerateAvatarRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateAvatarRequest && prompt == other.prompt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, prompt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GenerateAvatarRequest',
    )..add('prompt', prompt)).toString();
  }
}

class GenerateAvatarRequestBuilder
    implements Builder<GenerateAvatarRequest, GenerateAvatarRequestBuilder> {
  _$GenerateAvatarRequest? _$v;

  String? _prompt;
  String? get prompt => _$this._prompt;
  set prompt(String? prompt) => _$this._prompt = prompt;

  GenerateAvatarRequestBuilder() {
    GenerateAvatarRequest._defaults(this);
  }

  GenerateAvatarRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _prompt = $v.prompt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerateAvatarRequest other) {
    _$v = other as _$GenerateAvatarRequest;
  }

  @override
  void update(void Function(GenerateAvatarRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateAvatarRequest build() => _build();

  _$GenerateAvatarRequest _build() {
    final _$result =
        _$v ??
        _$GenerateAvatarRequest._(
          prompt: BuiltValueNullFieldError.checkNotNull(
            prompt,
            r'GenerateAvatarRequest',
            'prompt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
