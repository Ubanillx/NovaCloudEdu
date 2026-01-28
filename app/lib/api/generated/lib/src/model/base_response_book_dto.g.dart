// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_book_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseBookDTO extends BaseResponseBookDTO {
  @override
  final int? code;
  @override
  final BookDTO? data;
  @override
  final String? message;

  factory _$BaseResponseBookDTO([
    void Function(BaseResponseBookDTOBuilder)? updates,
  ]) => (BaseResponseBookDTOBuilder()..update(updates))._build();

  _$BaseResponseBookDTO._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseBookDTO rebuild(
    void Function(BaseResponseBookDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseBookDTOBuilder toBuilder() =>
      BaseResponseBookDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseBookDTO &&
        code == other.code &&
        data == other.data &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BaseResponseBookDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseBookDTOBuilder
    implements Builder<BaseResponseBookDTO, BaseResponseBookDTOBuilder> {
  _$BaseResponseBookDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  BookDTOBuilder? _data;
  BookDTOBuilder get data => _$this._data ??= BookDTOBuilder();
  set data(BookDTOBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseBookDTOBuilder() {
    BaseResponseBookDTO._defaults(this);
  }

  BaseResponseBookDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _data = $v.data?.toBuilder();
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseResponseBookDTO other) {
    _$v = other as _$BaseResponseBookDTO;
  }

  @override
  void update(void Function(BaseResponseBookDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseBookDTO build() => _build();

  _$BaseResponseBookDTO _build() {
    _$BaseResponseBookDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseBookDTO._(
            code: code,
            data: _data?.build(),
            message: message,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BaseResponseBookDTO',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
