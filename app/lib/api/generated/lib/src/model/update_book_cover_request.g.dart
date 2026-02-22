// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_book_cover_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateBookCoverRequest extends UpdateBookCoverRequest {
  @override
  final Uint8List cover;

  factory _$UpdateBookCoverRequest([
    void Function(UpdateBookCoverRequestBuilder)? updates,
  ]) => (UpdateBookCoverRequestBuilder()..update(updates))._build();

  _$UpdateBookCoverRequest._({required this.cover}) : super._();
  @override
  UpdateBookCoverRequest rebuild(
    void Function(UpdateBookCoverRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateBookCoverRequestBuilder toBuilder() =>
      UpdateBookCoverRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateBookCoverRequest && cover == other.cover;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cover.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'UpdateBookCoverRequest',
    )..add('cover', cover)).toString();
  }
}

class UpdateBookCoverRequestBuilder
    implements Builder<UpdateBookCoverRequest, UpdateBookCoverRequestBuilder> {
  _$UpdateBookCoverRequest? _$v;

  Uint8List? _cover;
  Uint8List? get cover => _$this._cover;
  set cover(Uint8List? cover) => _$this._cover = cover;

  UpdateBookCoverRequestBuilder() {
    UpdateBookCoverRequest._defaults(this);
  }

  UpdateBookCoverRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cover = $v.cover;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateBookCoverRequest other) {
    _$v = other as _$UpdateBookCoverRequest;
  }

  @override
  void update(void Function(UpdateBookCoverRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateBookCoverRequest build() => _build();

  _$UpdateBookCoverRequest _build() {
    final _$result =
        _$v ??
        _$UpdateBookCoverRequest._(
          cover: BuiltValueNullFieldError.checkNotNull(
            cover,
            r'UpdateBookCoverRequest',
            'cover',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
