// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_info_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FileInfoResponse extends FileInfoResponse {
  @override
  final int? id;
  @override
  final String? fileName;
  @override
  final String? originalName;
  @override
  final String? fileUrl;
  @override
  final int? fileSize;
  @override
  final String? contentType;
  @override
  final String? businessType;
  @override
  final String? businessTypeDesc;
  @override
  final int? uploaderId;
  @override
  final DateTime? createTime;

  factory _$FileInfoResponse([
    void Function(FileInfoResponseBuilder)? updates,
  ]) => (FileInfoResponseBuilder()..update(updates))._build();

  _$FileInfoResponse._({
    this.id,
    this.fileName,
    this.originalName,
    this.fileUrl,
    this.fileSize,
    this.contentType,
    this.businessType,
    this.businessTypeDesc,
    this.uploaderId,
    this.createTime,
  }) : super._();
  @override
  FileInfoResponse rebuild(void Function(FileInfoResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FileInfoResponseBuilder toBuilder() =>
      FileInfoResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileInfoResponse &&
        id == other.id &&
        fileName == other.fileName &&
        originalName == other.originalName &&
        fileUrl == other.fileUrl &&
        fileSize == other.fileSize &&
        contentType == other.contentType &&
        businessType == other.businessType &&
        businessTypeDesc == other.businessTypeDesc &&
        uploaderId == other.uploaderId &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, fileName.hashCode);
    _$hash = $jc(_$hash, originalName.hashCode);
    _$hash = $jc(_$hash, fileUrl.hashCode);
    _$hash = $jc(_$hash, fileSize.hashCode);
    _$hash = $jc(_$hash, contentType.hashCode);
    _$hash = $jc(_$hash, businessType.hashCode);
    _$hash = $jc(_$hash, businessTypeDesc.hashCode);
    _$hash = $jc(_$hash, uploaderId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FileInfoResponse')
          ..add('id', id)
          ..add('fileName', fileName)
          ..add('originalName', originalName)
          ..add('fileUrl', fileUrl)
          ..add('fileSize', fileSize)
          ..add('contentType', contentType)
          ..add('businessType', businessType)
          ..add('businessTypeDesc', businessTypeDesc)
          ..add('uploaderId', uploaderId)
          ..add('createTime', createTime))
        .toString();
  }
}

class FileInfoResponseBuilder
    implements Builder<FileInfoResponse, FileInfoResponseBuilder> {
  _$FileInfoResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  String? _originalName;
  String? get originalName => _$this._originalName;
  set originalName(String? originalName) => _$this._originalName = originalName;

  String? _fileUrl;
  String? get fileUrl => _$this._fileUrl;
  set fileUrl(String? fileUrl) => _$this._fileUrl = fileUrl;

  int? _fileSize;
  int? get fileSize => _$this._fileSize;
  set fileSize(int? fileSize) => _$this._fileSize = fileSize;

  String? _contentType;
  String? get contentType => _$this._contentType;
  set contentType(String? contentType) => _$this._contentType = contentType;

  String? _businessType;
  String? get businessType => _$this._businessType;
  set businessType(String? businessType) => _$this._businessType = businessType;

  String? _businessTypeDesc;
  String? get businessTypeDesc => _$this._businessTypeDesc;
  set businessTypeDesc(String? businessTypeDesc) =>
      _$this._businessTypeDesc = businessTypeDesc;

  int? _uploaderId;
  int? get uploaderId => _$this._uploaderId;
  set uploaderId(int? uploaderId) => _$this._uploaderId = uploaderId;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  FileInfoResponseBuilder() {
    FileInfoResponse._defaults(this);
  }

  FileInfoResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _fileName = $v.fileName;
      _originalName = $v.originalName;
      _fileUrl = $v.fileUrl;
      _fileSize = $v.fileSize;
      _contentType = $v.contentType;
      _businessType = $v.businessType;
      _businessTypeDesc = $v.businessTypeDesc;
      _uploaderId = $v.uploaderId;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileInfoResponse other) {
    _$v = other as _$FileInfoResponse;
  }

  @override
  void update(void Function(FileInfoResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FileInfoResponse build() => _build();

  _$FileInfoResponse _build() {
    final _$result =
        _$v ??
        _$FileInfoResponse._(
          id: id,
          fileName: fileName,
          originalName: originalName,
          fileUrl: fileUrl,
          fileSize: fileSize,
          contentType: contentType,
          businessType: businessType,
          businessTypeDesc: businessTypeDesc,
          uploaderId: uploaderId,
          createTime: createTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
