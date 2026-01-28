// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_knowledge_point.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListKnowledgePoint extends BaseResponseListKnowledgePoint {
  @override
  final int? code;
  @override
  final BuiltList<KnowledgePoint>? data;
  @override
  final String? message;

  factory _$BaseResponseListKnowledgePoint([
    void Function(BaseResponseListKnowledgePointBuilder)? updates,
  ]) => (BaseResponseListKnowledgePointBuilder()..update(updates))._build();

  _$BaseResponseListKnowledgePoint._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListKnowledgePoint rebuild(
    void Function(BaseResponseListKnowledgePointBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListKnowledgePointBuilder toBuilder() =>
      BaseResponseListKnowledgePointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListKnowledgePoint &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListKnowledgePoint')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListKnowledgePointBuilder
    implements
        Builder<
          BaseResponseListKnowledgePoint,
          BaseResponseListKnowledgePointBuilder
        > {
  _$BaseResponseListKnowledgePoint? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<KnowledgePoint>? _data;
  ListBuilder<KnowledgePoint> get data =>
      _$this._data ??= ListBuilder<KnowledgePoint>();
  set data(ListBuilder<KnowledgePoint>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListKnowledgePointBuilder() {
    BaseResponseListKnowledgePoint._defaults(this);
  }

  BaseResponseListKnowledgePointBuilder get _$this {
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
  void replace(BaseResponseListKnowledgePoint other) {
    _$v = other as _$BaseResponseListKnowledgePoint;
  }

  @override
  void update(void Function(BaseResponseListKnowledgePointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListKnowledgePoint build() => _build();

  _$BaseResponseListKnowledgePoint _build() {
    _$BaseResponseListKnowledgePoint _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListKnowledgePoint._(
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
          r'BaseResponseListKnowledgePoint',
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
