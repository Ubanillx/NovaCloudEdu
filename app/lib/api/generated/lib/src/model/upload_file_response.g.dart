// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_file_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UploadFileResponse extends UploadFileResponse {
  @override
  final String? fileUrl;
  @override
  final String? fileName;
  @override
  final String? originalName;
  @override
  final int? fileSize;
  @override
  final String? businessType;

  factory _$UploadFileResponse([
    void Function(UploadFileResponseBuilder)? updates,
  ]) => (UploadFileResponseBuilder()..update(updates))._build();

  _$UploadFileResponse._({
    this.fileUrl,
    this.fileName,
    this.originalName,
    this.fileSize,
    this.businessType,
  }) : super._();
  @override
  UploadFileResponse rebuild(
    void Function(UploadFileResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UploadFileResponseBuilder toBuilder() =>
      UploadFileResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UploadFileResponse &&
        fileUrl == other.fileUrl &&
        fileName == other.fileName &&
        originalName == other.originalName &&
        fileSize == other.fileSize &&
        businessType == other.businessType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fileUrl.hashCode);
    _$hash = $jc(_$hash, fileName.hashCode);
    _$hash = $jc(_$hash, originalName.hashCode);
    _$hash = $jc(_$hash, fileSize.hashCode);
    _$hash = $jc(_$hash, businessType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UploadFileResponse')
          ..add('fileUrl', fileUrl)
          ..add('fileName', fileName)
          ..add('originalName', originalName)
          ..add('fileSize', fileSize)
          ..add('businessType', businessType))
        .toString();
  }
}

class UploadFileResponseBuilder
    implements Builder<UploadFileResponse, UploadFileResponseBuilder> {
  _$UploadFileResponse? _$v;

  String? _fileUrl;
  String? get fileUrl => _$this._fileUrl;
  set fileUrl(String? fileUrl) => _$this._fileUrl = fileUrl;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  String? _originalName;
  String? get originalName => _$this._originalName;
  set originalName(String? originalName) => _$this._originalName = originalName;

  int? _fileSize;
  int? get fileSize => _$this._fileSize;
  set fileSize(int? fileSize) => _$this._fileSize = fileSize;

  String? _businessType;
  String? get businessType => _$this._businessType;
  set businessType(String? businessType) => _$this._businessType = businessType;

  UploadFileResponseBuilder() {
    UploadFileResponse._defaults(this);
  }

  UploadFileResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fileUrl = $v.fileUrl;
      _fileName = $v.fileName;
      _originalName = $v.originalName;
      _fileSize = $v.fileSize;
      _businessType = $v.businessType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UploadFileResponse other) {
    _$v = other as _$UploadFileResponse;
  }

  @override
  void update(void Function(UploadFileResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UploadFileResponse build() => _build();

  _$UploadFileResponse _build() {
    final _$result =
        _$v ??
        _$UploadFileResponse._(
          fileUrl: fileUrl,
          fileName: fileName,
          originalName: originalName,
          fileSize: fileSize,
          businessType: businessType,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
