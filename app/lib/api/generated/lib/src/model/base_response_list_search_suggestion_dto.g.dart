// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_search_suggestion_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListSearchSuggestionDTO
    extends BaseResponseListSearchSuggestionDTO {
  @override
  final int? code;
  @override
  final BuiltList<SearchSuggestionDTO>? data;
  @override
  final String? message;

  factory _$BaseResponseListSearchSuggestionDTO([
    void Function(BaseResponseListSearchSuggestionDTOBuilder)? updates,
  ]) =>
      (BaseResponseListSearchSuggestionDTOBuilder()..update(updates))._build();

  _$BaseResponseListSearchSuggestionDTO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListSearchSuggestionDTO rebuild(
    void Function(BaseResponseListSearchSuggestionDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListSearchSuggestionDTOBuilder toBuilder() =>
      BaseResponseListSearchSuggestionDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListSearchSuggestionDTO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListSearchSuggestionDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListSearchSuggestionDTOBuilder
    implements
        Builder<
          BaseResponseListSearchSuggestionDTO,
          BaseResponseListSearchSuggestionDTOBuilder
        > {
  _$BaseResponseListSearchSuggestionDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<SearchSuggestionDTO>? _data;
  ListBuilder<SearchSuggestionDTO> get data =>
      _$this._data ??= ListBuilder<SearchSuggestionDTO>();
  set data(ListBuilder<SearchSuggestionDTO>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListSearchSuggestionDTOBuilder() {
    BaseResponseListSearchSuggestionDTO._defaults(this);
  }

  BaseResponseListSearchSuggestionDTOBuilder get _$this {
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
  void replace(BaseResponseListSearchSuggestionDTO other) {
    _$v = other as _$BaseResponseListSearchSuggestionDTO;
  }

  @override
  void update(
    void Function(BaseResponseListSearchSuggestionDTOBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListSearchSuggestionDTO build() => _build();

  _$BaseResponseListSearchSuggestionDTO _build() {
    _$BaseResponseListSearchSuggestionDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListSearchSuggestionDTO._(
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
          r'BaseResponseListSearchSuggestionDTO',
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
