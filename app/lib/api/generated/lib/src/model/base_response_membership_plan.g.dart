// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_membership_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseMembershipPlan extends BaseResponseMembershipPlan {
  @override
  final int? code;
  @override
  final MembershipPlan? data;
  @override
  final String? message;

  factory _$BaseResponseMembershipPlan([
    void Function(BaseResponseMembershipPlanBuilder)? updates,
  ]) => (BaseResponseMembershipPlanBuilder()..update(updates))._build();

  _$BaseResponseMembershipPlan._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseMembershipPlan rebuild(
    void Function(BaseResponseMembershipPlanBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseMembershipPlanBuilder toBuilder() =>
      BaseResponseMembershipPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseMembershipPlan &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseMembershipPlan')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseMembershipPlanBuilder
    implements
        Builder<BaseResponseMembershipPlan, BaseResponseMembershipPlanBuilder> {
  _$BaseResponseMembershipPlan? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  MembershipPlanBuilder? _data;
  MembershipPlanBuilder get data => _$this._data ??= MembershipPlanBuilder();
  set data(MembershipPlanBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseMembershipPlanBuilder() {
    BaseResponseMembershipPlan._defaults(this);
  }

  BaseResponseMembershipPlanBuilder get _$this {
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
  void replace(BaseResponseMembershipPlan other) {
    _$v = other as _$BaseResponseMembershipPlan;
  }

  @override
  void update(void Function(BaseResponseMembershipPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseMembershipPlan build() => _build();

  _$BaseResponseMembershipPlan _build() {
    _$BaseResponseMembershipPlan _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseMembershipPlan._(
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
          r'BaseResponseMembershipPlan',
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
