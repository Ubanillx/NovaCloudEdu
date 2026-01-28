// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_book_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListBookDTO extends BaseResponseListBookDTO {
  @override
  final int? code;
  @override
  final BuiltList<BookDTO>? data;
  @override
  final String? message;

  factory _$BaseResponseListBookDTO([
    void Function(BaseResponseListBookDTOBuilder)? updates,
  ]) => (BaseResponseListBookDTOBuilder()..update(updates))._build();

  _$BaseResponseListBookDTO._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseListBookDTO rebuild(
    void Function(BaseResponseListBookDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListBookDTOBuilder toBuilder() =>
      BaseResponseListBookDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListBookDTO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListBookDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListBookDTOBuilder
    implements
        Builder<BaseResponseListBookDTO, BaseResponseListBookDTOBuilder> {
  _$BaseResponseListBookDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<BookDTO>? _data;
  ListBuilder<BookDTO> get data => _$this._data ??= ListBuilder<BookDTO>();
  set data(ListBuilder<BookDTO>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListBookDTOBuilder() {
    BaseResponseListBookDTO._defaults(this);
  }

  BaseResponseListBookDTOBuilder get _$this {
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
  void replace(BaseResponseListBookDTO other) {
    _$v = other as _$BaseResponseListBookDTO;
  }

  @override
  void update(void Function(BaseResponseListBookDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListBookDTO build() => _build();

  _$BaseResponseListBookDTO _build() {
    _$BaseResponseListBookDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListBookDTO._(
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
          r'BaseResponseListBookDTO',
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
