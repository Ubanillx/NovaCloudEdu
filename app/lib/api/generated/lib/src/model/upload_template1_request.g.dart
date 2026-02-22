// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_template1_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UploadTemplate1Request extends UploadTemplate1Request {
  @override
  final Uint8List file;

  factory _$UploadTemplate1Request([
    void Function(UploadTemplate1RequestBuilder)? updates,
  ]) => (UploadTemplate1RequestBuilder()..update(updates))._build();

  _$UploadTemplate1Request._({required this.file}) : super._();
  @override
  UploadTemplate1Request rebuild(
    void Function(UploadTemplate1RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UploadTemplate1RequestBuilder toBuilder() =>
      UploadTemplate1RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UploadTemplate1Request && file == other.file;
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
      r'UploadTemplate1Request',
    )..add('file', file)).toString();
  }
}

class UploadTemplate1RequestBuilder
    implements Builder<UploadTemplate1Request, UploadTemplate1RequestBuilder> {
  _$UploadTemplate1Request? _$v;

  Uint8List? _file;
  Uint8List? get file => _$this._file;
  set file(Uint8List? file) => _$this._file = file;

  UploadTemplate1RequestBuilder() {
    UploadTemplate1Request._defaults(this);
  }

  UploadTemplate1RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _file = $v.file;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UploadTemplate1Request other) {
    _$v = other as _$UploadTemplate1Request;
  }

  @override
  void update(void Function(UploadTemplate1RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UploadTemplate1Request build() => _build();

  _$UploadTemplate1Request _build() {
    final _$result =
        _$v ??
        _$UploadTemplate1Request._(
          file: BuiltValueNullFieldError.checkNotNull(
            file,
            r'UploadTemplate1Request',
            'file',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
