// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ppt_generate_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PptGenerateResponse extends PptGenerateResponse {
  @override
  final String? fileUrl;
  @override
  final String? fileName;
  @override
  final int? slideCount;

  factory _$PptGenerateResponse([
    void Function(PptGenerateResponseBuilder)? updates,
  ]) => (PptGenerateResponseBuilder()..update(updates))._build();

  _$PptGenerateResponse._({this.fileUrl, this.fileName, this.slideCount})
    : super._();
  @override
  PptGenerateResponse rebuild(
    void Function(PptGenerateResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PptGenerateResponseBuilder toBuilder() =>
      PptGenerateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PptGenerateResponse &&
        fileUrl == other.fileUrl &&
        fileName == other.fileName &&
        slideCount == other.slideCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fileUrl.hashCode);
    _$hash = $jc(_$hash, fileName.hashCode);
    _$hash = $jc(_$hash, slideCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PptGenerateResponse')
          ..add('fileUrl', fileUrl)
          ..add('fileName', fileName)
          ..add('slideCount', slideCount))
        .toString();
  }
}

class PptGenerateResponseBuilder
    implements Builder<PptGenerateResponse, PptGenerateResponseBuilder> {
  _$PptGenerateResponse? _$v;

  String? _fileUrl;
  String? get fileUrl => _$this._fileUrl;
  set fileUrl(String? fileUrl) => _$this._fileUrl = fileUrl;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  int? _slideCount;
  int? get slideCount => _$this._slideCount;
  set slideCount(int? slideCount) => _$this._slideCount = slideCount;

  PptGenerateResponseBuilder() {
    PptGenerateResponse._defaults(this);
  }

  PptGenerateResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fileUrl = $v.fileUrl;
      _fileName = $v.fileName;
      _slideCount = $v.slideCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PptGenerateResponse other) {
    _$v = other as _$PptGenerateResponse;
  }

  @override
  void update(void Function(PptGenerateResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PptGenerateResponse build() => _build();

  _$PptGenerateResponse _build() {
    final _$result =
        _$v ??
        _$PptGenerateResponse._(
          fileUrl: fileUrl,
          fileName: fileName,
          slideCount: slideCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
