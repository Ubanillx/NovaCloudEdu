// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateOrderRequest extends CreateOrderRequest {
  @override
  final int courseId;

  factory _$CreateOrderRequest([
    void Function(CreateOrderRequestBuilder)? updates,
  ]) => (CreateOrderRequestBuilder()..update(updates))._build();

  _$CreateOrderRequest._({required this.courseId}) : super._();
  @override
  CreateOrderRequest rebuild(
    void Function(CreateOrderRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateOrderRequestBuilder toBuilder() =>
      CreateOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateOrderRequest && courseId == other.courseId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'CreateOrderRequest',
    )..add('courseId', courseId)).toString();
  }
}

class CreateOrderRequestBuilder
    implements Builder<CreateOrderRequest, CreateOrderRequestBuilder> {
  _$CreateOrderRequest? _$v;

  int? _courseId;
  int? get courseId => _$this._courseId;
  set courseId(int? courseId) => _$this._courseId = courseId;

  CreateOrderRequestBuilder() {
    CreateOrderRequest._defaults(this);
  }

  CreateOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _courseId = $v.courseId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateOrderRequest other) {
    _$v = other as _$CreateOrderRequest;
  }

  @override
  void update(void Function(CreateOrderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateOrderRequest build() => _build();

  _$CreateOrderRequest _build() {
    final _$result =
        _$v ??
        _$CreateOrderRequest._(
          courseId: BuiltValueNullFieldError.checkNotNull(
            courseId,
            r'CreateOrderRequest',
            'courseId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
