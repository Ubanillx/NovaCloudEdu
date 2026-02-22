// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_template_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UploadTemplateRequest extends UploadTemplateRequest {
  @override
  final Uint8List file;

  factory _$UploadTemplateRequest([
    void Function(UploadTemplateRequestBuilder)? updates,
  ]) => (UploadTemplateRequestBuilder()..update(updates))._build();

  _$UploadTemplateRequest._({required this.file}) : super._();
  @override
  UploadTemplateRequest rebuild(
    void Function(UploadTemplateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UploadTemplateRequestBuilder toBuilder() =>
      UploadTemplateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UploadTemplateRequest && file == other.file;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, file.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'UploadTemplateRequest',
    )..add('file', file)).toString();
  }
}

class UploadTemplateRequestBuilder
    implements Builder<UploadTemplateRequest, UploadTemplateRequestBuilder> {
  _$UploadTemplateRequest? _$v;

  Uint8List? _file;
  Uint8List? get file => _$this._file;
  set file(Uint8List? file) => _$this._file = file;

  UploadTemplateRequestBuilder() {
    UploadTemplateRequest._defaults(this);
  }

  UploadTemplateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _file = $v.file;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UploadTemplateRequest other) {
    _$v = other as _$UploadTemplateRequest;
  }

  @override
  void update(void Function(UploadTemplateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UploadTemplateRequest build() => _build();

  _$UploadTemplateRequest _build() {
    final _$result =
        _$v ??
        _$UploadTemplateRequest._(
          file: BuiltValueNullFieldError.checkNotNull(
            file,
            r'UploadTemplateRequest',
            'file',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
