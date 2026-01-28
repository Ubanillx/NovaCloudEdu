// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_file_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UploadFileRequest extends UploadFileRequest {
  @override
  final Uint8List file;

  factory _$UploadFileRequest([
    void Function(UploadFileRequestBuilder)? updates,
  ]) => (UploadFileRequestBuilder()..update(updates))._build();

  _$UploadFileRequest._({required this.file}) : super._();
  @override
  UploadFileRequest rebuild(void Function(UploadFileRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UploadFileRequestBuilder toBuilder() =>
      UploadFileRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UploadFileRequest && file == other.file;
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
      r'UploadFileRequest',
    )..add('file', file)).toString();
  }
}

class UploadFileRequestBuilder
    implements Builder<UploadFileRequest, UploadFileRequestBuilder> {
  _$UploadFileRequest? _$v;

  Uint8List? _file;
  Uint8List? get file => _$this._file;
  set file(Uint8List? file) => _$this._file = file;

  UploadFileRequestBuilder() {
    UploadFileRequest._defaults(this);
  }

  UploadFileRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _file = $v.file;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UploadFileRequest other) {
    _$v = other as _$UploadFileRequest;
  }

  @override
  void update(void Function(UploadFileRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UploadFileRequest build() => _build();

  _$UploadFileRequest _build() {
    final _$result =
        _$v ??
        _$UploadFileRequest._(
          file: BuiltValueNullFieldError.checkNotNull(
            file,
            r'UploadFileRequest',
            'file',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
